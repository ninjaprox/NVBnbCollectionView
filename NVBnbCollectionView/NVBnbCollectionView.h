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

/**
 * Data source for `NVBnbCollectionView`. A object that conforms this protocal is required to implement `numberOfItemsInBnbCollectionView:`, `bnbCollectionView:cellForItemAtIndexPath` and `bnbCollectionView:parallaxCellForItemAtIndexPath`.
 */
@protocol NVBnbCollectionViewDataSource <NSObject>

/**
 *  Return number of items in collection view.
 *
 *  @param collectionView The collection view using this data source.
 *
 *  @return Number of items in collection view.
 */
- (NSInteger)numberOfItemsInBnbCollectionView:(NVBnbCollectionView *)collectionView;

/**
 *  Return grid cell for collection view at specified index path.
 *
 *  @param collectionView The collection view using this data source.
 *  @param indexPath      The index path of grid cell.
 *
 *  @return Grid cell at index path.
 */
- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Return parallax cell for collection view at specified index path.
 *
 *  @param collectionView The collection view using this data source.
 *  @param indexPath      The index path of parallax cell.
 *
 *  @return Parallax cell at index path.
 */
- (NVBnbCollectionViewParallaxCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional
/**
 *  Return header of collection view. Header must be subclass of `UICollectionReusableView`.
 *
 *  @param collectionView The collection view using this data source.
 *  @param indexPath      Used to dequeue reusable view from collection view.
 *
 *  @return Header of collection view.
 */
- (UICollectionReusableView *)bnbCollectionView:(NVBnbCollectionView *)collectionView headerAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Return more loader view of collection view. This view will be added into the section at bottom of collection view.
 *
 *  @param collectionView The collection view using this data source.
 *
 *  @return More loader view of collection view.
 */
- (UIView *)moreLoaderInBnbCollectionView:(NVBnbCollectionView *)collectionView;

@end

/**
 *  Delegate for NVBnbCollectionView. This conforms `UICollectionViewDelegate` so that what can do with `UICollectionViewDelegate` can do with `NVBnbCollectionViewDelegate`.
 */
@protocol NVBnbCollectionViewDelegate <UICollectionViewDelegate>

@optional
/**
 *  Collection view delegates to this method once hitting most bottom.
 *
 *  @param collectionView The collection view using this delegate.
 */
- (void)loadMoreInBnbCollectionView:(NVBnbCollectionView *)collectionView;

@end

/**
 *  Airbnb inspired collection view with very easy use, just like `UICollectionView`.
 */
@interface NVBnbCollectionView : UICollectionView <UICollectionViewDataSource>

/**
 *  Indicate the collection view is waiting for loading more data.
 */
@property (nonatomic) BOOL loadingMore;

/**
 *  Indicate if the collection view has load more ability.
 */
@property (nonatomic) IBInspectable BOOL enableLoadMore;

@end
