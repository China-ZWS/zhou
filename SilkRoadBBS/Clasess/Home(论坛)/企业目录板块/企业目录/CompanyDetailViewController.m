//
//  CompanyDetailViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/3.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "CompanyDetailViewController.h"

@interface CompanyDetailViewController ()

@end

@implementation CompanyDetailViewController

- (id)initWithParameters:(id)parameters
{
    if ((self = [super initWithParameters:parameters])) {
        self.title = _parameters[@"companyName"];
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
    
    NSString *urlString = [NSString stringWithFormat:@"/company/companyInfo.jhtml?companyId=%@",_parameters[@"companyId"]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(urlString)]]];
    
    [WebViewJavascriptBridge enableLogging];
    
        
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
