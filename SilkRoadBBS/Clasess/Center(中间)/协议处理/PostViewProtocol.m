//
//  PostViewProtocol.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PostViewProtocol.h"


@interface PostViewProtocol ()
{
    PostFooterView *_footerview;
}
@end
@implementation PostViewProtocol

#pragma mark - UICollectionViewDelegate
- (instancetype)init
{
    if ((self = [super init])) {
        _images = NSMutableArray.new;
    }
    return self;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        PostHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
        __weak id<PostViewProtocolDelegat>SafeDelegate = _delegate;
        headerView.changeText = ^(NSString *fieldText, NSString *viewText)
        {
            [SafeDelegate collectionView:collectionView fieldText:fieldText viewText:viewText];
        };
        reusableview = headerView;
    }
    if (kind == UICollectionElementKindSectionFooter){
        
        _footerview = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        __weak id<PostViewProtocolDelegat>SafeDelegate = _delegate;
        _footerview.pushForumInfo = ^{
            [SafeDelegate collectionViewWithPushForumInfo:collectionView];
        };
        reusableview = _footerview;
    }
    return reusableview;
}

- (void)showSeleteedTitle:(NSString *)title;
{
    _footerview.showSelectedTitle(title);
}



#pragma mark -- UICollectionViewDataSource

//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PostItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (!cell.delegate) {
        cell.delegate = self;
    }
    [cell setDatas:_images indexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_delegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)] && [_delegate conformsToProtocol:@protocol(PostViewProtocolDelegat)])
    {
        [_delegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
    }

}

- (void)eventWithDelete:(UIButton *)btn
{
    PostItem *cell = [UIView getView:btn toClass:@"PostItem"];
    if ([_delegate respondsToSelector:@selector(deleteItem:)] && [_delegate conformsToProtocol:@protocol(PostViewProtocolDelegat)])
    {
        [_delegate deleteItem:cell];
    }

    
}

@end
