//
//  FunId.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/16.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "FunId.h"

NSString *const APPID = @"wx79bd1989e6ea1113";//微信APPID 应用唯一标识，在微信开放平台提交应用审核通过后获得
NSString *const SECRET = @"ee7ced492c8bfaeab970a1c17d261771";//应用授权作用域，如获取用户个人信息则填写snsapi_userinfo（


//NSString *const serverUrl = @"120.25.201.103:8081/jeebbs/comminterface.htm";//测试服务器地址
NSString *const serverUrl = @"120.25.201.103:80/jeebbs/comminterface.htm";//服务器地址
//NSString *const serverH5Url = @"http://120.25.201.103:8081/jeebbs";//测试H5服务器地址
NSString *const serverH5Url = @"http://120.25.201.103/jeebbs";//H5服务器地址
NSString *const thirdReg = @"thirdReg"; // 微信登陆
NSString *const weixinPay = @"weixinPay"; // 微信支付
NSString *const userLogin = @"userLogin"; //加入购物车（443）
NSString *const verfyCode = @"verfyCode"; // 发送短信验证
NSString *const userReg = @"userReg";// 快速注册（443）

NSString *const compelteUserinfo = @"compelteUserinfo"; //用户信息完善接口
NSString *const companyQuery = @"companyQuery"; // 公司注册情况查询接口
NSString *const positionQuery = @"positionQuery"; //职位列表查询接口
NSString *const retPassW = @"retPassW"; //忘记密码（找回密码）（443）
NSString *const getForumCommodity = @"getForumCommodity"; //获取板块商品信息
NSString *const submitReply = @"submitReply"; // 回帖
NSString *const getForumInfo = @"getForumInfo"; // 板块列表（需要登陆）
NSString *const submitTopic = @"submitTopic"; //发帖或编辑发帖 (需要登录)
NSString *const uploadPic = @"uploadPic"; // 图片上传
@implementation FunId


+ (id)setMethod:(NSString *)method;
{
    return [NSString stringWithFormat:@"%@://%@",method,serverUrl];
}

+ (id)setH5Method:(NSString *)method;
{
    return [serverH5Url stringByAppendingString:method];
}
@end