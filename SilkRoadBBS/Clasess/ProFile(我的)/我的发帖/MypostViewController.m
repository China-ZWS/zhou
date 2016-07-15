//
//  MypostViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "MypostViewController.h"
#import "TopicDetailViewController.h"

@interface MypostViewController ()

@end

@implementation MypostViewController


- (id)initWithSuccess:(void(^)())success;
{
    if ((self = [super initWithSuccess:success])) {
        self.title = NSLocalizedString(@"MypostViewController.navTitle",nil);
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
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(@"/member/mytopic.jhtml")]]];
    
    [WebViewJavascriptBridge enableLogging];
    
    
    WEAKSELF
    
    
    [_bridge registerHandler:@"getTopicDetail" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [weakSelf pushViewController:[[TopicDetailViewController alloc] initWithParameters:data]];
        responseCallback(@"Response from testObjcCallback");
    }];
}

- (void)successLogin
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(@"/member/mytopic.jhtml")]]];
    _successBlock();

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{

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
