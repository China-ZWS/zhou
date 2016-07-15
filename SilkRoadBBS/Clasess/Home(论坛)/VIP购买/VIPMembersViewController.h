//
//  VIPMembersViewController.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/4.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJTableViewController.h"

@interface VIPMembersViewController : PJTableViewController
@property (nonatomic, copy) void(^successBlock)();
@end
