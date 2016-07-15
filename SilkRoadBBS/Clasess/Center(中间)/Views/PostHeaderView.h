//
//  PostHeaderView.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PostHeaderView : UICollectionReusableView
@property (nonatomic,copy) void(^changeText)(NSString *, NSString *);
@end
