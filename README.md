NVBnbCollectionView
===================

# Introduction

NVBnbCollectionView is an Airbnb-inspired collection view.

# Demo

## Portrait

![Portrait](https://raw.githubusercontent.com/ninjaprox/NVBnbCollectionView/master/Demo-portrait.gif)

## Landscape

![Landscpae](https://raw.githubusercontent.com/ninjaprox/NVBnbCollectionView/master/Demo-landscape.gif)

For first-hand experience, just open the project and run it.

# Installation

## Cocoapods

Install Cocoapods if need be

```bash
$ gem install cocoapods
```

Add NVActivityIndicatorView in your `Podfile`

```bash
pod 'NVBnbCollectionView'
```

Then, run the following command

```bash
$ pod install
```

## Manual

Copy NVBnbCollectionView folder to your project. That's it.

# Layout

To keep it simple in first version, I use fixed layout as in Airbnb app.

![Layout](https://raw.githubusercontent.com/ninjaprox/NVBnbCollectionView/master/Layout.jpg)

Cells with red border are parallax cell. Others are grid cell.

Green regions are grid padding `gridPadding`.

Orange regions are cell spacing `gridCellSpacing`.

## Size

In portrait, height of grid cell and parallax cell are specified in `gridCellSize` and `parallaxCellSize` respectively in layout, width will be calculated base on `gridPadding` and collection view width.

In landscape, width of grid cell and parallax cell are specified in `gridCellSize` and `parallaxCellSize` respectively in layout, height will be calculated base on `gridPadding` and collection view height.

This is also applied for others (i.e. header, more loader and spacing between grid cells).

# Usage

There is not much difference between `NVBnbCollectionView` and `UICollectionView`, so just use it as you normally do with `UICollectionView`.

## Storyboard

With storyboard, change class of collection view to `NVBnbCollectionView` and layout to `NVBnbCollectionViewLayout`.

All properties of layout are inspectable so you can change sizes in layout directly in storyboard. However, `IBInspectable` requires Xcode 6 and above.

## Code

If you create collection view from code, the following example can help:

```objective-c
NVBnbCollectionViewLayout *layout = [[NVBnbCollectionViewLayout alloc] init];
NVBnbCollectionView *collectionView = [[NVBnbCollectionView alloc] initWithFrame:CGRectMake(0, 0, 500, 500) collectionViewLayout:layout];

layout.gridCellSize = CGSizeMake(150, 150);
layout.parallaxCellSize = CGSizeMake(300, 300);
// Set other properties of layout if need be
```

Again, what you can do with `UICollectionView`, do the same with `NVBnbCollectionView`.

## Data source

Collection view needs data source to provide information about cells, your class must conform `NVBnbCollectionViewDatasource` and 3 required methods:

* `NVBnbCollectionView` needs to know how many items will be displayed:

```objective-c
- (NSInteger)numberOfItemsInBnbCollectionView:(NVBnbCollectionView *)collectionView;
```

* How a grid cell looks like:

```objective-c
- (UICollectionViewCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath;
```

* How a parallax cell looks like:

```objective-c
- (NVBnbCollectionViewParallaxCell *)bnbCollectionView:(NVBnbCollectionView *)collectionView parallaxCellForItemAtIndexPath:(NSIndexPath *)indexPath;
```

In addition, if collection view has header and load more ability, it should know how the header, more loader look like:

```objective-c
- (UICollectionReusableView *)bnbCollectionView:(NVBnbCollectionView *)collectionView headerAtIndexPath:(NSIndexPath *)indexPath;
```

```objective-c
- (UIView *)moreLoaderInBnbCollectionView:(NVBnbCollectionView *)collectionView;
```

If you do not provide more loader while `enableLoadMore` is `true`, `UIActivityIndicatorView` is used as default.
Would like nicer one? You can check [NVActivityIndicatorView](https://github.com/ninjaprox/NVActivityIndicatorView).

## Delegate

`NVBnbCollectionViewDelegate` is subclass of `UICollectionViewDelegate` so it inherits all abilities from its parent, plus one method to notify controller whenever the collection view needs more data.

```objective-c
- (void)loadMoreInBnbCollectionView:(NVBnbCollectionView *)collectionView;

```

# References

To create parallax effect, I read the following posts and borrowed a hunk of code. Read them if you want to know what happends behind the screen, not too complicated.

* [Parallax Scrolling as a Category on UICollectionView](http://www.kurutepe.com/2015/02/parallax-scrolling-as-a-category-on-uicollectionview/)
* [Parallax Scrolling](http://oleb.net/blog/2014/05/parallax-scrolling-collectionview/)

# License

The MIT License (MIT)

Copyright (c) 2015 Nguyen Vinh [@ninjaprox](http://twitter.com/ninjaprox)