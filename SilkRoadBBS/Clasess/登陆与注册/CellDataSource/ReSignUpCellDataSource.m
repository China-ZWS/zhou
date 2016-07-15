//
//  ReSignUpCellDataSource.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/17.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ReSignUpCellDataSource.h"

@interface RSHeaderView : UITableViewHeaderFooterView
@property (nonatomic) UILabel *title;
@end

@implementation RSHeaderView
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithReuseIdentifier:reuseIdentifier])) {
        _title = UILabel.new;
        _title.font = NFont(16);
        [self.contentView addSubview:_title];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _title.frame = CGRectMake(10, (self.height - _title.font.lineHeight) / 2, self.width - 20, _title.font.lineHeight);
}


@end


@interface ReSignUpCellDataSource ()
<ReSignUpCellDelegate>
@end
@implementation ReSignUpCellDataSource

- (id)init
{
    if ((self = [super init])) {
        _businessScope = @"";
        _address = @"";
    }
    return self;
}

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
    if (section == 0) {
        return 35;
    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"headerIdentifier";
    RSHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (!header) {
        header = [[RSHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
    }
    if (section == 0)
    {
        header.title.text = NSLocalizedString(@"ReSignUpViewController.info",nil);
    }
    else
    {
        header.title.text = nil;
    }
    return header;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 45;
    }
    return 120;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    ReSignUpCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ReSignUpCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.delegate = self;
    }
    [cell setDatas:_datas[indexPath.section][indexPath.row] indexPath:indexPath];
    return cell;
}

- (void)tableViewCellForBeginEditField:(ReSignUpCell *)tableViewCell
{
    if ([_delegate respondsToSelector:@selector(tableViewCellForBeginEditField:)] && [_delegate conformsToProtocol:@protocol(ReSignUpCellDataSourceDelegaet)])
    {
        [(id<ReSignUpCellDataSourceDelegaet>)_delegate tableViewCellForBeginEditField:tableViewCell];
    }

}




- (void)tableViewCellForBeginEditTView:(ReSignUpCell *)tableViewCell;
{
  
    if ([_delegate respondsToSelector:@selector(tableViewCellForBeginEditTView:)] && [_delegate conformsToProtocol:@protocol(ReSignUpCellDataSourceDelegaet)])
    {
        [(id<ReSignUpCellDataSourceDelegaet>)_delegate tableViewCellForBeginEditTView:tableViewCell];
    }
}


- (void)tableViewCellForChangeField:(ReSignUpCell *)tableViewCell
{
    
    NSInteger tag = tableViewCell.field.tag;
    switch (tag) {
        case 1:
            _name = tableViewCell.field.text;
            break;
        case 2:
            _phone = tableViewCell.field.text;
            break;
        case 3:
            _email = tableViewCell.field.text;
            break;
        default:
            break;
    }
}

- (void)tableViewCellForChangeTView:(ReSignUpCell *)tableViewCell;
{
    NSInteger tag = tableViewCell.tView.tag;
    switch (tag) {
        case 1:
            _businessScope = tableViewCell.tView.text;
            break;
        case 2:
            _address = tableViewCell.tView.text;
            break;
        default:
            break;
    }
    
}

- (void)tableViewCellForShowPosition:(ReSignUpCell *)tableViewCell;
{
    if ([_delegate respondsToSelector:@selector(tableViewCellForShowPosition:)] && [_delegate conformsToProtocol:@protocol(ReSignUpCellDataSourceDelegaet)])
    {
        [(id<ReSignUpCellDataSourceDelegaet>)_delegate tableViewCellForShowPosition:tableViewCell];
    }
}



@end
