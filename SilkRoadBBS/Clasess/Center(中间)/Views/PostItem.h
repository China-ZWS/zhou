//
//  PostItem.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "BaseCollectionViewCell.h"

@protocol PostItemDelegate <NSObject>
@optional
- (void)eventWithDelete:(UIButton *)btn;
@end
@interface PostItem : BaseCollectionViewCell
@property (nonatomic, weak) id<PostItemDelegate>delegate;
- (void)setDatas:(id)datas indexPath:(NSIndexPath *)indexPath;
@end
