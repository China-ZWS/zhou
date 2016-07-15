//
//  ProfileViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/9.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProfileCellDataSource.h"
#import "ProfileHeader.h"
#import "MypostViewController.h"
#import "MyAssetsViewController.h"
#import "UserInfoViewController.h"
#import "SetViewController.h"

@interface ProfileViewController ()
<PJCellDataSourceDelegate>
{
    ProfileCellDataSource *_dataSource;
}
@property (nonatomic) ProfileHeader *header;
@end

@implementation ProfileViewController

- (id)init
{
    if ((self = [super initWithTableViewStyle:UITableViewStyleGrouped parameters:nil])) {
        self.title = NSLocalizedString(@"myProfile",nil);
        [self.navigationItem setRightItemWithTarget:self title:nil action:@selector(eventWithNavRight) image:@"profile_set_icon.png"];

        _datas = [DataConfigManager getProfileList];

    }
    return self;
}

- (void)eventWithNavRight
{
    SetViewController *ctr = SetViewController.new;
    ctr.hidesBottomBarWhenPushed = YES;
    [self pushViewController:ctr];
}

- (ProfileHeader *)header
{
    return _header = ({
        ProfileHeader *view = nil;
        if (_header) {
            view = _header;
        }
        else
        {
            WEAKSELF
            view = [[ProfileHeader alloc] initWithframe:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 150) header:^{
                [weakSelf eventWithHeader];
            
            } left:^{
                [weakSelf eventWithLeft];
            
            } right:^{
                [weakSelf eventWithRight];

            }];
            [view refreshData];
        }
        view;
    });
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    [keychainItemManager deleteDatas];
    _dataSource = ProfileCellDataSource.new;
    _dataSource.delegate = self;
    _dataSource.datas = _datas;
    _table.delegate = _dataSource;
    _table.dataSource = _dataSource;
    _table.tableHeaderView = self.header;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = _datas[indexPath.row];
    Class class = NSClassFromString(dic[@"viewController"]);
   WEAKSELF
    UIWebViewController *ctr = [[class alloc] initWithSuccess:^{
        [weakSelf.header refreshData];
    }];
    ctr.hidesBottomBarWhenPushed = YES;
    [self pushViewController:ctr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)eventWithHeader
{
    UserInfoViewController *ctr = [[UserInfoViewController alloc] initWithSuccess:^{
        [_header refreshData];
    }];
    ctr.hidesBottomBarWhenPushed = YES;
    [self pushViewController:ctr];
}

- (void)eventWithLeft
{
    MyAssetsViewController *ctr = MyAssetsViewController.new;
    ctr.hidesBottomBarWhenPushed = YES;
    [self pushViewController:ctr];
}

- (void)eventWithRight
{

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (![keychainItemManager readDatas]) {
        [self gotoLogingWithSuccess:^(BOOL success)
         {
             [_header refreshData];

         }class:@"LoginViewController" ];
    }
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
