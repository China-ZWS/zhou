//
//  UserInfoViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoDataSource.h"
#import "BasePhotoPickerManager.h"
#import "PositionTableView.h"
#import "BasePopupView.h"

typedef NS_ENUM(NSInteger, UserInfoChange)
{
    kPhoneNum = 0,  /// 修改电话号码.
    kPost,///  修改 职位
    kEmail, // 修改邮箱
};


@interface UserInfoViewController ()
<PJCellDataSourceDelegate>
{
    UserInfoDataSource *_dataSource;
    void(^_successBlock)();
}
@property (nonatomic) UIView *footerView;

@end

@implementation UserInfoViewController

- (id)initWithSuccess:(void(^)())success
{
    if ((self = [super initWithTableViewStyle:UITableViewStyleGrouped parameters:nil])) {
        self.title = NSLocalizedString(@"UserInfoViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
        
        _datas = [DataConfigManager getUserInfolist];
        _successBlock = success;
    }
    return self;
}

- (void)back
{
    [self popViewController];
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
            [btn setTitle:NSLocalizedString(@"signOut",nil) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(eventWithSignOut) forControlEvents:UIControlEventTouchUpInside];
            [btn getCornerRadius:5 borderColor:[UIColor clearColor] borderWidth:1 masksToBounds:YES];
            btn.backgroundColor = CustomBlue;
            [view addSubview:btn];
        }
        view;
        
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = UserInfoDataSource.new;
    _dataSource.datas = _datas;
    _dataSource.delegate = self;
    _table.delegate = _dataSource;
    _table.dataSource = _dataSource;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _table.tableFooterView = self.footerView;
    // Do any additional setup after loading the view.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                WEAKSELF
                [[BasePhotoPickerManager shared] showActionSheetInView:self.view fromController:self completion:^(id datas)
                 {
                     [weakSelf uploadPic:datas ];
                 }
                                                            otherBlock:^(id datas)
                 {
                     
                 }
                                                           cancelBlock:^()
                 {
                     
                 } cancelTitle:NSLocalizedString(@"public.btnTitle.cancel",nil) destructiveTitle:NSLocalizedString(@"public.btnTitle.photos",nil) otherTitle:NSLocalizedString(@"public.btnTitle.photograph",nil)];
                
            }
                break;
            case 2:
            {
                UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"public.alert.changePhoneNum",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"public.btnTitle.cancel",nil) otherButtonTitles:NSLocalizedString(@"public.btnTitle.confirm",nil), nil];
                alert.tag = kPhoneNum;
                [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                [alert show];
                
                UITextField *field = [alert textFieldAtIndex:0];
                field.keyboardType = UIKeyboardTypeNumberPad;
                field.placeholder = NSLocalizedString(@"public.alert.changePhoneNum",nil);
                
            }
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 1)
    {
        switch (indexPath.row) {
            case 0:
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

                [RequestViewModels requestWithPositionQuery:self params:params success:^(id datas)
                 {
                     [SVProgressHUD dismiss];
                     PositionTableView *table = [[PositionTableView alloc] initWithFrame:CGRectMake(0, 0, 250, 300) datas:datas[@"positionList"] selected:^(id selectedDatas)
                                                 {
                                                     [self modifyPosition:selectedDatas];
                                                     [BasePopupView hideForView];
                                                     [self.view endEditing:YES];
                                                 }];
                     
                     
                     [BasePopupView showInView:^(BasePopupView *popupView)
                      {
                          popupView.addContentView(table);
                      }];
                     
                 }failure:^(NSString *msg, NSString *status)
                 {
                     [SVProgressHUD showInfoWithStatus:msg];
                 }];

            }
                break;
            case 1:
            {
                UIAlertView *alert =  [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"public.alert.changeEmail",nil) message:nil delegate:self cancelButtonTitle:NSLocalizedString(@"public.btnTitle.cancel",nil) otherButtonTitles:NSLocalizedString(@"public.btnTitle.confirm",nil), nil];
                alert.tag = kEmail;
                [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
                [alert show];
                
                UITextField *field = [alert textFieldAtIndex:0];
                field.keyboardType = UIKeyboardTypeEmailAddress;
                field.placeholder = NSLocalizedString(@"public.alert.changeEmail",nil);
                
            }
                break;
            default:
                break;
        }
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UITextField *field = [alertView textFieldAtIndex:0];
    [field resignFirstResponder];
    if (alertView.cancelButtonIndex == buttonIndex) {
        return;
    }
    switch (alertView.tag) {
        case kPhoneNum:
        {
            if (![NSObject isMobile:field.text])
            {
                [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.correctPhoneNum",nil)];
                return;
            }
            
            NSMutableDictionary *readDatas = [NSMutableDictionary dictionaryWithDictionary:[keychainItemManager readDatas]];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"userid"] = readDatas[@"userInfo"][@"userId"];
            params[@"surName"] = readDatas[@"userInfo"][@"surName"];
            params[@"telephone"] = field.text;
            params[@"email"] = @"";
            params[@"position"] = @"";
            params[@"hasReg"] = @"";
            params[@"businessScope"] = @"";
            params[@"companyAddr"] = @"";
            params[@"companyName"] = @"";
           
            [RequestViewModels requestWithCompelteUserinfo:self params:params success:^(id datas)
             {
                 [keychainItemManager writeDatas:datas];
                 [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.setSuccess",nil)];
                 [_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
                 
                 [self dismissViewController];
             }failure:^(NSString *msg, NSString *status)
             {
                 [SVProgressHUD showInfoWithStatus:msg];
             }];
            
            
            
        }
            break;
        case kPost:
            
            break;
        case kEmail:
        {
            if (![NSObject isValidateEmail:field.text]) {
                [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.correctEmail",nil)];
                return;
            }
            NSMutableDictionary *readDatas = [NSMutableDictionary dictionaryWithDictionary:[keychainItemManager readDatas]];
            NSMutableDictionary *params = [NSMutableDictionary dictionary];
            params[@"userid"] = readDatas[@"userInfo"][@"userId"];
            params[@"surName"] = readDatas[@"userInfo"][@"surName"];
            params[@"telephone"] = readDatas[@"userInfo"][@"telephone"];
            params[@"email"] = field.text;
            params[@"position"] = @"";
            params[@"hasReg"] = @"";
            params[@"businessScope"] = @"";
            params[@"companyAddr"] = @"";
            params[@"companyName"] = @"";
            
            [RequestViewModels requestWithCompelteUserinfo:self params:params success:^(id datas)
             {
                 [keychainItemManager writeDatas:datas];
                 [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.setSuccess",nil)];
                 [_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
                 
                 [self dismissViewController];
             }failure:^(NSString *msg, NSString *status)
             {
                 [SVProgressHUD showInfoWithStatus:msg];
             }];

        }
            break;
            
        default:
            break;
    }
}

- (void)uploadPic:(id)datas
{
    NSMutableDictionary *readDatas = [NSMutableDictionary dictionaryWithDictionary:[keychainItemManager readDatas]];
    
    NSString *imgeString = [UIImageJPEGRepresentation([UIImage imageWithImage:datas[@"file"] scaledToSize:CGSizeMake( 300, 300)],0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uploadType"] = @"headerimg";
    params[@"picType"] = @"jpg";
    params[@"fileStrList"] = @[imgeString];
    [RequestViewModels requestWithUploadPic:self params:params success:^(id datas)
     {
         [SVProgressHUD dismiss];
         readDatas[@"userInfo"][@"avatar"] = datas[@"httppathList"];
         [keychainItemManager writeDatas:readDatas];
         [_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
         [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.setSuccess",nil)];
         _successBlock();
     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
     }];
    
}

- (void)modifyPosition:(id)datas
{
    NSMutableDictionary *readDatas = [NSMutableDictionary dictionaryWithDictionary:[keychainItemManager readDatas]];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"userid"] = readDatas[@"userInfo"][@"userId"];
    params[@"surName"] = readDatas[@"userInfo"][@"surName"];
    params[@"telephone"] = readDatas[@"userInfo"][@"telephone"];
    params[@"email"] = @"";
    params[@"position"] = datas[@"positionId"];
    params[@"hasReg"] = @"";
    params[@"businessScope"] = @"";
    params[@"companyAddr"] = @"";
    params[@"companyName"] = @"";
    
    [RequestViewModels requestWithCompelteUserinfo:self params:params success:^(id datas)
     {
         [keychainItemManager writeDatas:datas];
         [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.setSuccess",nil)];
         [_table reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:1]] withRowAnimation:UITableViewRowAnimationNone];
         [self dismissViewController];
     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
     }];

}

- (void)eventWithSignOut
{
    [keychainItemManager deleteDatas];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:[keychainItemManager readCookie]];
    [keychainItemManager deleteCookie];
    
    if (![keychainItemManager readDatas]) {
        [self gotoLogingWithSuccess:^(BOOL success)
         {
             [self reloadTabData];
             _successBlock();
         }class:@"LoginViewController" ];
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