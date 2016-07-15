//
//  PostFooterView.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostFooterView : UICollectionReusableView
@property (nonatomic, copy) void(^pushForumInfo)();
@property (nonatomic, copy) void(^showSelectedTitle)(NSString *);
@end

