//
//  reSignUpViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/12.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ReSignUpViewController.h"
#import "ReSignUpCellDataSource.h"
#import "BasePopupView.h"
#import "PositionTableView.h"

@interface ReSignUpViewController ()
<ReSignUpCellDataSourceDelegaet>
{
    ReSignUpCellDataSource *_dataSource;
    NSString *_userId;
    BOOL _hasReg;
    NSString *_companyName;
}
@property (nonatomic) UIView *footerView;
@property (nonatomic) NSString *positionId;

@end

@implementation ReSignUpViewController

- (id)initWithUserId:(NSString *)userId hasReg:(BOOL)hasReg companyName:(NSString *)companyName;
{
    if ((self = [super initWithTableViewStyle:UITableViewStyleGrouped parameters:nil])) {
        self.title = NSLocalizedString(@"improveInformation",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return_pre.png"];
        _datas = [DataConfigManager getReSignUpList];
        
        if (hasReg)
        {
            _datas = [NSArray arrayWithObject:_datas[0]];
        }
        
        _userId = userId;
        _hasReg = hasReg;
        _companyName = companyName;
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
    
    _dataSource = ReSignUpCellDataSource.new;
    _dataSource.delegate = self;
    _dataSource.datas = _datas;
    _table.delegate = _dataSource;
    _table.dataSource = _dataSource;
    _table.tableFooterView = self.footerView;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.hasKeyboardnotificationCenter = YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)eventWithFinish
{
    
    NSString *surName = _dataSource.name;
    NSString *telephone = _dataSource.phone;
    NSString *email = _dataSource.email;
    NSString *positionId = _positionId;
    NSString *businessScope = _dataSource.businessScope;
    NSString *companyAddr = _dataSource.address;
    
    if (!(NSUInteger)surName.length || !(NSUInteger)telephone.length || !(NSUInteger)email.length || !(NSUInteger)positionId.length)
    {
        // 必传
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.unInfo",nil)];
        return;
    }
    
    if (!_hasReg) // 公司有没有注册
    {
        // 没有注册判断businessScope和address字段是否填写
        if (!(NSUInteger)businessScope.length || !(NSUInteger)companyAddr.length) {
            [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.unInfo",nil)];
            return;
        }
    }
    
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = _userId;
    params[@"surName"] = surName;
    params[@"telephone"] = telephone;
    params[@"email"] = email;
    params[@"position"] = positionId;
    params[@"hasReg"] = [NSNumber numberWithBool:_hasReg];
    params[@"businessScope"] = businessScope;
    params[@"companyAddr"] = companyAddr;
    params[@"companyName"] = _companyName;
    
    [RequestViewModels requestWithCompelteUserinfo:self params:params success:^(id datas)
     {
         [keychainItemManager writeDatas:datas];
         [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.setSuccess",nil)];
         if (_successLogin) {
             _successLogin(self,YES);
         }
         else
         {
             [self back];
         }
     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
     }];

}

- (void)tableViewCellForShowPosition:(ReSignUpCell *)tableViewCell;
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

    [RequestViewModels requestWithPositionQuery:self params:[NSMutableDictionary dictionary] success:^(id datas)
     {
         [SVProgressHUD dismiss];
         PositionTableView *table = [[PositionTableView alloc] initWithFrame:CGRectMake(0, 0, 250, 300) datas:datas[@"positionList"] selected:^(id selectedDatas)
                                   {
                                       [tableViewCell endEditing:YES];
                                       [BasePopupView hideForView];
                                       _positionId = selectedDatas[@"positionId"];
                                       tableViewCell.field.text = selectedDatas[@"positionName"];
                                       [self.view endEditing:YES];
                                   }];

         
         [BasePopupView showInView:^(BasePopupView *popupView)
          {
              popupView.addContentView(table);
          }];
         
     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
         [tableViewCell endEditing:YES];
     }];

}

- (void)tableViewCellForBeginEditField:(ReSignUpCell *)tableViewCell;
{
    self.getCalculateView([UIView getView:tableViewCell.field toClass:@"ReSignUpCell"],nil);
}

- (void)tableViewCellForBeginEditTView:(ReSignUpCell *)tableViewCell;
{
    self.getCalculateView([UIView getView:tableViewCell.tView toClass:@"ReSignUpCell"],nil);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
