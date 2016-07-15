//
//  HomeViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/9.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "HomeViewController.h"
#import "BBSNavOptionController.h"
#import "VIPMembersViewController.h"
#import "SearchViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

- (id)init
{
    if ((self = [super init])) {
        self.title = NSLocalizedString(@"HomeViewController.navTitle",nil);
        [self.navigationItem setRightItemWithTarget:self title:nil action:@selector(eventWithRight) image:@"nav_search.png"];

    }
    return self;
}

- (void)eventWithRight
{
    SearchViewController *ctr = SearchViewController.new;
    ctr.hidesBottomBarWhenPushed = YES;
    [self pushViewController:ctr];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(@"/index.jhtml")]]];

    [WebViewJavascriptBridge enableLogging];
    
   
    WEAKSELF

    [_bridge registerHandler:@"getForumTopic" handler:^(id data, WVJBResponseCallback responseCallback) {
       
        BBSNavOptionController *bbs = [[BBSNavOptionController alloc] initWithViewControllers:@[[[DirectoryViewController alloc] initWithForumId:data[@"forumId"]],[[BoardViewController alloc] initWithForumId:data[@"forumId"]]]];
        bbs.hidesBottomBarWhenPushed = YES;
        [weakSelf pushViewController:bbs];
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
