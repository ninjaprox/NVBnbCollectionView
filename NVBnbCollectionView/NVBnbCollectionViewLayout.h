//
//  UICollectionViewBnbLayout.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *NVBnbCollectionElementKindHeader;
UIKIT_EXTERN NSString *NVBnbCollectionElementKindMoreLoader;

/**
 *  Main layout for `NVBnbCollectionView`.
 */
@interface NVBnbCollectionViewLayout : UICollectionViewLayout

/**
 *  Grid cell size. Default value is (200, 100).
 */
@property (nonatomic) IBInspectable CGSize gridCellSize;

/**
 *  Parallax cell size. Default value is (400, 200).
 */
@property (nonatomic) IBInspectable CGSize parallaxCellSize;

/**
 *  Header size. Default value is (200, 200).
 *
 *  Set (0, 0) for no header
 */
@property (nonatomic) IBInspectable CGSize headerSize;

/**
 *  Size for more loader section. Default value is (50, 50).
 */
@property (nonatomic) IBInspectable CGSize moreLoaderSize;

/**
 *  Space between grid cells. Default value is (10, 10).
 */
@property (nonatomic) IBInspectable CGSize gridCellSpacing;

/**
 *  Padding for grid. Default value is 20.
 */
@property (nonatomic) IBInspectable CGFloat gridPadding;

/**
 *  Maximum parallax offset. Default value is 50.
 */
@property (nonatomic) IBInspectable CGFloat maxParallaxOffset;

/**
 *  Current orientation, used to layout correctly corresponding to orientation.
 */
@property (nonatomic) UIInterfaceOrientation currentOrientation;

@end
