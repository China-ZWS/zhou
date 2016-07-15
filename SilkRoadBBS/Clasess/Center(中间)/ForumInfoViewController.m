//
//  ForumInfoViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/8.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ForumInfoViewController.h"
#import "ForumInfoDataSource.h"
#import "VIPMembersViewController.h"
#import "ReSignUpViewController.h"
#import "SignUpViewController.h"

@interface ForumInfoViewController ()
<PJCellDataSourceDelegate>
{
    void(^_seleted)(id);
    ForumInfoDataSource *_dataSource;
}
@end

@implementation ForumInfoViewController

- (instancetype)initWithSeleted:(void(^)(id))seleted;
{
    if ((self = [super initWithTableViewStyle:UITableViewStyleGrouped parameters:nil])) {
        _seleted = seleted;
        self.title = NSLocalizedString(@"ForumInfoViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
    }
    return self;
}

- (void)back
{
    [self popViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self request];
    _dataSource = ForumInfoDataSource.new;
    _dataSource.delegate = self;
    _table.delegate = _dataSource;
    _table.dataSource = _dataSource;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;

    // Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0) {
        _seleted(_datas[indexPath.section][indexPath.row]);
        [self back];
    }
    else
    {
        WEAKSELF
        __block void(^safeSeleted)(id) = _seleted;
        VIPMembersViewController *ctr = [[VIPMembersViewController alloc] initWithParameters:_datas[indexPath.section][indexPath.row]];
        ctr.hidesBottomBarWhenPushed = YES;
        ctr.successBlock = ^{
            [SVProgressHUD showSuccessWithStatus:@"支付成功"];
            safeSeleted(weakSelf.datas[indexPath.section][indexPath.row]);
        };
        [self pushViewController:ctr];
    }
}

- (void)request
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSInteger type = NSLocalizedString(@"type",nil).integerValue;
    // 中国
    if (type == 1) {
        params[@"clientType"] = @"APP_CHINA";
    }
    // 孟加拉
    else if (type == 2)
    {
        params[@"clientType"] = @"APP_ENG";
    }

    [RequestViewModels requestWithGetForumInfo:self params:params success:^(id datas)
     {
         NSMutableArray *arr = NSMutableArray.new;
         [arr addObject:datas[@"userForumList"]];
         [arr addObject:datas[@"otherForumList"]];
         _dataSource.datas = _datas = arr;
         [_table reloadData];
         [SVProgressHUD dismiss];
     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];

         if (status.integerValue == -1) {
             [self gotoLogingWithSuccess:^(BOOL success)
              {
                  [self request];
                  [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.loginSuccess",nil)];
              }class:@"LoginViewController" ];
         }
         else if (status.integerValue == 5)
         {
             NSDictionary *infoDatas = [keychainItemManager readDatas];
             NSInteger regChannel = [infoDatas[@"userInfo"][@"regChannel"] integerValue];
             if (regChannel == 0) {
                 // 自有
                 ReSignUpViewController *ctr = [[ReSignUpViewController alloc] initWithUserId:infoDatas[@"userInfo"][@"userId"] hasReg:[infoDatas[@"hasReg"] boolValue] companyName:infoDatas[@"userInfo"][@"companyName"]];
                 ctr.hidesBottomBarWhenPushed = YES;
                 [self pushViewController:ctr];
                 
             }
             else if (regChannel == 1)
             {  // 微信
                 SignUpViewController *ctr = [[SignUpViewController alloc] initWithType:kWechat_sign_up];
                 [self pushViewController:ctr];
                 [SVProgressHUD dismiss];
             }
             
         }
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
