//
//  ForgetPwdViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/18.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ForgetPwdViewController.h"
#import "ForgetPwdCellDataSource.h"

@interface ForgetPwdViewController ()
<ForgetPwdCellDataSourceDelegate>
{
    ForgetPwdCellDataSource *_dataSource;
}
@property (nonatomic) UIView *footerView;

@end

@implementation ForgetPwdViewController

- (id)init
{
    if ((self = [super initWithTableViewStyle:UITableViewStyleGrouped parameters:nil])) {
        self.title = NSLocalizedString(@"RetrievePassword",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return_pre.png"];
        _datas = [DataConfigManager getForgetPwdList];
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
            [btn setTitle:NSLocalizedString(@"passwordReset",nil) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(eventWithFinish) forControlEvents:UIControlEventTouchUpInside];
            [btn getCornerRadius:5 borderColor:[UIColor clearColor] borderWidth:1 masksToBounds:YES];
            btn.backgroundColor = CustomBlue;
            [view addSubview:btn];
        }
        view;
        
    });
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = ForgetPwdCellDataSource.new;
    _dataSource.delegate = self;
    _dataSource.datas = _datas;
    _table.delegate = _dataSource;
    _table.dataSource = _dataSource;
    _table.tableFooterView = self.footerView;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.hasKeyboardnotificationCenter = YES;
}


#define SignUpCellDataSourceDelegaet
- (void)tableViewCellForTouchesCode:(ForgetPwdCell *)tableViewCell
{
    
    
    if (![self verificationWithAccount])return;
    [tableViewCell countDown];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] =  _dataSource.account;
    params[@"busiCode"] = [NSString stringWithFormat:@"%ld",kRetrievePWD_BusCode];
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)eventWithFinish
{
    if (![self verificationWithAccount])return;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"mobile"] = _dataSource.account;
    params[@"password"] = _dataSource.pwd;
    params[@"verfycode"] = _dataSource.code;
    
    [RequestViewModels requestWithRetPassW:self params:params success:^(id datas)
     {
         
         [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.setSuccess",nil)];
         [self performSelector:@selector(back) withObject:nil afterDelay:.5];

     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];

     }];

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
