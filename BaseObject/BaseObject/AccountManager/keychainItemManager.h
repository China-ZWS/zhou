//
//  keychainItemManager.h
//  TalkWeb
//
//  Created by 周文松 on 14-3-12.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeychainItemWrapper.h"

@interface keychainItemManager : NSObject

+ (void)writeCookie:(id)datas;
+ (void)writeDatas:(id)datas;
+ (void)writeName:(NSString *)name;
+ (void)writePassWord:(NSString *)passWord;
+ (void)writePhoneNum:(NSString *)PhoneNum;
+ (void)writeSessionId:(NSString *)sessionId;
+ (void)writehasSupplyPwd:(id )hasSupplyPwd;
+ (void)writeUserID:(NSString *)userID;

+ (id)deleteCookie;
+(void)deleteDatas;
+ (void)deleteName;
+(void)deletePhoneNum;
+ (void)deleteSessionId;
+ (void)deletePassWord;
+ (void)deleteHasSupplyPwd;
+ (void)deleteUserId;

+(id)readCookie;
+(id)readDatas;
+(id)readName;
+(id)readPassWord;
+(id)readPhoneNum;
+(id)readSessionId;
+(id)readHasSupplyPwd;
+(id)readUserID;


@end
