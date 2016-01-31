//
//  UICollectionViewBnbLayout.m
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import "NVBnbCollectionViewLayout.h"

#import "NVBnbCollectionView.h"

#define GRID_CELL_SIZE CGSizeMake(200, 100)
#define GRID_CELL_SPACING CGSizeMake(10, 10)
#define GRID_PADDING 20
#define PARALLAX_CELL_SIZE CGSizeMake(400, 200)
#define HEADER_SIZE CGSizeMake(200, 200)
#define MORE_LOADER_SIZE CGSizeMake(50, 50)
#define NUMBER_OF_ITEMS_IN_GROUP 10
#define SECTION 0
#define MAX_PARALLAX_OFFSET 50

// For fixed layout, group 10 items to one group
// Each group has the following layout:
// x x
// x x
// ---
// x x
// x x
// x x
// ---
//
// Annotation:
// x: one cell
// ---: parallax effect
//
// Item at index 3 and 9 have parallax effect
// The rest separates into 2 grids:
// 1. 1 2
//    3 2
// 2. 1 2
//    3 3
//    4 5
//
// Notes:
// - Cell having the same number that is represent for item occuping multiple cells

NSString *NVBnbCollectionElementKindHeader = @"Header";
NSString *NVBnbCollectionElementKindMoreLoader = @"MoreLoader";

@implementation NVBnbCollectionViewLayout {
    CGSize _contentSize;
    CGSize _groupSize;
    CGSize _internalGridCellSize;
    CGSize _internalParallaxCellSize;
    CGSize _previousBoundsSize;
    NSMutableDictionary *_cellAttributes;
    UICollectionViewLayoutAttributes *_headerAttributes;
    UICollectionViewLayoutAttributes *_moreLoaderAttributes;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setDefaultValues];
    }
    
    return self;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setDefaultValues];
    }
    
    return self;
}

- (void)prepareLayout {
    _internalGridCellSize = self.gridCellSize;
    _internalParallaxCellSize = self.parallaxCellSize;
    
    // Calculate content height
    [self calculateContentSize];
    
    // Calculate cell size
    [self calculateCellSize];
    
    // Calculate cell attributes
    [self calculateCellAttributes];
    
    // Calculate header attributes
    [self calculateHeaderAttributes];
    
    // Calculate more loader attributes
    [self calculateMoreLoaderAttributes];
}

- (CGSize)collectionViewContentSize {
    return _contentSize;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:10];
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger itemCount = 0; itemCount < numberOfItems; itemCount++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:SECTION];
        UICollectionViewLayoutAttributes *attributes = [_cellAttributes objectForKey:indexPath];
        
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [result addObject:attributes];
        }
    }
    
    // Add header attributes to array if it is in rect
    if (_headerAttributes && CGRectIntersectsRect(rect, _headerAttributes.frame)) {
        [result addObject:_headerAttributes];
    }
    
    // Add more loader attributes to array if it is in rect
    if (_moreLoaderAttributes && CGRectIntersectsRect(rect, _moreLoaderAttributes.frame)) {
        [result addObject:_moreLoaderAttributes];
    }
    
    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [_cellAttributes objectForKey:indexPath];
    
    return attributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath {
    return _headerAttributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    if (!CGSizeEqualToSize(_previousBoundsSize, newBounds.size)) {
        _previousBoundsSize = newBounds.size;
        
        return true;
    }
    
    return false;
}

#pragma mark - Calculation methods

- (void)calculateContentSize {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:SECTION];
    
    if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
        _groupSize.width = self.collectionView.bounds.size.width;
        _groupSize.height = _internalGridCellSize.height * 6 + self.gridCellSpacing.height * 4 + _internalParallaxCellSize.height * 2 + self.gridPadding * 4;
        _contentSize.width = self.collectionView.bounds.size.width;
        _contentSize.height = _groupSize.height * (numberOfItems / 10);
    } else {
        _groupSize.width = _internalGridCellSize.width * 6 + self.gridCellSpacing.width * 4 + _internalParallaxCellSize.width * 2 + self.gridPadding * 4;
        _groupSize.height = self.collectionView.bounds.size.height;
        _contentSize.width = _groupSize.width * (numberOfItems / 10);
        _contentSize.height = self.collectionView.bounds.size.height;
    }
    
    NSInteger numberOfItemsInLastGroup = numberOfItems % 10;
    BOOL enableLoadMore = ((NVBnbCollectionView *) self.collectionView).enableLoadMore;
    
    if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
        if (numberOfItemsInLastGroup > 0) {
            _contentSize.height += _internalGridCellSize.height + self.gridPadding;
        }
        if (numberOfItemsInLastGroup > 1) {
            _contentSize.height += _internalGridCellSize.height + self.gridCellSpacing.height;
        }
        if (numberOfItemsInLastGroup > 3) {
            _contentSize.height += _internalParallaxCellSize.height + self.gridPadding;
        }
        if (numberOfItemsInLastGroup > 4) {
            _contentSize.height += _internalGridCellSize.height + self.gridPadding;
        }
        if (numberOfItemsInLastGroup > 6) {
            _contentSize.height += _internalGridCellSize.height * 2 + self.gridCellSpacing.height * 2;
        }
        if (numberOfItemsInLastGroup > 7) {
            _contentSize.height += _internalGridCellSize.height + self.gridCellSpacing.height;
        }
        _contentSize.height += self.headerSize.height;
        _contentSize.height += (enableLoadMore) ? self.moreLoaderSize.height : 0;
    } else {
        if (numberOfItemsInLastGroup > 0) {
            _contentSize.width += _internalGridCellSize.width + self.gridPadding;
        }
        if (numberOfItemsInLastGroup > 1) {
            _contentSize.width += _internalGridCellSize.width + self.gridCellSpacing.width;
        }
        if (numberOfItemsInLastGroup > 3) {
            _contentSize.width += _internalParallaxCellSize.width + self.gridPadding;
        }
        if (numberOfItemsInLastGroup > 4) {
            _contentSize.width += _internalGridCellSize.width + self.gridPadding;
        }
        if (numberOfItemsInLastGroup > 5) {
            _contentSize.width += _internalGridCellSize.width * 2 + self.gridCellSpacing.width * 2;
        }
        if (numberOfItemsInLastGroup > 7) {
            _contentSize.width += _internalGridCellSize.width + self.gridCellSpacing.width;
        }
        _contentSize.width += self.headerSize.width;
        _contentSize.width += (enableLoadMore) ? self.moreLoaderSize.width : 0;
    }
}

- (void)calculateCellSize {
    if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
        _internalGridCellSize.width = (self.collectionView.frame.size.width - self.gridCellSpacing.width - self.gridPadding * 2) / 2;
        _internalParallaxCellSize.width = self.collectionView.frame.size.width;
    } else {
        _internalGridCellSize.height = (self.collectionView.frame.size.height - self.gridCellSpacing.height - self.gridPadding * 2) / 2;
        _internalParallaxCellSize.height = self.collectionView.frame.size.height;
    }
}

- (void)calculateCellAttributes {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:SECTION];
    
    _cellAttributes = [[NSMutableDictionary alloc] initWithCapacity:numberOfItems];
    for (NSInteger itemCount = 0; itemCount < numberOfItems; itemCount++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:SECTION];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        [_cellAttributes setObject:attributes forKey:indexPath];
    }
    
    CGFloat x = self.gridPadding;
    CGFloat y = self.gridPadding;
    
    // Give space for header
    if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
        y += self.headerSize.height;
    } else {
        x += self.headerSize.width;
    }
    
    for (NSInteger itemCount = 0; itemCount < numberOfItems; itemCount++) {
        NSInteger indexInGroup = itemCount % NUMBER_OF_ITEMS_IN_GROUP;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:SECTION];
        UICollectionViewLayoutAttributes *attributes = [_cellAttributes objectForKey:indexPath];
        CGRect frame = CGRectZero;
        
        if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
            switch (indexInGroup) {
                case 0:
                    frame = CGRectMake(x, y, _internalGridCellSize.width, _internalGridCellSize.height);
                    
                    break;
                case 1:
                    frame = CGRectMake(x + _internalGridCellSize.width + self.gridCellSpacing.width, y, _internalGridCellSize.width, _internalGridCellSize.height * 2 + self.gridCellSpacing.height);
                    y += frame.size.height + self.gridPadding;
                    
                    break;
                case 2:
                    frame = CGRectMake(x, y - _internalGridCellSize.height - self.gridPadding, _internalGridCellSize.width, _internalGridCellSize.height);
                    
                    break;
                case 3:
                    frame = CGRectMake(0, y, _internalParallaxCellSize.width, _internalParallaxCellSize.height);
                    y += frame.size.height + self.gridPadding;
                    
                    break;
                case 4:
                    frame = CGRectMake(x, y, _internalGridCellSize.width, _internalGridCellSize.height);
                    
                    break;
                case 5:
                    frame = CGRectMake(x + _internalGridCellSize.width + self.gridCellSpacing.width, y, _internalGridCellSize.width, _internalGridCellSize.height);
                    y += frame.size.height + self.gridCellSpacing.height;
                    
                    break;
                case 6:
                    frame = CGRectMake(x, y, _internalGridCellSize.width * 2 + self.gridCellSpacing.width, _internalGridCellSize.height * 2 + self.gridCellSpacing.height);
                    y += frame.size.height + self.gridCellSpacing.height;
                    
                    break;
                case 7:
                    frame = CGRectMake(x, y, _internalGridCellSize.width, _internalGridCellSize.height);
                    
                    break;
                case 8:
                    frame = CGRectMake(x + _internalGridCellSize.width + self.gridCellSpacing.width, y, _internalGridCellSize.width, _internalGridCellSize.height);
                    y += frame.size.height + self.gridPadding;
                    
                    break;
                case 9:
                    frame = CGRectMake(0, y, _internalParallaxCellSize.width, _internalParallaxCellSize.height);
                    y += frame.size.height + self.gridPadding;
                    
                    break;
                    
                default:
                    break;
            }
        } else {
            switch (indexInGroup) {
                case 0:
                    frame = CGRectMake(x, y, _internalGridCellSize.width, _internalGridCellSize.height);
                    
                    break;
                case 1:
                    frame = CGRectMake(x + _internalGridCellSize.width + self.gridCellSpacing.width, y, _internalGridCellSize.width, _internalGridCellSize.height * 2 + self.gridCellSpacing.height);
                    
                    break;
                case 2:
                    frame = CGRectMake(x, y + _internalGridCellSize.height + self.gridCellSpacing.height, _internalGridCellSize.width, _internalGridCellSize.height);
                    x += _internalGridCellSize.width * 2 + self.gridCellSpacing.width + self.gridPadding;
                    
                    break;
                case 3:
                    frame = CGRectMake(x, 0, _internalParallaxCellSize.width, _internalParallaxCellSize.height);
                    x += frame.size.width + self.gridPadding;
                    
                    break;
                case 4:
                    frame = CGRectMake(x, y, _internalGridCellSize.width, _internalGridCellSize.height);
                    
                    break;
                case 5:
                    frame = CGRectMake(x + _internalGridCellSize.width + self.gridCellSpacing.width, y, _internalGridCellSize.width * 2 + self.gridCellSpacing.width, _internalGridCellSize.height * 2 + self.gridCellSpacing.height);
                    
                    break;
                case 6:
                    frame = CGRectMake(x, y + _internalGridCellSize.height + self.gridCellSpacing.height, _internalGridCellSize.width, _internalGridCellSize.height);
                    x += _internalGridCellSize.width * 3 + self.gridCellSpacing.width * 3;
                    
                    break;
                case 7:
                    frame = CGRectMake(x, y, _internalGridCellSize.width, _internalGridCellSize.height);
                    
                    break;
                case 8:
                    frame = CGRectMake(x, y + _internalGridCellSize.height + self.gridCellSpacing.height, _internalGridCellSize.width, _internalGridCellSize.height);
                    x += frame.size.width + self.gridPadding;
                    
                    break;
                case 9:
                    frame = CGRectMake(x, 0, _internalParallaxCellSize.width, _internalParallaxCellSize.height);
                    x += frame.size.width + self.gridPadding;
                    
                    break;
                    
                default:
                    break;
            }
        }
        attributes.frame = frame;
    }
}

- (void)calculateHeaderAttributes {
    if (self.headerSize.width == 0 || self.headerSize.height == 0) {
        return;
    }
    
    _headerAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:NVBnbCollectionElementKindHeader withIndexPath:[NSIndexPath indexPathForRow:0 inSection:SECTION]];
    if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
        _headerAttributes.frame = CGRectMake(0, 0, self.collectionView.frame.size.width, self.headerSize.height);
    } else {
        _headerAttributes.frame = CGRectMake(0, 0, self.headerSize.width, self.collectionView.frame.size.height);
    }
}

- (void)calculateMoreLoaderAttributes {
    if (!((NVBnbCollectionView *) self.collectionView).enableLoadMore) {
        _moreLoaderAttributes = nil;
        
        return;
    }
    
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:SECTION];
    
    _moreLoaderAttributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:NVBnbCollectionElementKindMoreLoader withIndexPath:[NSIndexPath  indexPathForRow:numberOfItems - 1 inSection:SECTION]];
    if (UIInterfaceOrientationIsPortrait(self.currentOrientation)) {
        _moreLoaderAttributes.frame = CGRectMake(0, _contentSize.height - self.moreLoaderSize.height, self.collectionView.frame.size.width, self.moreLoaderSize.height);
    } else {
        _moreLoaderAttributes.frame = CGRectMake(_contentSize.width - self.moreLoaderSize.width, 0, self.moreLoaderSize.width, self.collectionView.frame.size.height);
    }
}

#pragma mark - Private methods

- (void)setDefaultValues {
    _previousBoundsSize = CGSizeZero;
    self.gridCellSize = GRID_CELL_SIZE;
    self.parallaxCellSize = PARALLAX_CELL_SIZE;
    self.gridCellSpacing = GRID_CELL_SPACING;
    self.headerSize = HEADER_SIZE;
    self.moreLoaderSize = MORE_LOADER_SIZE;
    self.gridPadding = GRID_PADDING;
    self.maxParallaxOffset = MAX_PARALLAX_OFFSET;
}

@end
