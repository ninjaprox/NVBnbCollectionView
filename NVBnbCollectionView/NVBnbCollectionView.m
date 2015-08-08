//
//  NVBnbCollectionView.m
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import "NVBnbCollectionView.h"

@implementation NVBnbCollectionView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self.dataSource = self;
    
    return [super initWithCoder:aDecoder];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self.dataSource = self;
    
    return [super initWithFrame:frame];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if ([self.bnbDataSource respondsToSelector:@selector(numberOfItemsInCollectionView:)]) {
        return [self.bnbDataSource numberOfItemsInCollectionView:self];
    }
    
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (![self.bnbDataSource respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]
        || ![self.bnbDataSource respondsToSelector:@selector(collectionView:parallaxCellForItemAtIndexPath:)]) {
        return nil;
    }
    
    if ((indexPath.row % 10 % 3 == 0) && (indexPath.row % 10 / 3 % 2 == 1)) {
        return [self.bnbDataSource collectionView:self parallaxCellForItemAtIndexPath:indexPath];
    }
    
    return [self.bnbDataSource collectionView:self cellForItemAtIndexPath:indexPath];
}

@end
