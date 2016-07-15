//
//  UIWebViewController.h
//  BaseObject
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 TalkWeb. All rights reserved.
//

#import "BaseViewController.h"

@interface UIWebViewController : BaseViewController
<UIWebViewDelegate>
{
    UIWebView *_webView;
    void(^_successBlock)();

}
@property (nonatomic, copy) void(^successBlock)();
- (id)initWithSuccess:(void(^)())success;
@property (nonatomic) UIWebView *webView;

@end
