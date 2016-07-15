//
//  PostViewProtocol.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostItem.h"
#import "PostHeaderView.h"
#import "PostFooterView.h"

@protocol PostViewProtocolDelegat <NSObject>
@optional
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath;
- (void)collectionView:(UICollectionView *)collectionView fieldText:(NSString *)fieldText viewText:(NSString *)viewText;
- (void)collectionViewWithPushForumInfo:(UICollectionView *)collectionView;
- (void)deleteItem:(PostItem *)item;
@end

@interface PostViewProtocol : NSObject
<UICollectionViewDelegate, UICollectionViewDataSource, PostItemDelegate>
@property (nonatomic) NSMutableArray *images;
@property (nonatomic, weak) id<PostViewProtocolDelegat>delegate;

- (void)showSeleteedTitle:(NSString *)title;
@end
