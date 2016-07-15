//
//  VIPCenterViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "VIPCenterViewController.h"
#import "BBSNavOptionController.h"

@interface VIPCenterViewController ()

@end

@implementation VIPCenterViewController

- (id)initWithSuccess:(void(^)())success;
{
    if ((self = [super initWithSuccess:success])) {
        self.title = NSLocalizedString(@"VIPCenterViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
    }
    return self;
}


- (void)back
{
    [self popViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(@"/member/myOrderForum.jhtml")]]];
    
    [WebViewJavascriptBridge enableLogging];
    
    WEAKSELF
    [_bridge registerHandler:@"login" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [weakSelf gotoLogingWithSuccess:^(BOOL success)
         {
             [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(@"/member/myOrderForum.jhtml")]]];
             weakSelf.successBlock();
         }class:@"LoginViewController" ];
        responseCallback(@"Response from testObjcCallback");
    }];
    
    
    [_bridge registerHandler:@"getForumTopic" handler:^(id data, WVJBResponseCallback responseCallback) {
        BBSNavOptionController *bbs = [[BBSNavOptionController alloc] initWithViewControllers:@[[[DirectoryViewController alloc] initWithForumId:data[@"forumId"]],[[BoardViewController alloc] initWithForumId:data[@"forumId"]]]];
        bbs.hidesBottomBarWhenPushed = YES;
        [weakSelf pushViewController:bbs];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
