//
//  VIPPayCellDataSource.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/5.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "VIPPayCellDataSource.h"
#import "VIPPayCell.h"

@implementation VIPPayCellDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *datas = _datas[indexPath.row];
    CGSize size1 = [NSObject getSizeWithText:NSLocalizedString(datas[@"title"],nil) font:NFont(16) maxSize:CGSizeMake(tableView.width - 45 - 40 - 50, NFont(16).lineHeight * 2)];
    CGSize size2 = [NSObject getSizeWithText:NSLocalizedString(datas[@"detailTitle"],nil) font:NFont(14) maxSize:CGSizeMake(tableView.width - 45 - 40 - 50, NFont(14).lineHeight * 2)];
    return 25 + size1.height + size2.height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    VIPPayCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[VIPPayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.datas = _datas[indexPath.row];
    return cell;
}

@end
