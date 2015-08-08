//
//  ViewController.m
//  NVBnbCollectionViewDemo
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - NVBnbCollectionViewDataSource

- (NSInteger)numberOfItemsInBnbCollectionView:(NVBnbCollectionView *)collectionView {
    return 100;
}

- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label;
    
    if (cell.contentView.subviews.count == 0) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        [cell.contentView addSubview:label];
    } else {
        label = cell.contentView.subviews[0];
    }
    
    cell.backgroundColor = [UIColor yellowColor];
    label.text = [[NSString alloc] initWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label;
    
    if (cell.contentView.subviews.count == 0) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        [cell.contentView addSubview:label];
    } else {
        label = cell.contentView.subviews[0];
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    label.text = [[NSString alloc] initWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

@end
