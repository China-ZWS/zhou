//
//  LocalizableManage.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/9.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "LocalizableManager.h"



@interface LocalizableManager ()
@end


@implementation LocalizableManager


static NSBundle *bundle = nil;






+ ( NSBundle * )bundle
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *string = [def valueForKey:@"userLanguage"];
    //获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:string ofType:@"lproj"];
    return [NSBundle bundleWithPath:path];//生成bundle

}
+(void)initUserLanguage
{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *string = [def valueForKey:@"userLanguage"];
    if(string.length == 0){
        //获取系统当前语言版本
//        NSString *current = [[[NSBundle mainBundle] preferredLocalizations] objectAtIndex:0];
        NSString *current = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"]  objectAtIndex:0];
        if ([current hasPrefix:CHINESE]) //开头匹配
        {
            [def setValue:CHINESE forKey:@"userLanguage"];
            string = CHINESE;
        }
        else if ([current hasPrefix:ENGLISH])
        {
            [def setValue:ENGLISH forKey:@"userLanguage"];
            string = ENGLISH;
        }
        
        [def setValue:string forKey:@"userLanguage"];
        [def synchronize];//持久化，不加的话不会保存
    }
}

+(NSString *)userLanguage{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *language = [def valueForKey:@"userLanguage"];
    return language;
}

+(void)setUserlanguage:(NSString *)language{
    
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //1.第一步改变bundle的值
    
    //2.持久化
    [def setValue:language forKey:@"userLanguage"];
    [def synchronize];
}

@end
