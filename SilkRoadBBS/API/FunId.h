//
//  FunId.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/16.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSMutableDictionary+PublicDomain.h"

typedef NS_ENUM(NSInteger, BusCode)
{
    kSignUp_BusCode = 0,  // 注册
    kChangePWD_BusCode = 1,  /// 修改密码.
    kRetrievePWD_BusCode = 2  /// 找回密码.
};


#define http @"http"
#define https @"https"
#define ServerUrl(method) [FunId setMethod:method]
#define ServerH5Url(method) [FunId setH5Method:method]

extern NSString *const APPID;//微信APPID 应用唯一标识，在微信开放平台提交应用审核通过后获得
extern NSString *const SECRET;//应用授权作用域，如获取用户个人信息则填写snsapi_userinfo（

extern NSString *const thirdReg; // 微信登陆
extern NSString *const userLogin; // 登陆（443）
extern NSString *const weixinPay; // 微信支付
extern NSString *const verfyCode; // 发送短信验证
extern NSString *const userReg;// 快速注册（443）

extern NSString *const compelteUserinfo; //用户信息完善接口
extern NSString *const companyQuery; // 公司注册情况查询接口
extern NSString *const positionQuery; //职位列表查询接口
extern NSString *const retPassW; //忘记密码（找回密码）（443）
extern NSString *const getForumCommodity; //获取板块商品信息
extern NSString *const submitReply; // 回帖
extern NSString *const getForumInfo; // 板块列表（需要登陆）
extern NSString *const submitTopic; //发帖或编辑发帖 (需要登录)
extern NSString *const uploadPic; // 图片上传

@interface FunId : NSObject

+ (id)setMethod:(NSString *)method;

+ (id)setH5Method:(NSString *)method;
@end