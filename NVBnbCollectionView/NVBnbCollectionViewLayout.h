//
//  UICollectionViewBnbLayout.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import <UIKit/UIKit.h>

@interface NVBnbCollectionViewLayout : UICollectionViewLayout

@property (nonatomic) CGFloat gridCellWidth;
@property (nonatomic) CGFloat gridCellHeight;
@property (nonatomic) CGFloat parallaxCellWidth;
@property (nonatomic) CGFloat parallaxCellHeight;
@property (nonatomic) CGFloat gridCellHorizontalSpacing;
@property (nonatomic) CGFloat gridCellVerticalSpacing;
@property (nonatomic) CGFloat gridPadding;
@property (nonatomic) CGFloat maxParallaxOffset;

@end
