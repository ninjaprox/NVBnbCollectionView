//
//  NVBnbCollectionViewLayoutTest.m
//  NVBnbCollectionView
//
//  Created by Nguyen Vinh on 9/22/15.
//
//

#import <XCTest/XCTest.h>

#import "NVBnbCollectionViewLayout.h"
#import "NVBnbCollectionView.h"
#import "NVBnbCollectionViewParallaxCell.h"

#pragma mark - Fake objects

@interface FakeDataSource : NSObject <NVBnbCollectionViewDataSource>

@end

@implementation FakeDataSource

- (NSInteger)numberOfItemsInBnbCollectionView:(NVBnbCollectionView *)collectionView {
    NSLog(@"numberOfItemsInBnbCollectionView");
    
    return 10;
}

- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[UICollectionViewCell alloc] init];
}

- (NVBnbCollectionViewParallaxCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [[NVBnbCollectionViewParallaxCell alloc] init];
}

@end

#pragma mark - Tests

@interface NVBnbCollectionViewLayoutTest : XCTestCase

@end

@implementation NVBnbCollectionViewLayoutTest {
    NVBnbCollectionViewLayout *_collectionViewLayout;
    NVBnbCollectionView *_collectionView;
    FakeDataSource *_dataSource;
}

- (void)setUp {
    [super setUp];
    
    _dataSource = [[FakeDataSource alloc] init];
    _collectionViewLayout = [[NVBnbCollectionViewLayout alloc] init];
    _collectionView = [[NVBnbCollectionView alloc] initWithFrame:CGRectMake(0, 0, 100, 100) collectionViewLayout:_collectionViewLayout];
    _collectionView.dataSource = _dataSource;
    
    [_collectionView reloadData];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testShouldInvalidLayout {
    CGRect zeroBounds = CGRectZero;
    CGRect shouldInvalidateBounds= CGRectMake(0, 0, 100, 100);
    
    XCTAssertFalse([_collectionViewLayout shouldInvalidateLayoutForBoundsChange: zeroBounds], @"Layout should not invalidate");
    XCTAssertTrue([_collectionViewLayout shouldInvalidateLayoutForBoundsChange: shouldInvalidateBounds], @"Layout should invalidate");
    XCTAssertFalse([_collectionViewLayout shouldInvalidateLayoutForBoundsChange: shouldInvalidateBounds], @"Layout should not invalidate");
    shouldInvalidateBounds.size.width = 200;
    XCTAssertTrue([_collectionViewLayout shouldInvalidateLayoutForBoundsChange: shouldInvalidateBounds], @"Layout should invalidate");
    shouldInvalidateBounds.size.height = 200;
    XCTAssertTrue([_collectionViewLayout shouldInvalidateLayoutForBoundsChange: shouldInvalidateBounds], @"Layout should invalidate");
}

- (void)testLayoutAttributesForHeader {
    XCTAssertNil([_collectionViewLayout layoutAttributesForSupplementaryViewOfKind:NVBnbCollectionElementKindHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]]);
}

@end

