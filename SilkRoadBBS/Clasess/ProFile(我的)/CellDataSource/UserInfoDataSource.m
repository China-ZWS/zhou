
//
//  UserInfoDataSource.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "UserInfoDataSource.h"
#import "UserInfoCell.h"

@implementation UserInfoDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_datas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 80;
    }
    return 45;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datas[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UserInfoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier   ];
    }
    
    [cell setDatas:_datas[indexPath.section][indexPath.row] indexPath:indexPath];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)] && [_delegate conformsToProtocol:@protocol(PJCellDataSourceDelegate)])
    {
        [_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
}


@end
