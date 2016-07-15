//
//  BaseNavOptionViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "BaseNavOptionViewController.h"
#import "SegmentBar.h"
#import "SegmentBarItem.h"

#define INDICATOR_HEIGHT 3

@interface BaseNavOptionViewController ()
<UICollectionViewDataSource, UICollectionViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *viewControllers;
@property (nonatomic) NSInteger selectedIndex;

@property (nonatomic, strong) SegmentBar *segmentBar;
@property (nonatomic, strong) UIScrollView *slideView;
@property (nonatomic, strong) UIView *indicatorBgView;
@property (nonatomic, strong, readonly) UIView *indicator;

@property (nonatomic, strong) UICollectionViewFlowLayout *segmentBarLayout;


@end

@implementation BaseNavOptionViewController

- (id)initWithViewControllers:(NSArray *)viewControllers;
{
    if ((self = [super init])) {
        _viewControllers = viewControllers;
        _selectedTitleColor = [UIColor whiteColor];
        _titleColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - 初始化segmentBarLayout
- (UICollectionViewFlowLayout *)segmentBarLayout
{
    if (!_segmentBarLayout) {
        _segmentBarLayout = [[UICollectionViewFlowLayout alloc] init];
        _segmentBarLayout.itemSize = CGSizeMake(150 / _viewControllers.count, 30);
        _segmentBarLayout.sectionInset = UIEdgeInsetsZero;
        _segmentBarLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _segmentBarLayout.minimumLineSpacing = 0;
        _segmentBarLayout.minimumInteritemSpacing = 0;
    }
    return _segmentBarLayout;
}



#pragma mark - 初始化segmentBar
- (UICollectionView *)segmentBar
{
    if (!_segmentBar) {
        _segmentBar = [[SegmentBar alloc] initWithFrame:CGRectMake(0, 0, 150, 30) collectionViewLayout:self.segmentBarLayout];
        _segmentBar.backgroundColor = [UIColor clearColor];
        _segmentBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _segmentBar.dataSource = self;
        _segmentBar.delegate = self;
        [_segmentBar registerClass:[SegmentBarItem class] forCellWithReuseIdentifier:@"title"];

    }
    return _segmentBar;
}


#pragma mark - 初始化线条
- (UIView *)indicatorBgView
{
    if (!_indicatorBgView)
    {
        CGRect frame = CGRectMake(5, _segmentBar.height - INDICATOR_HEIGHT - 1,
                                  _segmentBar.width / _viewControllers.count - 10, INDICATOR_HEIGHT);
        _indicatorBgView = [[UIView alloc] initWithFrame:frame];
        _indicatorBgView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _indicatorBgView.backgroundColor = [UIColor whiteColor];
    }
    return _indicatorBgView;
}

#pragma mark - 初始化slideView
- (UIScrollView *)slideView
{
    if (!_slideView) {
        
        _slideView = [[UIScrollView alloc] initWithFrame:self.view.frame];
        _slideView.backgroundColor = [UIColor clearColor];
        [_slideView setShowsHorizontalScrollIndicator:NO];
        _slideView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_slideView setShowsVerticalScrollIndicator:NO];
        [_slideView setPagingEnabled:YES];
        [_slideView setBounces:NO];
        [_slideView setDelegate:self];
    }
    return _slideView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitleView:self.segmentBar];
    [self.view addSubview:self.slideView];
    [_segmentBar addSubview:self.indicatorBgView];
    [self reset];

}

#pragma mark - 初始化交互
- (void)reset
{
    _selectedIndex = NSNotFound;
    [self setSelectedIndex:0];
    [self scrollToViewWithIndex:0 animated:NO];
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    if ([_dataSource respondsToSelector:@selector(numberOfSectionsInslideSegment:)]) {
        return [_dataSource numberOfSectionsInslideSegment:collectionView];
    }
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if ([_dataSource respondsToSelector:@selector(slideSegment:numberOfItemsInSection:)]) {
        return [_dataSource slideSegment:collectionView numberOfItemsInSection:section];
    }
    
    return _viewControllers.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_dataSource respondsToSelector:@selector(slideSegment:cellForItemAtIndexPath:)]) {
        return [_dataSource slideSegment:collectionView cellForItemAtIndexPath:indexPath];
    }
    SegmentBarItem *segmentBarItem = [collectionView dequeueReusableCellWithReuseIdentifier:@"title" forIndexPath:indexPath];
    segmentBarItem.titleLabel.highlightedTextColor = _selectedTitleColor;
    segmentBarItem.titleLabel.textColor = _titleColor;
    if (_selectedIndex == indexPath.row) {
        segmentBarItem.titleLabel.highlighted = YES;
    }
    
    UIViewController *vc = _viewControllers[indexPath.row];
    segmentBarItem.titleLabel.text = vc.title;
    return segmentBarItem;
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row < 0 || indexPath.row >= _viewControllers.count) {
        return NO;
    }
    
    BOOL flag = YES;
    UIViewController *vc = _viewControllers[indexPath.row];
    if ([_delegate respondsToSelector:@selector(slideSegment:shouldSelectViewController:)]) {
        flag = [_delegate slideSegment:collectionView shouldSelectViewController:vc];
    }
    return flag;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row < 0 || indexPath.row >= _viewControllers.count) {
        return;
    }
    
    [self scrollToViewWithIndex:indexPath.row animated:YES];
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if (scrollView == _slideView) {
        // set indicator frame
        CGRect frame = _indicatorBgView.frame;
        CGFloat percent = scrollView.contentOffset.x / scrollView.contentSize.width;
        frame.origin.x = _segmentBar.frame.size.width * percent + 5;
        _indicatorBgView.frame = frame;
        NSInteger index = round(percent * _viewControllers.count);
        if (index >= 0 && index < _viewControllers.count)
        {
            [self setSelectedIndex:index];
        }
    }
}


- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    
    
    if (_selectedIndex == selectedIndex) {
        return;
    }
    
    SegmentBarItem *newItem = (SegmentBarItem *)[_segmentBar cellForItemAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]];
    newItem.titleLabel.highlighted = YES;
    
    SegmentBarItem *oldItem = (SegmentBarItem *)[_segmentBar cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_selectedIndex inSection:0]];
    oldItem.titleLabel.highlighted = NO;
    
    
    NSParameterAssert(selectedIndex >= 0 && selectedIndex < _viewControllers.count);
    
    UIViewController *toSelectController = [_viewControllers objectAtIndex:selectedIndex];
    if ([_delegate respondsToSelector:@selector(slideSegment:didSelectedViewController:index:)]) {
        [_delegate slideSegment:_segmentBar didSelectedViewController:toSelectController index:selectedIndex];
    }
    
    
    //    toSelectController.title
    // Add selected view controller as child view controller
    if (!toSelectController.parentViewController) {
        [self addChildViewController:toSelectController];
        CGRect rect = _slideView.bounds;
        rect.origin.x = rect.size.width * selectedIndex;
        toSelectController.view.frame = rect;
        [_slideView addSubview:toSelectController.view];
        [toSelectController didMoveToParentViewController:self];
    }
    [self.view endEditing:YES];
    _selectedIndex = selectedIndex;
}


- (void)scrollToViewWithIndex:(NSInteger)index animated:(BOOL)animated;
{
    CGRect rect = _slideView.bounds;
    rect.origin.x = rect.size.width * index;
    [_slideView setContentOffset:CGPointMake(rect.origin.x, rect.origin.y) animated:animated];
}


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    CGSize conentSize = CGSizeMake(self.view.frame.size.width * _viewControllers.count, 0);
    [_slideView setContentSize:conentSize];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
