//
//  RequestViewModels.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/17.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "RequestViewModels.h"
#import "LoginModel.h"
#import "CompanyQueryModel.h"

@implementation RequestViewModels

+ (void)requestWithPublic:(id)params netWorkProtocol:(NSString *)netWorkProtocol success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure
{
  
    [BaseModel POST:ServerUrl(netWorkProtocol) parameter:params   class:[BaseModel class] hasAsync:YES
            success:^(id datas)
     {
         success(datas);
     }
            failure:^(NSString *msg, NSString *status)
     {
         failure(msg,status);
     }];

}

#pragma mark - 登录
+ (void)requestWithUserLogin:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    NSString *mobile = params[@"mobile"];
    NSString *password = params[@"password"];
    
//    NSInteger show = NSLocalizedString(@"type",nil).integerValue;
//    if (show == 1) {
//        //中国
//        if (![NSObject isMobile:mobile])
//        {
//            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.correctPhoneNum",nil)];
//            return;
//        }
//        
//    }
//    else
//    {
//        if (![NSObject isValidateEmail:mobile]) {
//            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.correctEmail",nil)];
//            return;
//        }
//    }
//

    if (!(NSUInteger)password.length) {
        [SVProgressHUD showInfoWithStatus:@"请输入验证码"];
        return;
    }
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.login",nil)];
    [params setPublicDomain:userLogin];
  
    [LoginModel POST:ServerUrl(http) parameter:params   class:[LoginModel class] hasAsync:YES
            success:^(id datas)
     {
         success(datas);
     }
            failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
         failure(msg,status);
     }];

}

#pragma mark - 发送短信验证码
+ (void)requestWithVerfyCode:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
     
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.sending",nil)];
    [params setPublicDomain:verfyCode];
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];
}


#pragma mark - 注册（443）
+ (void)requestWithUserReg:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    
    
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.registering",nil)];
    [params setPublicDomain:userReg];
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];
}



#pragma mark - 用户信息完善接口
+ (void)requestWithCompelteUserinfo:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.submitting",nil)];
    [params setPublicDomain:compelteUserinfo];
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];
}

#pragma mark -  公司注册情况查询接口(微信)
+ (void)requestWithCompanyQuery:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.submitting",nil)];
    [params setPublicDomain:companyQuery];
    [CompanyQueryModel POST:ServerUrl(http) parameter:params   class:[CompanyQueryModel class] hasAsync:YES
             success:^(id datas)
     {
         success(datas);
     }
             failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
         failure(msg,status);
     }];
}

#pragma mark - 职位列表查询接口
+ (void)requestWithPositionQuery:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.loading",nil)];
    [params setPublicDomain:positionQuery];
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];
}


#pragma mark - 忘记密码(443)
+ (void)requestWithRetPassW:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.sending",nil)];
    [params setPublicDomain:retPassW];
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];
}

#pragma mark - 获取板块商品信息
+ (void)requestWithGetForumCommodity:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.loading",nil)];
    [params setPublicDomain:getForumCommodity];
    
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];
}

#pragma mark -微信登陆
+ (void)requestWithThirdReg:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.login",nil)];
    [params setPublicDomain:thirdReg];
    
    [LoginModel POST:ServerUrl(http) parameter:params   class:[LoginModel class] hasAsync:YES
             success:^(id datas)
     {
         success(datas);
     }
             failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
         failure(msg,status);
     }];

}

#pragma mark - 微信支付
+ (void)requestWithWeixinPay:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.loading",nil)];
    [params setPublicDomain:weixinPay];
    
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];

}

#pragma mark - 回帖
+ (void)requestWithSubmitReply:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.submitting",nil)];
    [params setPublicDomain:submitReply];
    
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];
}

#pragma mark - 板块列表(需要登录)
+ (void)requestWithGetForumInfo:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.loading",nil)];
    [params setPublicDomain:getForumInfo];
    
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];

}

#pragma mark - 发帖或编辑发帖 (需要登录)
+ (void)requestWithSubmitTopic:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [params setPublicDomain:submitTopic];
    
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];
}

#pragma mark - 用户图片上传(需要登录)
+ (void)requestWithUploadPic:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.uploadPic",nil)];
    [params setPublicDomain:uploadPic];
    
    [self requestWithPublic:params netWorkProtocol:http success:success failure:failure];
}

@end
