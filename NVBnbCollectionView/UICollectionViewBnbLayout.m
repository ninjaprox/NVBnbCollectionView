//
//  UICollectionViewBnbLayout.m
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import "UICollectionViewBnbLayout.h"

NSInteger kGridCellWidth = 100;
NSInteger kGridCellHeigth = 100;
NSInteger kGridCellHorizontalSpacing = 10;
NSInteger kGridCellVerticalSpacing = 10;
NSInteger kGridColumns = 2;
NSInteger kGridRows = 2;
NSInteger kParallaxItemWidth;
NSInteger kParallaxItemHeight = 50;
NSInteger kNumberOfItemsInGroup = 10;
NSInteger kSection = 0;
NSInteger kGroupFullHeight;
NSInteger kSubgroupPadding = 20;

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
// Anotation:
// x: one cell
// ---: parallax effect
//
// Item at index 3 and 9 have parallax effect
// The rest separates into 2 subgroups:
// 1. 1 2
//    3 2
// 2. 1 2
//    3 3
//    4 5
//
// Notes:
// - Cell having the same number that is represent for item occuping multiple cells

@implementation UICollectionViewBnbLayout {
    NSInteger mContentHeight;
    NSMutableDictionary *mCellAtributes;
}

- (void)prepareLayout {
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:kSection];
    
    // Calculate content height
    kGroupFullHeight = kGridCellHeigth * 6 + kGridCellVerticalSpacing * 4 + kParallaxItemHeight * 2 + kSubgroupPadding + 4;
    mContentHeight = kGroupFullHeight * numberOfItems / 10;
    
    NSInteger numberOfItemsInLastGroup = numberOfItems % 10;
    
    if (numberOfItemsInLastGroup > 1) {
        mContentHeight += kGridCellHeigth + kGridCellVerticalSpacing + kSubgroupPadding;
    }
    if (numberOfItemsInLastGroup > 3) {
        mContentHeight += kParallaxItemHeight + kSubgroupPadding;
    }
    if (numberOfItemsInLastGroup > 4) {
        mContentHeight += kGridCellHeigth;
    }
    if (numberOfItemsInLastGroup > 6) {
        mContentHeight += kGridCellHeigth * 2 + kGridCellVerticalSpacing;
    }
    if (numberOfItemsInLastGroup > 7) {
        mContentHeight += kGridCellHeigth + kSubgroupPadding;
    }
    if (numberOfItemsInLastGroup > 8) {
        mContentHeight += kParallaxItemHeight;
    }
    
    // Calculate cell width
    kGridCellWidth = (self.collectionView.frame.size.width - kGridCellHorizontalSpacing - kSubgroupPadding * 2) / 2;
    kParallaxItemWidth = kGridCellWidth * 2 + kGridCellHorizontalSpacing;
    
    // Calculate cell attributes
    mCellAtributes = [[NSMutableDictionary alloc] initWithCapacity:numberOfItems];
    for (NSInteger itemCount = 0; itemCount < numberOfItems; itemCount++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:kSection];
        UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        
        [mCellAtributes setObject:attributes forKey:indexPath];
    }
    
    CGFloat x = kSubgroupPadding;
    CGFloat y = kSubgroupPadding;
    
    for (NSInteger itemCount = 0; itemCount < numberOfItems; itemCount++) {
        NSInteger indexInGroup = itemCount % kNumberOfItemsInGroup;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:kSection];
        UICollectionViewLayoutAttributes *attributes = [mCellAtributes objectForKey:indexPath];
        CGRect frame;
        
        switch (indexInGroup) {
            case 0:
                frame = CGRectMake(x, y, kGridCellWidth, kGridCellHeigth);
                
                break;
            case 1:
                frame = CGRectMake(x + kGridCellWidth + kGridCellHorizontalSpacing, y, kGridCellWidth, kGridCellHeigth * 2 + kGridCellVerticalSpacing);
                y += frame.size.height + kSubgroupPadding;
                
                break;
            case 2:
                frame = CGRectMake(x, y - kGridCellHeigth - kSubgroupPadding, kGridCellWidth, kGridCellHeigth);
                
                break;
            case 3:
                frame = CGRectMake(x, y, kParallaxItemWidth, kParallaxItemHeight);
                y += frame.size.height + kSubgroupPadding;
                
                break;
            case 4:
                frame = CGRectMake(x, y, kGridCellWidth, kGridCellHeigth);
                
                break;
            case 5:
                frame = CGRectMake(x + kGridCellWidth + kGridCellHorizontalSpacing, y, kGridCellWidth, kGridCellHeigth);
                y += frame.size.height + kGridCellVerticalSpacing;
                
                break;
            case 6:
                frame = CGRectMake(x, y, kGridCellWidth * 2 + kGridCellHorizontalSpacing, kGridCellHeigth * 2 + kGridCellVerticalSpacing);
                y += frame.size.height + kGridCellVerticalSpacing;
                
                break;
            case 7:
                frame = CGRectMake(x, y, kGridCellWidth, kGridCellHeigth);
                
                break;
            case 8:
                frame = CGRectMake(x + kGridCellWidth + kGridCellHorizontalSpacing, y, kGridCellWidth, kGridCellHeigth);
                y += frame.size.height + kSubgroupPadding;
                
                break;
            case 9:
                frame = CGRectMake(x, y, kParallaxItemWidth, kParallaxItemHeight);
                y += frame.size.height + kSubgroupPadding;
                
                break;
                
            default:
                break;
        }
        attributes.frame = frame;
    }
}

- (CGSize)collectionViewContentSize {
    CGFloat width = self.collectionView.frame.size.width;
    
    return CGSizeMake(width, mContentHeight);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray *result = [[NSMutableArray alloc] initWithCapacity:10];
    NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:0];
    
    for (NSInteger itemCount = 0; itemCount < numberOfItems; itemCount++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:itemCount inSection:kSection];
        UICollectionViewLayoutAttributes *attributes = [mCellAtributes objectForKey:indexPath];
        
        if (CGRectIntersectsRect(rect, attributes.frame)) {
            [result addObject:attributes];
        }
    }
    
    return result;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSLog(@"layoutAttributesForItemAtIndexPath");
    attributes.frame = CGRectMake(0, 0, 100, 100);
    
    
    return attributes;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return true;
}

@end
