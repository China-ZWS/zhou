//
//  UIWebViewController.m
//  BaseObject
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 TalkWeb. All rights reserved.
//

#import "UIWebViewController.h"
#import "Header.h"
@interface UIWebViewController ()

@end

@implementation UIWebViewController
- (id)initWithSuccess:(void(^)())success;
{
    if ((self = [super init])) {
        _successBlock = success;
    }
    return self;
}
- (UIWebView *)webView
{
    return _webView = ({
        UIWebView *view = nil;
        if (_webView) {
            view = _webView;
        }
        else
        {
            view = UIWebView.new;
            view.frame = self.view.frame;
            view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            view.backgroundColor = RGBA(238, 238, 238, 1);
            view.opaque = NO;
        }
        view;
        
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
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
