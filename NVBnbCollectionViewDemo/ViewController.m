//
//  ViewController.m
//  NVBnbCollectionViewDemo
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import "ViewController.h"

#import "ParallaxCell.h"
#import "GridCell.h"

@implementation ViewController {
    IBOutlet NVBnbCollectionView *_collectionView;
    NSInteger _numberOfItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numberOfItems = 10;
    [_collectionView registerNib:[UINib nibWithNibName:@"Header" bundle:nil] forSupplementaryViewOfKind:NVBnbCollectionElementKindHeader withReuseIdentifier:@"header"];
}

#pragma mark - NVBnbCollectionViewDataSource

- (NSInteger)numberOfItemsInBnbCollectionView:(NVBnbCollectionView *)collectionView {
    return _numberOfItems;
}

- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.label.text = [NSString stringWithFormat:@"Item %ld", indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image-%ld", indexPath.row % 10 ]];
    
    return cell;
}

- (NVBnbCollectionViewParallaxCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ParallaxCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"parallaxCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.parallaxImage = [UIImage imageNamed:[NSString stringWithFormat:@"image-%ld", indexPath.row % 10]];
    cell.label.text = [[NSString alloc] initWithFormat:@"Item %ld", (long)indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)bnbCollectionView:(NVBnbCollectionView *)collectionView headerAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *header = [_collectionView dequeueReusableSupplementaryViewOfKind: NVBnbCollectionElementKindHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    
    return header;
}

- (UIView *)bnbCollectionView:(NVBnbCollectionView *)collectionView moreLoaderAtIndexPath:(NSIndexPath *)indexPath {
    UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    
    view.color = [UIColor darkGrayColor];
    [view startAnimating];
    
    return view;
}

#pragma mark - NVBnbCollectionViewDelegate

- (void)loadMoreInBnbCollectionView:(NVBnbCollectionView *)collectionView {
    NSLog(@"loadMoreInBnbCollectionView:");
    if (_numberOfItems > 40) {
        collectionView.enableLoadMore = false;
        
        return;
    }
     _numberOfItems += 10;
    collectionView.loadingMore = false;
    [collectionView reloadData];
}

@end
