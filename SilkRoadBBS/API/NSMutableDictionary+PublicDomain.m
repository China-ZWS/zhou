//
//  NSMutableDictionary+PublicDomain.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/16.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "NSMutableDictionary+PublicDomain.h"
#import "UIDevice+IdentifierAddition.h"

@implementation NSMutableDictionary (PublicDomain)

- (void)setPublicDomain:(NSString *)fundId;
{
    
    self[@"channelNo"] = @"IOS_APP";
    self[@"funId"] = fundId;
    self[@"mobileImei"] = [self setMobileImei];
    self[@"requestId"] = [self setRequestId];
    self[@"md5Value"] = [self serMd5Value];
    self[@"mobileMac"] = [self setMobileMac];
    self[@"versionCode"] = [self setVersionCode];
    self[@"versionName"] = [self setVersionName];
    
}


- (NSString *) setMobileImei
{
    NSString * uuIdMd5 = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    
    return uuIdMd5;
}

- (NSString *)setRequestId
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    
    NSTimeInterval random=[NSDate timeIntervalSinceReferenceDate];
    NSString *randomString = [NSString stringWithFormat:@"%.10f",random];
    NSString *randompassword = [[randomString componentsSeparatedByString:@"."]objectAtIndex:1];
    
    NSString *requestId = [dateTime stringByAppendingString:randompassword];
    
    
    return requestId;
}

- (NSString *)serMd5Value
{
    NSString *requestId = self[@"requestId"];
    NSString *mobileImei = self[@"mobileImei"];
    NSString *identifier = @"TALKWEBLOTTERY";
    NSString *value = [[requestId stringByAppendingString:mobileImei] stringByAppendingString:identifier];
    NSString *md5Value = [value stringFromMD5:@""];
    
    return md5Value;
}

- (NSString *)setMobileMac
{
    return self[@"mobileImei"];
}

- (NSString *)setVersionCode
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];      //获取项目版本号
    return version;
}

- (NSString *)setVersionName
{
    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleExecutableKey];    //获取项目名称
    return executableFile;
}
@end
