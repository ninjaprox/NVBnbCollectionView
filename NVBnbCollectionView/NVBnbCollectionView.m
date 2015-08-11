//
//  NVBnbCollectionView.m
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import "NVBnbCollectionView.h"

#import "NVBnbCollectionViewParallaxCell.h"
#import "NVBnbCollectionViewLayout.h"

@implementation NVBnbCollectionView {
    __weak id<NVBnbCollectionViewDataSource> _bnbDataSource;
    CADisplayLink *_displayLink;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setUpParallax];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUpParallax];
    }
    
    return self;
}

- (void)dealloc {
    [_displayLink invalidate];
}

- (void)setDataSource:(id<UICollectionViewDataSource>)dataSource {
    [super setDataSource:self];
    
    _bnbDataSource = (id<NVBnbCollectionViewDataSource>) dataSource;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([_bnbDataSource respondsToSelector:@selector(numberOfItemsInBnbCollectionView:)]) {
        return [_bnbDataSource numberOfItemsInBnbCollectionView:self];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![_bnbDataSource respondsToSelector:@selector(bnbCollectionView:cellForItemAtIndexPath:)]
        || ![_bnbDataSource respondsToSelector:@selector(bnbCollectionView:parallaxCellForItemAtIndexPath:)]) {
        return nil;
    }
    
    if ((indexPath.row % 10 % 3 == 0) && (indexPath.row % 10 / 3 % 2 == 1)) {
        NVBnbCollectionViewParallaxCell *cell = [_bnbDataSource bnbCollectionView:self parallaxCellForItemAtIndexPath:indexPath];
        NVBnbCollectionViewLayout *layout = (NVBnbCollectionViewLayout *) collectionView.collectionViewLayout;
        
        cell.maxParallaxOffset = layout.maxParallaxOffset;
        
        return cell;
    }
    
    return [_bnbDataSource bnbCollectionView:self cellForItemAtIndexPath:indexPath];
}

#pragma mark - Parallax

- (void)setUpParallax {
    __weak id weakSelf = self;
    
    _displayLink = [CADisplayLink displayLinkWithTarget:weakSelf selector:@selector(doParallax:)];
    [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)doParallax:(CADisplayLink *)displayLink {
    NSLog(@"doParallax");
    
    NSArray *visibleCells = self.visibleCells;
    
    for (UICollectionViewCell *cell in visibleCells) {
        if ([cell isKindOfClass:[NVBnbCollectionViewParallaxCell class]]) {
            NVBnbCollectionViewParallaxCell *parallaxCell = (NVBnbCollectionViewParallaxCell *) cell;
            
            CGRect bounds = self.bounds;
            CGPoint boundsCenter = CGPointMake(CGRectGetMidX(bounds), CGRectGetMidY(bounds));
            CGPoint cellCenter = parallaxCell.center;
            CGPoint offsetFromCenter = CGPointMake(boundsCenter.x - cellCenter.x, boundsCenter.y - cellCenter.y);
            CGSize cellSize = parallaxCell.bounds.size;
            CGFloat maxVerticalOffset = (bounds.size.height / 2) + (cellSize.height / 2);
            CGFloat scaleFactor = parallaxCell.maxParallaxOffset / maxVerticalOffset;
            CGPoint parallaxOffset = CGPointMake(0.0, -offsetFromCenter.y * scaleFactor);
            
            parallaxCell.parallaxImageOffset = parallaxOffset;
        }
    }
}

@end
