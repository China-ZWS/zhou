//
//  VIPPayViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/5.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "VIPPayViewController.h"
#import "VIPPayCellDataSource.h"
#import "VIPPayHeader.h"
#import "WXApiRequestHandler.h"
#import "WXApiManager.h"

@interface VIPPayViewController ()
<PJCellDataSourceDelegate,WXApiManagerDelegate>
@property (nonatomic) VIPPayHeader *header;
@property (nonatomic) VIPPayCellDataSource *dataSource;
@property (nonatomic) UIView *footer;

@end

@implementation VIPPayViewController

- (void)dealloc
{
    [WXApiManager sharedManager].delegate = nil;
}

- (id)initWithParameters:(id)parameters
{
    if ((self = [super initWithTableViewStyle:UITableViewStyleGrouped parameters:parameters])) {
        self.title = NSLocalizedString(@"VIPPayViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
        _datas = [DataConfigManager getVIPPayTypelist];
        
    }
    return self;
}

- (void)back
{
    [self popViewController];
}

- (VIPPayHeader *)header
{
    return _header = ({
        VIPPayHeader *view = nil;
        if (_header) {
            view = _header;
        }
        else
        {
            view = VIPPayHeader.new;
            view.frame = CGRectMake(0, 0, self.view.width, 100);
            view.datas = _parameters;
            
        }
        view;
    });
}

- (UIView *)footer
{
    return _footer = ({
        UIView *view = nil;
        if (_footer) {
            view = _footer;
        }
        else
        {
            view = UIView.new;
            view.size = CGSizeMake(self.view.width, 65);
            view.backgroundColor = [UIColor clearColor];
            UIButton *btn = UIButton.new;
            btn.frame = CGRectMake(15, 10, view.width - 30, 45);
            btn.backgroundColor = CustomBlue;
            [btn setTitle:NSLocalizedString(@"VIPMembersList.payBtnTitle",nil) forState:UIControlStateNormal];
            [btn getCornerRadius:5 borderColor:[UIColor clearColor] borderWidth:0 masksToBounds:YES];
            btn.titleLabel.font = NFont(16);
            [btn addTarget:self action:@selector(eventWithPay) forControlEvents:UIControlEventTouchUpInside];
            [view addSubview:btn];
        }
        view;
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [WXApiManager sharedManager].delegate = self;

    _dataSource = VIPPayCellDataSource.new;
    _dataSource.delegate = self;
    _dataSource.datas = _datas;
    _table.delegate = _dataSource;
    _table.dataSource = _dataSource;
    _table.tableHeaderView = self.header;
    
    _table.tableFooterView = self.footer;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)eventWithPay
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"forumId"] = _parameters[@"forumId"];
    
    [RequestViewModels requestWithWeixinPay:self params:params success:^(id datas)
     {
         [SVProgressHUD dismiss];
         [self gotoWechatPay:datas[@"payInfo"]];
         
     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg]; 
     }];

}

- (void)gotoWechatPay:(id)datas
{
    NSString *reCode = [WXApiRequestHandler jumpToBizPay:datas];
    NSLog(@"%@",reCode);
}

- (void)managerDidRecvPayResp:(PayResp *)response;
{
    NSString *strMsg = nil;
    
    switch (response.errCode) {
        case WXSuccess:
            if (_successBlock) {
                _successBlock();
            }
            strMsg = @"支付结果：成功！";
            [SVProgressHUD showSuccessWithStatus:strMsg];
            [self.navigationController popToRootViewControllerAnimated:YES];
            break;
        default:
            strMsg = [NSString stringWithFormat:@"取消支付"];
            [SVProgressHUD showInfoWithStatus:strMsg];

            break;
    }

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
