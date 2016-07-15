//
//  TopicDetailViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/3.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "TopicDetailViewController.h"
#import "RepliesViewController.h"

@interface TopicDetailViewController ()

@end

@implementation TopicDetailViewController

- (id)initWithParameters:(id)parameters
{
    if ((self = [super initWithParameters:parameters])) {
        self.title = _parameters[@"topicTitle"];
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
        [self.navigationItem setRightItemWithTarget:self title:NSLocalizedString(@"TopicDetailViewController.navRightTitle",nil)  action:@selector(eventWithRight) image:nil];
    }
    return self;
}

- (void)back
{
    [self popViewController];
}

- (void)eventWithRight
{
    WEAKSELF
    [self pushViewController:[[RepliesViewController alloc] initWithDatas:_parameters success:^{
        
        [weakSelf.webView reload];
    }]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString = [NSString stringWithFormat:@"/topic/topicDetail.jhtml?topicId=%@",_parameters[@"topicId"]];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(urlString)]]];
    
    [WebViewJavascriptBridge enableLogging];
    
    [_bridge setWebViewDelegate:self];
    

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
