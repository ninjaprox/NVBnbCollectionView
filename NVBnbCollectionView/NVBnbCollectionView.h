//
//  NVBnbCollectionView.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import <UIKit/UIKit.h>

@class NVBnbCollectionView;
@class NVBnbCollectionViewParallaxCell;

@protocol NVBnbCollectionViewDataSource <NSObject>

- (NSInteger)numberOfItemsInBnbCollectionView:(NVBnbCollectionView *)collectionView;
- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (NVBnbCollectionViewParallaxCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
- (UICollectionReusableView *)viewForHeaderInBnbCollectionView:(NVBnbCollectionView *)collectionView;

@end

@interface NVBnbCollectionView : UICollectionView <UICollectionViewDataSource>

@end
