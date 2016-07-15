//
//  LoginViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginInputView.h"
#import "OtherLoginMethod.h"
#import "SignUpViewController.h"
#import "ReSignUpViewController.h"
#import "ForgetPwdViewController.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"

static NSString *kAuthScope = @"snsapi_userinfo";
static NSString *kAuthOpenID = @"0c806938e2413ce73eef92cc3";
static NSString *kAuthState = @"xxx";

@interface LoginViewController ()
<WXApiManagerDelegate>

@property (nonatomic) UIButton *registerBtn;
@property (nonatomic) UIImageView *logoImageView;
@property (nonatomic) LoginInputView *inputView;
@property (nonatomic) UIButton *forgetBtn;
@property (nonatomic) OtherLoginMethod *otherView;
@property (nonatomic) UILabel *label;
@property (nonatomic) UIView *footerView;
@end

@implementation LoginViewController

- (void)dealloc
{
    [WXApiManager sharedManager].delegate = nil;
}

- (void)back
{
    [self dismissViewController];
}

#pragma mark - 注册按钮
- (UIButton *)registerBtn
{
    return _registerBtn = ({
        UIButton *btn = nil;
        if (_registerBtn) {
            btn = _registerBtn;
        }
        else
        {
            NSString *title = NSLocalizedString(@"signUp",nil);
            CGSize sizt = [NSObject getSizeWithText:title font:NFontBold(16) maxSize:CGSizeMake(100, NFontBold(16).lineHeight)];
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(self.view.width - sizt.width - 15, 20 + (44 - 40) / 2, sizt.width, 40);
            btn.titleLabel.font = NFontBold(16);
            [btn setTitle:title forState:UIControlStateNormal];
            [btn setTitleColor:CustomGray forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(eventWithRegister) forControlEvents:UIControlEventTouchUpInside];
            btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
        }
        btn;
    });
}

#pragma mark - 登陆login
- (UIImageView *)logoImageView
{
    return _logoImageView = ({
        UIImageView *imageView = nil;;
        if (_logoImageView) {
           imageView =  _logoImageView;
        }
        else
        {
            UIImage *image = [UIImage imageNamed:@"login_logo.png"];
            imageView = UIImageView.new;
            imageView.frame = CGRectMake((self.view.width - image.size.width) / 2, ScaleH(80), image.size.width, image.size.height);
            imageView.image = image;
        }
        
        imageView;
    });
}

#pragma mark - 登陆inputView;
- (LoginInputView *)inputView
{
    return _inputView = ({
        LoginInputView *view = nil;;
        if (_inputView) {
            view =  _inputView;
        }
        else
        {
            WEAKSELF
            view = [[LoginInputView alloc] initWithFrame:CGRectMake(20, _logoImageView.bottom + 20, self.view.width - 40, 160) success:^(id datas){
            
                [weakSelf eventWithLogin:datas];
            }];
        }
        view;
    });

}


#pragma mark - 忘记密码
- (UIButton *)forgetBtn
{
    return _forgetBtn = ({
        UIButton *btn = nil;;
        if (_forgetBtn) {
            btn =  _forgetBtn;
        }
        else
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setTitle:NSLocalizedString(@"forgotYourPassword",nil) forState:UIControlStateNormal];
            btn.titleLabel.font = NFont(16);
            [btn setTitleColor:CustomBlue forState:UIControlStateNormal];
            btn.frame = CGRectMake(_inputView.left, _inputView.bottom + 10, _inputView.width, 40);
            [btn addTarget:self action:@selector(eventWithForgot) forControlEvents:UIControlEventTouchUpInside];
        }
        btn;
    });
}

- (UIView *)footerView
{
    return _footerView = ({
        UIView *view = nil;
        if (_footerView) {
            view = _footerView;
        }
        else
        {
            view = UIView.new;
            view.backgroundColor = RGBA(235, 236, 237, 1);
            view.frame = CGRectMake(0, self.view.height - 50, self.view.width, 50);
            UILabel *title1 = UILabel.new;
            title1.frame = CGRectMake(0, 5, view.width, title1.font.lineHeight);
            title1.text = [NSString stringWithFormat:@"%@：400-100-32103",NSLocalizedString(@"serviceTel",nil)];
            
            [view addSubview:title1];
            UILabel *title2 = UILabel.new;
            title2.frame = CGRectMake(0, view.height - 5 - title2.font.lineHeight, view.width, title1.font.lineHeight);
            title2.text = @"孟加拉国**协会";
            [view addSubview:title2];
            title1.textColor = title2.textColor = CustomlightGray;
            title1.font = title2.font = NFont(16);
            title1.textAlignment = title2.textAlignment = NSTextAlignmentCenter;
        }
        view;
    });
}

- (OtherLoginMethod *)otherView
{
    return _otherView = ({
        OtherLoginMethod *view = nil;;
        if (_otherView) {
            view =  _otherView;
        }
        else
        {
            WEAKSELF
            view = [OtherLoginMethod frame:CGRectMake(_inputView.left, _forgetBtn.bottom + 20, _inputView.width, 100) selected:^{
                [weakSelf eventWithWeChatLogin];
            }];
        }
        view;
    });

}




- (void)viewDidLoad {
    [super viewDidLoad];
    [WXApiManager sharedManager].delegate = self;

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.inputView];
    [self.view addSubview:self.forgetBtn];
//    [self.view addSubview:self.footerView];
    NSInteger show = NSLocalizedString(@"type",nil).integerValue;
    if (show == 1) {
        //中国
        [self.view addSubview:self.otherView];
    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - 去注册界面
- (void)eventWithRegister
{
    SignUpViewController *ctr = [[SignUpViewController alloc] initWithType:kDefault_sign_up];
    ctr.successLogin = _successLogin;
    [self pushViewController:ctr];
}

#pragma mark - 登陆
- (void)eventWithLogin:(id)datas
{
    [self.view endEditing:YES];
    NSString *mobile = datas[@"acc"];
    NSString *password = datas[@"pwd"];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = mobile;
    params[@"password"] = password;

    [RequestViewModels requestWithUserLogin:self params:params success:^(id datas)
    {
        NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
        for (NSHTTPCookie*cookie in [cookieJar cookies])
        {
            if ([cookie.name isEqualToString:@"JSESSIONID"]) {
                [keychainItemManager writeCookie:cookie];
            }
        }

        [keychainItemManager writeDatas:datas];
        BOOL isCompleteInfo = [datas[@"userInfo"][@"isCompleteInfo"] boolValue];
        if (!isCompleteInfo)
        { // 没有填写详细信息登录后区填写
            ReSignUpViewController *ctr = [[ReSignUpViewController alloc] initWithUserId:datas[@"userInfo"][@"userId"] hasReg:[datas[@"hasReg"] boolValue] companyName:datas[@"userInfo"][@"companyName"]];
            ctr.successLogin = _successLogin;
            [self pushViewController:ctr];
            [SVProgressHUD dismiss];
        }
        else
        {
            _successLogin(self, YES);
            [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.loginSuccess",nil)];
        }
        
    }failure:^(NSString *msg, NSString *status)
    {
        [SVProgressHUD showInfoWithStatus:msg];
    }];
}

#pragma mark - 去忘记密码界面
- (void)eventWithForgot
{
    [self pushViewController:ForgetPwdViewController.new];
}

#pragma mark - 去微信登陆界面
- (void)eventWithWeChatLogin
{
    
    [WXApiRequestHandler sendAuthRequestScope: kAuthScope
                                        State:kAuthState
                                       OpenID:kAuthOpenID
                             InViewController:self];

}

////授权后回调 WXApiDelegate
-(void)managerDidRecvAuthResponse:(BaseReq *)resp
{
    /*
     ErrCode ERR_OK = 0(用户同意)
     ERR_AUTH_DENIED = -4（用户拒绝授权）
     ERR_USER_CANCEL = -2（用户取消）
     code    用户换取access_token的code，仅在ErrCode为0时有效
     state   第三方程序发送时用来标识其请求的唯一性的标志，由第三方程序调用sendReq时传入，由微信终端回传，state字符串长度不能超过1K
     lang    微信客户端当前语言
     country 微信用户当前国家信息
     */
    SendAuthResp *aresp = (SendAuthResp *)resp;
    switch (aresp.errCode) {
        case 0:
        {
            NSString *code = aresp.code;
            [self getAccess_token:code];
            
        }
            break;
        case -2:
        {
            [SVProgressHUD showInfoWithStatus:@"你已取消授权"];
        }
            break;
        case -4:
        {
            [SVProgressHUD showInfoWithStatus:@"你已拒绝授权"];
        }
            break;
            
        default:
            break;
    }
}

-(void)getAccess_token:(NSString *)code
{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",APPID,SECRET,code];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSString *token = [dic objectForKey:@"access_token"];
                NSString *openId = [dic objectForKey:@"openid"];
                NSMutableDictionary *params = [NSMutableDictionary dictionary];
                params[@"access_token"] = token;
                params[@"openid"] = openId;
                [RequestViewModels requestWithThirdReg:nil params:params success:^(id datas)
                 {
                     NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
                     for (NSHTTPCookie*cookie in [cookieJar cookies])
                     {
                         if ([cookie.name isEqualToString:@"JSESSIONID"]) {
                             [keychainItemManager writeCookie:cookie];
                         }
                     }

                     [keychainItemManager writeDatas:datas];
                     BOOL isCompleteInfo = [datas[@"userInfo"][@"isCompleteInfo"] boolValue];
                     if (!isCompleteInfo)
                     { // 没有填写详细信息登录后区填写
                         SignUpViewController *ctr = [[SignUpViewController alloc] initWithType:kWechat_sign_up];
                         ctr.successLogin = _successLogin;
                         
                         [self pushViewController:ctr];
                         [SVProgressHUD dismiss];
                     }
                     else
                     {
                         _successLogin(self, YES);
                         [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.loginSuccess",nil)];
                     }
                 }failure:^(NSString *msg, NSString *status)
                 {
                     [SVProgressHUD showInfoWithStatus:msg];
                 }];
                
            }
        });
    });
}

-(void) getUserInfo:(NSString *)tokenArg andOpenId:(NSString *)openIdArg
{
    NSString *url =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",tokenArg,openIdArg];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *zoneUrl = [NSURL URLWithString:url];
        NSString *zoneStr = [NSString stringWithContentsOfURL:zoneUrl encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [zoneStr dataUsingEncoding:NSUTF8StringEncoding];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (data)
            {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                NSLog(@"%@",dic);
            }
        });
    });
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
