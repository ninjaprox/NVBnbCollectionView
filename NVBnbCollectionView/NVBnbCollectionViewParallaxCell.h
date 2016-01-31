//
//  NVCollectionViewParallaxCell.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import <UIKit/UIKit.h>

/**
 *  Base class for parallax cell in `NVBnbCollectionView`. This provides built-in image view with parallax effect.
 */
@interface NVBnbCollectionViewParallaxCell : UICollectionViewCell

/**
 *  Image view is used for parallax effect.
 */
@property (strong, nonatomic) UIImageView *parallaxImageView;

/**
 *  Image is used for parallax effect.
 */
@property (strong, nonatomic) UIImage *parallaxImage;

/**
 *  Current offset of parallax image view.
 */
@property (nonatomic) CGPoint parallaxImageOffset;

/**
 *  Maximum offset for parallax image view.
 */
@property (nonatomic) CGFloat maxParallaxOffset;

/**
 *  Current orientation, used to adjust parallax image view corresponding to orientation.
 */
@property (nonatomic) UIInterfaceOrientation currentOrienration;

@end
