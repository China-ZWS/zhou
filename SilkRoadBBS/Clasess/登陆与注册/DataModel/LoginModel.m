//
//  LoginModel.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/5.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "LoginModel.h"

@implementation LoginModel
+ (void )createData:(NSString *)responseString success:(void (^)(id data))success failure:(void (^)(NSString *msg, NSString *status))failure;
{
    NSLog(@"%@",responseString);
    NSError *error = nil;
    NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    
    
    
    

    NSString *reCode = dict[@"reCode"];
    NSString *note = dict[@"note"];
    NSString *status = dict[@"status"];
    NSString *returnMsg = dict[@"returnMsg"];
    
    if ([reCode isEqualToString:@"000"])
    {
        if (status.integerValue == 1 || status.integerValue == 5) {
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
