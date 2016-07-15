//
//  RequestViewModels.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/17.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestViewModels : NSObject

/**
 *  @brief  发送短信验证(443)
 *
 *  @param ctr     当前请求的ViewController
 *  @param params  接口参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)requestWithVerfyCode:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  登录
 *
 *  @param ctr     当前请求的ViewController
 *  @param params  接口参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)requestWithUserLogin:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  快速注册(443)
 *
 *  @param ctr     当前请求的ViewController
 *  @param params  接口参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)requestWithUserReg:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;


/**
 *  @brief  用户信息完善接口
 *
 *  @param ctr     当前请求的ViewController
 *  @param params  接口参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)requestWithCompelteUserinfo:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  微信
 *
 *  @param ctr     当前请求的ViewController
 *  @param params  接口参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)requestWithCompanyQuery:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  微信
 *
 *  @param ctr     当前请求的ViewController
 *  @param params  接口参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)requestWithPositionQuery:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  忘记密码（443）
 *
 *  @param ctr     当前请求的ViewController
 *  @param params  接口参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)requestWithRetPassW:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  获取板块商品信息）
 *
 *  @param ctr     当前请求的ViewController
 *  @param params  接口参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)requestWithGetForumCommodity:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  微信登陆
 *
 *  @param ctr     当前请求的ViewController
 *  @param params  接口参数
 *  @param success 请求成功
 *  @param failure 请求失败
 */
+ (void)requestWithThirdReg:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  微信支付
 *
 *  @param ctr     <#ctr description#>
 *  @param params  <#params description#>
 *  @param success <#success description#>
 *  @param failure <#failure description#>
 */
+ (void)requestWithWeixinPay:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  回帖
 */
+ (void)requestWithSubmitReply:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief 板块列表(需要登录)

 */
+ (void)requestWithGetForumInfo:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief 发帖或编辑发帖 (需要登录)
 
 */
+ (void)requestWithSubmitTopic:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

/**
 *  @brief  图片上传中（需要登陆）
 *
 */
+ (void)requestWithUploadPic:(UIViewController *)ctr params:(id)params success:(void(^)(id))success failure:(void(^)(NSString *,NSString*))failure;

@end
