//
//  NVBnbCollectionView.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import <UIKit/UIKit.h>

#import "NVBnbCollectionViewLayout.h"

@class NVBnbCollectionView;
@class NVBnbCollectionViewParallaxCell;

@protocol NVBnbCollectionViewDataSource <NSObject>

- (NSInteger)numberOfItemsInBnbCollectionView:(NVBnbCollectionView *)collectionView;
- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NVBnbCollectionViewParallaxCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (UICollectionReusableView *)bnbCollectionView:(NVBnbCollectionView *)collectionView headerAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)bnbCollectionView:(NVBnbCollectionView *)collectionView moreLoaderAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface NVBnbCollectionView : UICollectionView <UICollectionViewDataSource>

@end
