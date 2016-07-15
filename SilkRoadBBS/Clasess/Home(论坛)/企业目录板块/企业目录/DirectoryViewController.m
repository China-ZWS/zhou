//
//  DirectoryViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "DirectoryViewController.h"
#import "CompanyDetailViewController.h"
@interface DirectoryViewController ()
{
    NSString *_forumId;
}
@end

@implementation DirectoryViewController

- (id)initWithForumId:(NSString *)forumId;
{
    if ((self = [super init])) {
        self.title = NSLocalizedString(@"DirectoryViewController.navTitle",nil);
        _forumId = forumId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString = [NSString stringWithFormat:@"/company/forumCompany.jhtml?forumId=%@",_forumId];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(urlString)]]];
    
    [WebViewJavascriptBridge enableLogging];
    
        
    WEAKSELF
    
    [_bridge registerHandler:@"getCompanyDetail" handler:^(id data, WVJBResponseCallback responseCallback) {
        
        [weakSelf pushViewController:[[CompanyDetailViewController alloc] initWithParameters:data]];
        responseCallback(@"Response from testObjcCallback");
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
