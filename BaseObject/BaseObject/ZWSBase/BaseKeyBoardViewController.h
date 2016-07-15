//
//  BaseKeyBoardViewController.h
//  BaseObject
//
//  Created by Song on 16/5/30.
//  Copyright © 2016年 TalkWeb. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseKeyBoardViewController : BaseViewController
@property (nonatomic) BOOL hasKeyboardnotificationCenter;
@property (nonatomic) BOOL hasTransform;
@property (nonatomic,copy) void(^getCalculateView)(UIScrollView *,UIView *,UIView *);

@end
