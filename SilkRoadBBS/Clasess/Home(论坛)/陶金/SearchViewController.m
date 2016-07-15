//
//  SearchViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "SearchViewController.h"
#import "TopicDetailViewController.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (instancetype)init;
{
    if ((self = [super init])) {
        self.title = NSLocalizedString(@"SearchViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
    }
    return self;
}

- (void)back
{
    if ([_webView canGoBack]) {
        [_webView goBack];
    }
    else
    {
        [self popViewController];   
    }
    ;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(@"/topic/panGold.jhtml")]]];
    [WebViewJavascriptBridge enableLogging];
    WEAKSELF
    
    [_bridge registerHandler:@"getTopicDetail" handler:^(id data, WVJBResponseCallback responseCallback) {
        [weakSelf pushViewController:[[TopicDetailViewController alloc] initWithParameters:data]];
        responseCallback(@"Response from testObjcCallback");
    }];
}

- (void)successLogin
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(@"/topic/panGold.jhtml")]]];
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
