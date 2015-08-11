//
//  UICollectionViewBnbLayout.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import <UIKit/UIKit.h>

@interface NVBnbCollectionViewLayout : UICollectionViewLayout

@property (nonatomic) CGSize gridCellSize;
@property (nonatomic) CGSize parallaxCellSize;
@property (nonatomic) CGSize gridCellSpacing;
@property (nonatomic) CGFloat gridPadding;
@property (nonatomic) CGFloat maxParallaxOffset;

@end
