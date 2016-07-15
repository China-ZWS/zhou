//
//  PJWebViewController.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "UIWebViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

@interface PJWebViewController : UIWebViewController
<UIWebViewDelegate,NJKWebViewProgressDelegate>
{
    WebViewJavascriptBridge *_bridge;
    NJKWebViewProgressView *_webViewProgressView;
    NJKWebViewProgress *_webViewProgress;

}

- (void)successLogin;
@property WebViewJavascriptBridge* bridge;

@end
