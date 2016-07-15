//
//  MyAssetsViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/4.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "MyAssetsViewController.h"

@interface MyAssetsViewController ()

@end

@implementation MyAssetsViewController


- (id)initWithSuccess:(void (^)())success
{
    if ((self = [super initWithSuccess:success])) {
        self.title = NSLocalizedString(@"MyAssetsViewController.navTitle",nil);
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
    
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(@"/member/myAccountFlow.jhtml")]]];
    
    [WebViewJavascriptBridge enableLogging];
    
    
    

    // Do any additional setup after loading the view.
}

- (void)successLogin
{
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(@"/member/myAccountFlow.jhtml")]]];
    _successBlock();
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
