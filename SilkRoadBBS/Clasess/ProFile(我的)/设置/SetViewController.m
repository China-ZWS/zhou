//
//  SetViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "SetViewController.h"
#import "SetCellDataSource.h"
#import "HelpViewController.h"
#import "AboutViewController.h"

@interface SetViewController ()
<PJCellDataSourceDelegate>
{
    SetCellDataSource *_dataSource;
}
@end

@implementation SetViewController

- (id)init
{
    if ((self = [super init])) {
        self.title = NSLocalizedString(@"SetViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
        _datas = [DataConfigManager getSettiogslist];
        
    }
    return self;
}

- (void)back
{
    [self popViewController];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataSource = SetCellDataSource.new;
    _dataSource.datas = _datas;
    _dataSource.delegate = self;
    _table.delegate = _dataSource;
    _table.dataSource = _dataSource;
    _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        [self pushViewController:HelpViewController.new];
    }
    else if (indexPath.row == 1)
    {
        [self pushViewController:AboutViewController.new];
    }
    else
    {

        NSURL *url =[NSURL URLWithString:@"http://fir.im/silkroadCode"];
        [[UIApplication sharedApplication] openURL:url];
        

    }
}


-(void)update:(NSString *)responseString
{
    
    NSData *data=[responseString dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
    NSString *resultCount = [dict objectForKey:@"resultCount"];
    if ([resultCount intValue] == 1)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"友情提示" message:@"已是最新版本" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            [alert show];
        });
        
    }
    else if ([resultCount intValue] == 0)
    {
        NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@","];
        NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
        NSString *oldVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
        oldVersion = [oldVersion stringByTrimmingCharactersInSet:set];
        
        NSArray * resultsArray = [dict objectForKey:@"results"];
        NSDictionary *newDict = [resultsArray lastObject];
        NSString *newVersion = [newDict objectForKey:@"version"];
        newVersion = [newVersion stringByTrimmingCharactersInSet:set];
        
        if ([newVersion floatValue] - [oldVersion floatValue] > 0)
        {
            NSURL *url =[NSURL URLWithString:@"http://fir.im/silkroadCode"];
            [[UIApplication sharedApplication] openURL:url];
            
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"已是最新版本" message:nil delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
                [alert show];
            });
        }
        
        
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
