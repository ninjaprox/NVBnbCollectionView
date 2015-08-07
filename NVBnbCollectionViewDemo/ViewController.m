//
//  ViewController.m
//  NVBnbCollectionViewDemo
//
//  Created by Nguyen Vinh on 8/7/15.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label;
    
    if (cell.contentView.subviews.count == 0) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        [cell.contentView addSubview:label];
    } else {
        label = cell.contentView.subviews[0];
    }
    
    cell.backgroundColor = [UIColor yellowColor];
    label.text = [[NSString alloc] initWithFormat:@"%d", indexPath.row];
    NSLog(@"Cell's subviews: %@", cell.contentView.subviews);
    
    return cell;
}

@end
