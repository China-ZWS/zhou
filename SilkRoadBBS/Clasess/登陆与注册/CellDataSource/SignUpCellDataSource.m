//
//  SignUpCellDataSource.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/17.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "SignUpCellDataSource.h"

@interface SignUpCellDataSource ()
<SignUpCellDelegate>
@end

@implementation SignUpCellDataSource



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_datas count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datas[section] count];
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
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    SignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[SignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    if ([_datas count] == 1) {
        [cell setDatas:_datas[indexPath.section][indexPath.row] indexPath:[NSIndexPath indexPathForRow:0 inSection:2]];
    }
    else
    {
        [cell setDatas:_datas[indexPath.section][indexPath.row] indexPath:indexPath];
    }
    return cell;
}

#define SignUpCellDelegate
- (void)tableViewCellForTouchesCode:(SignUpCell *)tableViewCell
{
    if ([_delegate respondsToSelector:@selector(tableViewCellForTouchesCode:)] && [_delegate conformsToProtocol:@protocol(SignUpCellDataSourceDelegaet)])
    {
        [(id<SignUpCellDataSourceDelegaet>)_delegate tableViewCellForTouchesCode:tableViewCell];
    }

}

- (void)tableViewCellForBeginEditField:(SignUpCell *)tableViewCell;
{
    if ([_delegate respondsToSelector:@selector(tableViewCellForBeginEditField:)] && [_delegate conformsToProtocol:@protocol(SignUpCellDataSourceDelegaet)])
    {
        [(id<SignUpCellDataSourceDelegaet>)_delegate tableViewCellForBeginEditField:tableViewCell];
    }
}

- (void)tableViewCellForChangeField:(SignUpCell *)tableViewCell
{
    
    NSInteger tag = tableViewCell.field.tag;
    switch (tag) {
        case 1:
            _account = tableViewCell.field.text;
            break;
        case 2:
            _code = tableViewCell.field.text;
            break;
        case 3:
            _pwd = tableViewCell.field.text;
            break;
        case 4:
            _rePwd = tableViewCell.field.text;
            break;
        case 5:
            _company = tableViewCell.field.text;
            break;
        default:
            break;
    }
}

@end
