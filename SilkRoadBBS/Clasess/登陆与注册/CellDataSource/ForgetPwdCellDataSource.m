//
//  ForgetPwdCellDataSource.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/18.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ForgetPwdCellDataSource.h"
#import "ForgetPwdCell.h"

@interface ForgetPwdCellDataSource ()
<ForgetPwdCellDelegate>
@end
@implementation ForgetPwdCellDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [_datas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    ForgetPwdCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ForgetPwdCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    [cell setDatas:_datas[indexPath.row] indexPath:indexPath];
    return cell;
}




#define SignUpCellDelegate
- (void)tableViewCellForTouchesCode:(ForgetPwdCell *)tableViewCell
{
    if ([_delegate respondsToSelector:@selector(tableViewCellForTouchesCode:)] && [_delegate conformsToProtocol:@protocol(ForgetPwdCellDataSourceDelegate)])
    {
        [(id<ForgetPwdCellDataSourceDelegate>)_delegate tableViewCellForTouchesCode:tableViewCell];
    }
    
}

- (void)tableViewCellForBeginEditField:(ForgetPwdCell *)tableViewCell;
{
    if ([_delegate respondsToSelector:@selector(tableViewCellForBeginEditField:)] && [_delegate conformsToProtocol:@protocol(ForgetPwdCellDataSourceDelegate)])
    {
        [(id<ForgetPwdCellDataSourceDelegate>)_delegate tableViewCellForBeginEditField:tableViewCell];
    }
}

- (void)tableViewCellForChangeField:(ForgetPwdCell *)tableViewCell
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
        default:
            break;
    }
}


@end
