//
//  NVCollectionViewParallaxCell.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import <UIKit/UIKit.h>

@interface NVBnbCollectionViewParallaxCell : UICollectionViewCell

@property (strong, nonatomic) UIImage *parallaxImage;
@property (nonatomic) CGPoint parallaxImageOffset;
@property (nonatomic) CGFloat maxParallaxOffset;
@property (nonatomic) UIInterfaceOrientationMask currentOrienration;

@end
