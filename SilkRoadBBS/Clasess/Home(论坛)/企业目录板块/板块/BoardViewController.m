//
//  BoardViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "BoardViewController.h"
#import "TopicDetailViewController.h"
@interface BoardViewController ()
{
    NSString *_forumId;
}

@end

@implementation BoardViewController


- (id)initWithForumId:(NSString *)forumId;
{
    if ((self = [super init])) {
        self.title = NSLocalizedString(@"BoardViewController.navTitle",nil);
        _forumId = forumId;
        NSNotificationAdd(self, refreshWithViews, _forumId, nil);
    }
    return self;
}

- (void)refreshWithViews
{
    [_webView reload];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *urlString = [NSString stringWithFormat:@"/forum/topicList.jhtml?forumId=%@",_forumId];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:ServerH5Url(urlString)]]];
    
    [WebViewJavascriptBridge enableLogging];
    
       
    WEAKSELF
    
    [_bridge registerHandler:@"getTopicDetail" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSMutableDictionary *dic = NSMutableDictionary.new;
        [dic addEntriesFromDictionary:@{@"forumId":_forumId}];
        [dic addEntriesFromDictionary:data];
        [weakSelf pushViewController:[[TopicDetailViewController alloc] initWithParameters:dic]];
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
