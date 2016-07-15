//
//  DataConfigManager.h
//  NetSchool
//
//  Created by 周文松 on 15/8/28.
//  Copyright (c) 2015年 TalkWeb. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataConfigManager : NSObject
/**
 *  @brief  获取根目录
 *
 *  @return 返回根目录
 */
+ (NSDictionary *)returnRoot;

/**
 *  @brief  获取TabBar数据
 *
 *  @return 返回首页数据
 */
+ (NSArray *)getMainTab;

+ (NSArray *)getSignUpList;

+ (NSArray *)getReSignUpList;

+ (NSArray *)getForgetPwdList;

+ (NSArray *)getProfileList;

+ (NSArray *)getVIPMembersList;

+ (NSArray *)getVIPPayTypelist;

+ (NSArray *)getUserInfolist;

+ (NSArray *)getSettiogslist;

@end
