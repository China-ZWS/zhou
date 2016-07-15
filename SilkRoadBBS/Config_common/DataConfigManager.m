//
//  DataConfigManager.m
//  NetSchool
//
//  Created by 周文松 on 15/8/28.
//  Copyright (c) 2015年 TalkWeb. All rights reserved.
//

#import "DataConfigManager.h"

@implementation DataConfigManager
+ (NSDictionary *)returnRoot;
{
    NSString *path=[[NSBundle mainBundle] pathForResource:@"Config" ofType:@"plist"];
    NSDictionary *root=[[NSDictionary alloc] initWithContentsOfFile:path];
    return root;

}

+ (NSArray *)getMainTab;
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"MainTab"]];
    return data;
}

+ (NSArray *)getSignUpList;
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"SignUpList"]];
    return data;
}

+ (NSArray *)getReSignUpList;
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"ReSignUpList"]];
    return data;
}

+ (NSArray *)getForgetPwdList;
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"ForgetPwdList"]];
    return data;
}

+ (NSArray *)getProfileList;
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"MyProfileList"]];
    return data;
}

+ (NSArray *)getVIPMembersList;
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"VIPMembersList"]];
    return data;
}

+ (NSArray *)getVIPPayTypelist;
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"VIPPayTypelist"]];
    return data;

}

+ (NSArray *)getUserInfolist;
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"UserInfolist"]];
    return data;
}

+ (NSArray *)getSettiogslist
{
    NSDictionary * root = [self returnRoot];
    NSArray *data=[[NSArray alloc] initWithArray:[root objectForKey:@"SettingList"]];
    return data;
}
@end
