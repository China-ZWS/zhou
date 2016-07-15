//
//  VIPMembersCellDataSource.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/4.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "VIPMembersCellDataSource.h"
#import "VIPMembersCell.h"

@implementation VIPMembersCellDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_datas count] + ([_requestWithDatas count]?1:0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_requestWithDatas count])
    {
        if (indexPath.row == 0) {
            return 70;
        }
        else
        {
            NSDictionary *datas = _datas[indexPath.row - 1];
            CGSize size1 = [NSObject getSizeWithText:NSLocalizedString(datas[@"title"],nil) font:NFont(16) maxSize:CGSizeMake(tableView.width - 45 - 40, NFont(16).lineHeight * 2)];
            CGSize size2 = [NSObject getSizeWithText:NSLocalizedString(datas[@"detailTitle"],nil) font:NFont(14) maxSize:CGSizeMake(tableView.width - 45 - 40, NFont(14).lineHeight * 2)];
            return 25 + size1.height + size2.height;
        }
    }
    else
    {
        NSDictionary *datas = _datas[indexPath.row];
        CGSize size1 = [NSObject getSizeWithText:NSLocalizedString(datas[@"title"],nil) font:NFont(16) maxSize:CGSizeMake(tableView.width - 45 - 40, NFont(16).lineHeight * 2)];
        CGSize size2 = [NSObject getSizeWithText:NSLocalizedString(datas[@"detailTitle"],nil) font:NFont(14) maxSize:CGSizeMake(tableView.width - 45 - 40, NFont(14).lineHeight * 2)];
        return 25 + size1.height + size2.height;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    VIPMembersCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[VIPMembersCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        [(UIButton *)cell.accessoryView addTarget:self action:@selector(eventWithPay) forControlEvents:UIControlEventTouchUpInside];

    }
    
    if ([_requestWithDatas count]) {
        if (indexPath.row == 0)
        {
            cell.requestWithDatas = _requestWithDatas;
        }
        else
        {
            cell.datas = _datas[indexPath.row - 1];
        }
    }
    else
    {
        cell.datas = _datas[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)] && [_delegate conformsToProtocol:@protocol(PJCellDataSourceDelegate)])
    {
        [_delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    
}

- (void)eventWithPay
{
    
    if ([_delegate respondsToSelector:@selector(eventWithPay)] && [_delegate conformsToProtocol:@protocol(PJCellDataSourceDelegate)])
    {
        [(id<VIPMembersCellDataSourceDelegaet>)_delegate eventWithPay];
    }
    

}

@end
