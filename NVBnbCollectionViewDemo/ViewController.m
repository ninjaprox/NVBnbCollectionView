//
//  ViewController.m
//  NVBnbCollectionViewDemo
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import "ViewController.h"

#import "NVBnbCollectionViewParallaxCell.h"

@implementation ViewController {
    IBOutlet NVBnbCollectionView *_collectionView;
    NSInteger _numberOfItems;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _numberOfItems = 20;
    [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:NVBnbCollectionElementKindHeader withReuseIdentifier:@"headerCell"];
}

#pragma mark - NVBnbCollectionViewDataSource

- (NSInteger)numberOfItemsInBnbCollectionView:(NVBnbCollectionView *)collectionView {
    return _numberOfItems;
}

- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UIImageView *imageView;
    
    if (cell.contentView.subviews.count == 0) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imageView];
        
        imageView.translatesAutoresizingMaskIntoConstraints = NO;
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:imageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:cell attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    } else {
        imageView = cell.contentView.subviews[0];
    }
    
    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"image-%ld", indexPath.row % 10 ]];
    
    return cell;
}

- (NVBnbCollectionViewParallaxCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NVBnbCollectionViewParallaxCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"parallaxCell" forIndexPath:indexPath];
    UILabel *label;
    
    cell.backgroundColor = [UIColor whiteColor];
    cell.parallaxImage = [UIImage imageNamed:[NSString stringWithFormat:@"image-%ld", indexPath.row % 10]];
    label.text = [[NSString alloc] initWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

- (UICollectionReusableView *)bnbCollectionView:(NVBnbCollectionView *)collectionView headerAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *header = [_collectionView dequeueReusableSupplementaryViewOfKind: NVBnbCollectionElementKindHeader withReuseIdentifier:@"headerCell" forIndexPath:indexPath];
    
    header.backgroundColor = [UIColor grayColor];
    if (header.subviews.count == 0) {
        UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 100)];
        
        textView.font = [UIFont systemFontOfSize:50];
        textView.backgroundColor = [UIColor grayColor];
        textView.textColor = [UIColor whiteColor];
        textView.text = @"Header";
        [header addSubview:textView];
    }
    
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
    _numberOfItems += 20;
    collectionView.loadingMore = false;
    [collectionView reloadData];
}

@end
