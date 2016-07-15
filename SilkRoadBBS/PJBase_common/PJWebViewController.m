//
//  PJWebViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJWebViewController.h"
#import "ReSignUpViewController.h"
#import "VIPMembersViewController.h"
#import "SignUpViewController.h"

@interface PJWebViewController ()

@end

@implementation PJWebViewController




- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bridge = [WebViewJavascriptBridge bridgeForWebView:_webView];
    [_bridge setWebViewDelegate:self];

    
    WEAKSELF    
    [_bridge registerHandler:@"login" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf gotoLogingWithSuccess:^(BOOL success)
         {
             [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.loginSuccess",nil)];
             [self successLogin];
         }class:@"LoginViewController" ];
        responseCallback(@"Response from testObjcCallback");
    }];

    
    [_bridge registerHandler:@"completeInfo" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        NSDictionary *infoDatas = [keychainItemManager readDatas];
        NSInteger regChannel = [infoDatas[@"userInfo"][@"regChannel"] integerValue];
        if (regChannel == 0) {
            // 自有
            ReSignUpViewController *ctr = [[ReSignUpViewController alloc] initWithUserId:infoDatas[@"userInfo"][@"userId"] hasReg:[infoDatas[@"hasReg"] boolValue] companyName:infoDatas[@"userInfo"][@"companyName"]];
            ctr.hidesBottomBarWhenPushed = YES;
            [self pushViewController:ctr];

        }
        else if (regChannel == 1)
        {  // 微信
            SignUpViewController *ctr = [[SignUpViewController alloc] initWithType:kWechat_sign_up];
            
            [self pushViewController:ctr];
            [SVProgressHUD dismiss];
        }
        
        responseCallback(@"Response from testObjcCallback");
    }];
    
    [_bridge registerHandler:@"purchasePermission" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        weakSelf.parameters = data;
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"public.alert.purchasePermission",nil) delegate:self cancelButtonTitle:NSLocalizedString(@"public.btnTitle.cancel", nil) otherButtonTitles:NSLocalizedString(@"public.btnTitle.confirm",nil), nil];
        [alert show];
        responseCallback(@"Response from testObjcCallback");
    }];

}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0);
{
    if (buttonIndex == alertView.firstOtherButtonIndex)
    {
        VIPMembersViewController *ctr = [[VIPMembersViewController alloc] initWithParameters:_parameters];
        ctr.hidesBottomBarWhenPushed = YES;
        [self pushViewController:ctr];
    }
}


- (void)successLogin;
{
    NSLog(@"successLogin");
}


- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.loading",nil)];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_webViewProgressView setProgress:progress animated:YES];
    //    self.title = [_webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}


- (void)addNavigationWithPresentViewController:(UIViewController *)controller;
{
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[PJNavigationBar class] toolbarClass:nil];
    nav.viewControllers = @[controller];
    [self presentViewController:nav];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillDisappear:(BOOL)animated
{
    [_webViewProgressView removeFromSuperview];

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
