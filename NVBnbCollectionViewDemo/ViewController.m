//
//  ViewController.m
//  NVBnbCollectionViewDemo
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import "ViewController.h"

#import "NVBnbCollectionViewParallaxCell.h"

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
    UIImageView *imageView;
    
    if (cell.contentView.subviews.count == 0) {
        imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.bounds.size.width, cell.bounds.size.height)];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [cell.contentView addSubview:imageView];
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

@end
