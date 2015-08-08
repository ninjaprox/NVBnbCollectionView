//
//  NVBnbCollectionView.h
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 8/8/15.
//
//

#import <UIKit/UIKit.h>

@class NVBnbCollectionView;

@protocol NVBnbCollectionViewDataSource <NSObject>

- (NSInteger)numberOfItemsInBnbCollectionView:(NVBnbCollectionView *)collectionView;
- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface NVBnbCollectionView : UICollectionView <UICollectionViewDataSource>

@end
