//
//  SignUpViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "SignUpViewController.h"
#import "reSignUpViewController.h"
#import "SignUpCellDataSource.h"
@interface SignUpViewController ()
<SignUpCellDataSourceDelegaet>
{
    SignUpCellDataSource *_dataSource;
    SignType _signType;
}
@property (nonatomic) UIView *footerView;
@end

@implementation SignUpViewController

- (instancetype)initWithType:(SignType)signType;
{
    if ((self = [super initWithTableViewStyle:UITableViewStyleGrouped parameters:nil])) {
    
        self.title = NSLocalizedString(@"SignUpViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return_pre.png"];
        _datas = [DataConfigManager getSignUpList];

        if (signType == kWechat_sign_up) {
            _datas = [NSArray arrayWithObject:_datas[2]];
        }
        _signType = signType;

    }
    return self;
}

- (void)back
{
    [self.view endEditing:YES];
    [self popViewController];
}


- (void)dealloc
{
    self.hasKeyboardnotificationCenter = NO;
    
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
            view.height = 85;
            view.width = self.view.width;
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake(20, 20, view.width - 40, 45);
            btn.titleLabel.font = NFont(16);
            [btn setTitle:NSLocalizedString(@"nextStep",nil) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(eventWithNext) forControlEvents:UIControlEventTouchUpInside];
            [btn getCornerRadius:5 borderColor:[UIColor clearColor] borderWidth:1 masksToBounds:YES];
            btn.backgroundColor = CustomBlue;
            [view addSubview:btn];
            
        }
        view;
        
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = SignUpCellDataSource.new;
    _dataSource.delegate = self;
    _dataSource.datas = _datas;
    _table.delegate = _dataSource;
    _table.dataSource = _dataSource;
    _table.tableFooterView = self.footerView;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.hasKeyboardnotificationCenter = YES;
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma 下一步
- (void)eventWithNext
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    if (_signType == kDefault_sign_up) {
        if (![self verificationWithAccount])return;
        
        NSString *account = _dataSource.account;
        NSString *pwd = _dataSource.pwd;
        NSString *rePwd = _dataSource.rePwd;
        NSString *verfycode = _dataSource.code;
        NSString *companyName = _dataSource.company;
        
        if (!(NSUInteger)account || !(NSUInteger)verfycode.length || !(NSUInteger)pwd.length || !(NSUInteger)rePwd.length || !(NSUInteger)companyName.length )
        {
            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.unInfo",nil)];
            return;
        }
        if (![pwd isEqualToString:rePwd]) {
            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.PANC",nil)];
            return;
        }
        params[@"mobile"] = account;
        params[@"password"] = pwd;
        params[@"rePassword"] = rePwd;
        params[@"verfycode"] = verfycode;
        params[@"companyName"] = companyName;
       
        [RequestViewModels requestWithUserReg:self params:params success:^(id datas)
         {
             NSHTTPCookieStorage*cookieJar = [NSHTTPCookieStorage sharedHTTPCookieStorage];
             for (NSHTTPCookie*cookie in [cookieJar cookies])
             {
                 if ([cookie.name isEqualToString:@"JSESSIONID"]) {
                     [keychainItemManager writeCookie:cookie];
                 }
             }
             [keychainItemManager writeDatas:datas];
             ReSignUpViewController *ctr = [[ReSignUpViewController alloc] initWithUserId:datas[@"userInfo"][@"userId"] hasReg:[datas[@"hasReg"] boolValue] companyName:companyName];
             if (_successLogin) {
                 ctr.successLogin = _successLogin;
                }

             [self pushViewController:ctr];
             [SVProgressHUD dismiss];
         }failure:^(NSString *msg, NSString *status)
         {
             [SVProgressHUD showInfoWithStatus:msg];
         }];

    }
    else if (_signType == kWechat_sign_up)
    {
        NSString *companyName = _dataSource.company;
        if (!(NSUInteger)companyName) {
            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.unInfo",nil)];
            return;
        }
        params[@"companyName"] = companyName;
        [RequestViewModels requestWithCompanyQuery:self params:params success:^(id datas)
         {
             id data = [keychainItemManager readDatas];
             
             BOOL hasReg = NO;
             if ([datas[@"status"] integerValue] == 1) {
                 hasReg = YES;
             }
             ReSignUpViewController *ctr = [[ReSignUpViewController alloc] initWithUserId:data[@"userInfo"][@"userId"] hasReg:hasReg companyName:companyName];
             ctr.successLogin = _successLogin;
             [self pushViewController:ctr];
             [SVProgressHUD dismiss];
         }failure:^(NSString *msg, NSString *status)
         {
             [SVProgressHUD showInfoWithStatus:msg];
         }];

    }
    
    
}

#define SignUpCellDataSourceDelegaet
- (void)tableViewCellForTouchesCode:(SignUpCell *)tableViewCell
{
    
    
    if (![self verificationWithAccount])return;
    [tableViewCell countDown];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] =  _dataSource.account;
    params[@"busiCode"] = [NSString stringWithFormat:@"%ld",kSignUp_BusCode];
    
    [RequestViewModels requestWithVerfyCode:self params:params success:^(id datas)
     {
         [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.sendSuccess",nil)];

     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
     }];
}

#pragma mark 手机号码或者邮箱本地验证
- (BOOL)verificationWithAccount
{
    NSString *account = _dataSource.account;
    NSInteger show = NSLocalizedString(@"type",nil).integerValue;
    if (show == 1) {
        //中国
        if (![NSObject isMobile:account])
        {
            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.correctPhoneNum",nil)];
            return NO;
        }
        
    }
    else
    {
        if (![NSObject isValidateEmail:account]) {
            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.correctEmail",nil)];
            return NO;
        }
    }
    return YES;
}

- (void)tableViewCellForBeginEditField:(SignUpCell *)tableViewCell;
{
    self.getCalculateView([UIView getView:tableViewCell.field toClass:@"SignUpCell"],nil);

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