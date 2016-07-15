//
//  BaseModel.m
//  BabyStory
//
//  Created by 周文松 on 14-11-18.
//  Copyright (c) 2014年 com.talkweb.BabyStory. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

+ (void )createData:(NSString *)responseString success:(void (^)(id data))success failure:(void (^)(NSString *msg, NSString *status))failure;
{
    NSLog(@"%@",responseString);
    NSError *error = nil;
    NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];

    
    

    NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    NSString *reCode = dict[@"reCode"];
    NSString *note = dict[@"note"];
    NSString *status = dict[@"status"];
    NSString *returnMsg = dict[@"returnMsg"];

    if ([reCode isEqualToString:@"000"])
    {
        if (status.integerValue == 1) {
            success(dict);
        }
        else
        {
            failure(returnMsg,status);
        }
    }
    else
    {
        failure(note,reCode);
    }
}

@end
