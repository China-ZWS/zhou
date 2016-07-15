//
//  VIPMembersViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/4.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "VIPMembersViewController.h"
#import "VIPMembersHeader.h"
#import "VIPMembersCellDataSource.h"
#import "VIPPayViewController.h"

@interface VIPMembersViewController ()
<PJCellDataSourceDelegate>
@property (nonatomic) VIPMembersHeader *header;
@property (nonatomic) VIPMembersCellDataSource *dataSource;
@end

@implementation VIPMembersViewController

- (id)initWithParameters:(id)parameters
{
    if ((self = [super initWithTableViewStyle:UITableViewStyleGrouped parameters:parameters])) {
        self.title = NSLocalizedString(@"VIPMembersViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
        _datas = [DataConfigManager getVIPMembersList];

    }
    return self;
}

- (void)back
{
    [self popViewController];
}

- (VIPMembersHeader *)header
{
    return _header = ({
        VIPMembersHeader *view = nil;
        if (_header) {
            view = _header;
        }
        else
        {
            view = VIPMembersHeader.new;
            view.frame = CGRectMake(0, 0, self.view.width, 100);
            [view refreshData];
        }
        view;
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = VIPMembersCellDataSource.new;
    _dataSource.delegate = self;
    _dataSource.datas = _datas;
    _table.delegate = _dataSource;
    _table.dataSource = _dataSource;
    _table.tableHeaderView = self.header;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self getRequestWithDatas];
}

- (void)getRequestWithDatas
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"forumId"] = _parameters[@"forumId"];
    
    [RequestViewModels requestWithGetForumCommodity:self params:params success:^(id datas)
     {
         [SVProgressHUD dismiss];
         NSMutableDictionary *dic = NSMutableDictionary.new;
         [dic addEntriesFromDictionary:datas[@"commodity"]];
         [dic addEntriesFromDictionary:_parameters];
         _dataSource.requestWithDatas = dic;
         [_table insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
     }];

}

- (void)eventWithPay
{
    VIPPayViewController *ctr  = [[VIPPayViewController alloc] initWithParameters:_dataSource.requestWithDatas];
    if (_successBlock) {
        ctr.successBlock = _successBlock;
    }
    [self pushViewController:ctr];
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
