//
//  NVCollectionViewParallaxCell.m
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import "NVBnbCollectionViewParallaxCell.h"

@implementation NVBnbCollectionViewParallaxCell {
    UIImageView *_parallaxImageView;
    NSLayoutConstraint *_parallaxImageViewHeightConstraint;
    NSLayoutConstraint *_parallaxImageViewCenterYConstraint;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUp];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    _parallaxImageView.image = nil;
}

- (void)setUp {
    _parallaxImageView = [[UIImageView alloc] init];
    _parallaxImageView.contentMode = UIViewContentModeScaleAspectFill;
    _parallaxImageView.clipsToBounds = true;
    _parallaxImageView.image = self.parallaxImage;
    [self.contentView insertSubview:_parallaxImageView atIndex:0];
    
    // Add constraints
    _parallaxImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _parallaxImageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_parallaxImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    _parallaxImageViewCenterYConstraint = [NSLayoutConstraint constraintWithItem:_parallaxImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_parallaxImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_parallaxImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
    [self.contentView addConstraint:_parallaxImageViewHeightConstraint];
    [self.contentView addConstraint:_parallaxImageViewCenterYConstraint];
}

- (void)setParallaxImage:(UIImage *)parallaxImage {
    _parallaxImage = parallaxImage;
    _parallaxImageView.image = _parallaxImage;
}

- (void)setParallaxImageOffset:(CGPoint)parallaxImageOffset {
    _parallaxImageViewCenterYConstraint.constant = parallaxImageOffset.y;
}

- (void)setMaxParallaxOffset:(CGFloat)maxParallaxOffset {
    _maxParallaxOffset = maxParallaxOffset;
    _parallaxImageViewHeightConstraint.constant = 2 * maxParallaxOffset;
}

@end
