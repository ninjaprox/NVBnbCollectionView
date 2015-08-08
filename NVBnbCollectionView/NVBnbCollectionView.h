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

- (NSInteger)numberOfItemsInCollectionView:(NVBnbCollectionView *)collectionView;
- (UICollectionViewCell *)collectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
- (UICollectionViewCell *)collectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface NVBnbCollectionView : UICollectionView <UICollectionViewDataSource>

@property (weak, nonatomic) id <NVBnbCollectionViewDataSource> bnbDataSource;

@end
