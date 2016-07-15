//
//  keychainItemManager.m
//  TalkWeb
//
//  Created by 周文松 on 14-3-12.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "keychainItemManager.h"

@implementation keychainItemManager
static NSString * const KEY_COOKIE = @"com.talkWeb.app.Cookie";

static NSString * const KEY_DATAS = @"com.talkWeb.app.Datas";
static NSString * const KEY_NAME = @"com.talkWeb.app.Name";
static NSString * const KEY_PASSWORD = @"com.talkWeb.app.Password";
static NSString * const KEY_PhoneNum = @"com.talkWeb.app.PhoneNum";
static NSString * const KEY_SessionId = @"com.talkWeb.app.SessionId";
static NSString *const KEY_HasSupplyPwd = @"com.talkWeb.app.HasSupplyPwd";
static NSString *const KEY_UserID = @"com.talkWeb.app.UserID";


/*****写入信息******/

+ (void)writeCookie:(id)datas;
{
    if (datas)
    {
        [KeychainItemWrapper write:KEY_COOKIE data:datas];
    }
}

+ (void)writeDatas:(id)datas;
{
    if (datas)
    {
        [KeychainItemWrapper write:KEY_DATAS data:datas];
    }

}

+ (void)writeName:(NSString *)name;
{
    if (name.length!= 0)
    {
        [KeychainItemWrapper write:KEY_NAME data:name];
    }
}


+ (void)writePassWord:(NSString *)passWord;
{
    if (passWord.length!= 0)
    {
        [KeychainItemWrapper write:KEY_PASSWORD data:passWord];
    }
}


+ (void)writePhoneNum:(NSString *)PhoneNum;
{
    if (PhoneNum.length !=0)
    {
        [KeychainItemWrapper write:KEY_PhoneNum data:PhoneNum];

    }
}



+ (void)writeSessionId:(NSString *)sessionId;
{
    if (sessionId.length!= 0)
    {
        [KeychainItemWrapper write:KEY_SessionId data:sessionId];
    }

}

+ (void)writeUserID:(NSString *)userID;
{
    if (userID.length!= 0)
    {
        [KeychainItemWrapper write:KEY_UserID data:userID];
    }

}


+ (void)writehasSupplyPwd:(id)hasSupplyPwd;
{
    [KeychainItemWrapper write:KEY_HasSupplyPwd data:hasSupplyPwd];

}




/********读取信息**********/

+ (id)readCookie
{
    
    return [KeychainItemWrapper read:KEY_COOKIE];
}

+(id)readDatas
{
    return [KeychainItemWrapper read:KEY_DATAS];

}

+(id)readName;
{
    return [KeychainItemWrapper read:KEY_NAME];
}


+(id)readSessionId;
{
    return [KeychainItemWrapper read:KEY_SessionId];

}

+(id)readPassWord
{
    return [KeychainItemWrapper read:KEY_PASSWORD];
}

+(id)readPhoneNum;
{
    return [KeychainItemWrapper read:KEY_PhoneNum];
}

+(id)readUserID;
{
    return [KeychainItemWrapper read:KEY_UserID];
}

+(id)readHasSupplyPwd;
{
    return [KeychainItemWrapper read:KEY_HasSupplyPwd];
}


/********删除信息**********/

+ (void)deleteCookie
{
    [KeychainItemWrapper deleteInformation:KEY_COOKIE];
}

+(void)deleteDatas;
{
    [KeychainItemWrapper deleteInformation:KEY_DATAS];
}

+(void)deleteName;
{
    [KeychainItemWrapper deleteInformation:KEY_NAME];
}

+(void)deletePhoneNum;
{
    [KeychainItemWrapper deleteInformation:KEY_PhoneNum];
}


+ (void)deleteSessionId;
{
    [KeychainItemWrapper deleteInformation:KEY_SessionId];
}

+ (void)deleteHasSupplyPwd;
{
    [KeychainItemWrapper deleteInformation:KEY_HasSupplyPwd];
}



+ (void)deletePassWord;
{
    [KeychainItemWrapper deleteInformation:KEY_PASSWORD];
}

+ (void)deleteUserId;
{
    [KeychainItemWrapper deleteInformation:KEY_UserID];
}



@end
