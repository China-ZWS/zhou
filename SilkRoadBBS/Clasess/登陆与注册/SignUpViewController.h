//
//  SignUpViewController.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJTableViewController.h"
typedef NS_ENUM(NSInteger, SignType)
{
    kDefault_sign_up = 0,
    kWechat_sign_up
    
};

@interface SignUpViewController : PJTableViewController
- (instancetype)initWithType:(SignType)signType;

@end
