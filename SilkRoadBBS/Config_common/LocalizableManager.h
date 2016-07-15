//
//  LocalizableManage.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/9.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>



#define CHINESE @"zh-Hans"
#define ENGLISH @"en"
#define Localizable(key) [[LocalizableManager bundle] localizedStringForKey:(key) value:@"" table:nil]


@interface LocalizableManager : NSObject


+(NSBundle *)bundle;//获取当前资源文件

+(void)initUserLanguage;//初始化语言文件

+(NSString *)userLanguage;//获取应用当前语言

+(void)setUserlanguage:(NSString *)language;//设置当前语言
@end
