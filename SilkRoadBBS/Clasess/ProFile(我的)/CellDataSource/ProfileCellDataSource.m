//
//  ProfileCellDataSource.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/19.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ProfileCellDataSource.h"

@implementation ProfileCellDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_datas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ProfileCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    cell.datas = _datas[indexPath.row];
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
