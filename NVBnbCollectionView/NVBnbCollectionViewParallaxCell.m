//
//  NVCollectionViewParallaxCell.m
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import "NVBnbCollectionViewParallaxCell.h"

@implementation NVBnbCollectionViewParallaxCell {
    NSLayoutConstraint *_parallaxImageViewWidthConstraint;
    NSLayoutConstraint *_parallaxImageViewHeightConstraint;
    NSLayoutConstraint *_parallaxImageViewCenterXConstraint;
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
    _currentOrienration = UIInterfaceOrientationPortrait;
    _parallaxImageView = [[UIImageView alloc] init];
    _parallaxImageView.contentMode = UIViewContentModeScaleAspectFill;
    _parallaxImageView.clipsToBounds = true;
    _parallaxImageView.image = self.parallaxImage;
    [self.contentView insertSubview:_parallaxImageView atIndex:0];
    
    // Add constraints
    _parallaxImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _parallaxImageViewWidthConstraint = [NSLayoutConstraint constraintWithItem:_parallaxImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeWidth multiplier:1 constant:0];
    _parallaxImageViewHeightConstraint = [NSLayoutConstraint constraintWithItem:_parallaxImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeHeight multiplier:1 constant:0];
    _parallaxImageViewCenterXConstraint = [NSLayoutConstraint constraintWithItem:_parallaxImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    _parallaxImageViewCenterYConstraint = [NSLayoutConstraint constraintWithItem:_parallaxImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    [self.contentView addConstraint:_parallaxImageViewWidthConstraint];
    [self.contentView addConstraint:_parallaxImageViewHeightConstraint];
    [self.contentView addConstraint:_parallaxImageViewCenterXConstraint];
    [self.contentView addConstraint:_parallaxImageViewCenterYConstraint];
}

- (void)setParallaxImage:(UIImage *)parallaxImage {
    _parallaxImage = parallaxImage;
    _parallaxImageView.image = _parallaxImage;
}

- (void)setParallaxImageOffset:(CGPoint)parallaxImageOffset {
    _parallaxImageViewCenterXConstraint.constant = parallaxImageOffset.x;
    _parallaxImageViewCenterYConstraint.constant = parallaxImageOffset.y;
}

- (void)setMaxParallaxOffset:(CGFloat)maxParallaxOffset {
    _maxParallaxOffset = maxParallaxOffset;
    if (UIInterfaceOrientationIsPortrait(self.currentOrienration)) {
        _parallaxImageViewWidthConstraint.constant = 0;
        _parallaxImageViewHeightConstraint.constant = 2 * maxParallaxOffset;
    } else {
        _parallaxImageViewWidthConstraint.constant = 2 * maxParallaxOffset;
        _parallaxImageViewHeightConstraint.constant = 0;
    }
}

- (void)setCurrentOrienration:(UIInterfaceOrientation)currentOrienration {
    _currentOrienration = currentOrienration;
    self.maxParallaxOffset = _maxParallaxOffset;
}

@end
