//
//  reSignUpViewController.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/12.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJTableViewController.h"

@interface ReSignUpViewController : PJTableViewController

/**
 *  @brief  实力方法
 *
 *  @param userId ID
 *  @param hasReg 有没有一级代理
 *
 *  @return 返回实例
 */
- (id)initWithUserId:(NSString *)userId hasReg:(BOOL)hasReg companyName:(NSString *)companyName;
@end
