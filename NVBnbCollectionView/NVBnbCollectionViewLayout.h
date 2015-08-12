//
//  UICollectionViewBnbLayout.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import <UIKit/UIKit.h>

#define NVBnbCollectionElementKindHeader @"Header"

@interface NVBnbCollectionViewLayout : UICollectionViewLayout

@property (nonatomic) CGSize gridCellSize;
@property (nonatomic) CGSize parallaxCellSize;
@property (nonatomic) CGSize headerSize;
@property (nonatomic) CGSize gridCellSpacing;
@property (nonatomic) CGFloat gridPadding;
@property (nonatomic) CGFloat maxParallaxOffset;
@property (nonatomic, readonly) UIInterfaceOrientationMask currentOrientation;

@end
