//
//  UICollectionViewBnbLayout.m
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import "NVBnbCollectionViewLayout.h"

#define GRID_CELL_WIDTH 100
#define GRID_CELL_HEIGHT 100
#define GRID_CELL_VERTICAL_SPACING 10
#define GRID_CELL_HORIZONTAL_SPACING 10
#define GRID_PADDING 20
#define PARALLAX_CELL_WIDTH 200
#define PARALLAX_CELL_HEIGHT 200
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

@implementation NVBnbCollectionViewLayout {
    NSInteger _contentHeight;
    NSMutableDictionary *_cellAttributes;
    NSInteger _groupFullHeight;
}

- (void)prepareLayout {
    NSLog(@"prepareLayout");
    
    [self setDefaultValues];
    
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:SECTION];
    
    // Calculate content height
    _groupFullHeight = self.gridCellHeight * 6 + self.gridCellVerticalSpacing * 4 + self.parallaxCellHeight * 2 + self.gridPadding * 4;
    _contentHeight = _groupFullHeight * numberOfItems / 10;
    
    NSInteger numberOfItemsInLastGroup = numberOfItems % 10;
    
    if (numberOfItemsInLastGroup > 1) {
        _contentHeight += self.gridCellHeight + self.gridCellVerticalSpacing + self.gridPadding;
    }
    if (numberOfItemsInLastGroup > 3) {
        _contentHeight += self.parallaxCellHeight + self.gridPadding;
    }
    if (numberOfItemsInLastGroup > 4) {
        _contentHeight += self.gridCellHeight;
    }
    if (numberOfItemsInLastGroup > 6) {
        _contentHeight += self.gridCellHeight * 2 + self.gridCellVerticalSpacing;
    }
    if (numberOfItemsInLastGroup > 7) {
        _contentHeight += self.gridCellHeight + self.gridPadding;
    }
    if (numberOfItemsInLastGroup > 8) {
        _contentHeight += self.parallaxCellHeight;
    }
    
    // Calculate cell width
    self.gridCellWidth = (self.collectionView.frame.size.width - self.gridCellHorizontalSpacing - self.gridPadding * 2) / 2;
    self.parallaxCellWidth = self.collectionView.frame.size.width;
    
    // Calculate cell attributes
    _cellAttributes = [[NSMutableDictionary alloc] initWithCapacity:numberOfItems];
    for (NSInteger itemCount = 0; itemCount < numberOfItems; itemCount++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:SECTION];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        [_cellAttributes setObject:attributes forKey:indexPath];
    }
    
    CGFloat x = self.gridPadding;
    CGFloat y = self.gridPadding;
    
    for (NSInteger itemCount = 0; itemCount < numberOfItems; itemCount++) {
        NSInteger indexInGroup = itemCount % NUMBER_OF_ITEMS_IN_GROUP;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:SECTION];
        UICollectionViewLayoutAttributes *attributes = [_cellAttributes objectForKey:indexPath];
        CGRect frame = CGRectZero;
        
        switch (indexInGroup) {
            case 0:
                frame = CGRectMake(x, y, self.gridCellWidth, self.gridCellHeight);
                
                break;
            case 1:
                frame = CGRectMake(x + self.gridCellWidth + self.gridCellHorizontalSpacing, y, self.gridCellWidth, self.gridCellHeight * 2 + self.gridCellVerticalSpacing);
                y += frame.size.height + self.gridPadding;
                
                break;
            case 2:
                frame = CGRectMake(x, y - self.gridCellHeight - self.gridPadding, self.gridCellWidth, self.gridCellHeight);
                
                break;
            case 3:
                frame = CGRectMake(0, y, self.parallaxCellWidth, self.parallaxCellHeight);
                y += frame.size.height + self.gridPadding;
                
                break;
            case 4:
                frame = CGRectMake(x, y, self.gridCellWidth, self.gridCellHeight);
                
                break;
            case 5:
                frame = CGRectMake(x + self.gridCellWidth + self.gridCellHorizontalSpacing, y, self.gridCellWidth, self.gridCellHeight);
                y += frame.size.height + self.gridCellVerticalSpacing;
                
                break;
            case 6:
                frame = CGRectMake(x, y, self.gridCellWidth * 2 + self.gridCellHorizontalSpacing, self.gridCellHeight * 2 + self.gridCellVerticalSpacing);
                y += frame.size.height + self.gridCellVerticalSpacing;
                
                break;
            case 7:
                frame = CGRectMake(x, y, self.gridCellWidth, self.gridCellHeight);
                
                break;
            case 8:
                frame = CGRectMake(x + self.gridCellWidth + self.gridCellHorizontalSpacing, y, self.gridCellWidth, self.gridCellHeight);
                y += frame.size.height + self.gridPadding;
                
                break;
            case 9:
                frame = CGRectMake(0, y, self.parallaxCellWidth, self.parallaxCellHeight);
                y += frame.size.height + self.gridPadding;
                
                break;
                
            default:
                break;
        }
        attributes.frame = frame;
    }
}

- (CGSize)collectionViewContentSize {
    NSLog(@"collectionViewContentSize");
    
    CGFloat width = self.collectionView.frame.size.width;
    
    return CGSizeMake(width, _contentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@"layoutAttributesForElementsInRect");
    
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:10];
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger itemCount = 0; itemCount < numberOfItems; itemCount++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:SECTION];
        UICollectionViewLayoutAttributes *attributes = [_cellAttributes objectForKey:indexPath];
        
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [result addObject:attributes];
        }
    }
    
    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [_cellAttributes objectForKey:indexPath];
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

- (void)setDefaultValues {
    self.gridCellWidth = GRID_CELL_WIDTH;
    self.gridCellHeight = GRID_CELL_HEIGHT;
    self.parallaxCellWidth = PARALLAX_CELL_WIDTH;
    self.parallaxCellHeight = PARALLAX_CELL_HEIGHT;
    self.gridCellHorizontalSpacing = GRID_CELL_HORIZONTAL_SPACING;
    self.gridCellVerticalSpacing = GRID_CELL_VERTICAL_SPACING;
    self.gridPadding = GRID_PADDING;
    self.maxParallaxOffset = MAX_PARALLAX_OFFSET;
}

@end
