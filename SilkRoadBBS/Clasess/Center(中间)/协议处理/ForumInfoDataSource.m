//
//  ForumInfoDataSource.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/8.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ForumInfoDataSource.h"
#import "ForumInfoCell.h"

@interface ForumInfoHeader : UITableViewHeaderFooterView
@property (nonatomic) UILabel *titleLb;
@end

@implementation ForumInfoHeader

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithReuseIdentifier:reuseIdentifier])) {
        self.contentView.backgroundColor = self.backgroundColor =  RGBA(238, 238, 238, 1);
        _titleLb = UILabel.new;
        _titleLb.font = NFont(16);
        _titleLb.textColor = CustomGray;
        [self.contentView addSubview:_titleLb];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleLb.frame = CGRectMake(15, 0, 200, self.height);
}

@end

@implementation ForumInfoDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_datas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.0001;
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"headerIdentifier";
    ForumInfoHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    
    if (!header) {
        header = [[ForumInfoHeader alloc] initWithReuseIdentifier:headerIdentifier];
    }
    if (section == 0)
    {
        header.titleLb.text = NSLocalizedString(@"ForumInfoViewController.section0Title",nil);
    }
    else
    {
        header.titleLb.text = NSLocalizedString(@"ForumInfoViewController.section1Title",nil);
    }
    return header;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datas[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    ForumInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[ForumInfoCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    
    cell.datas = _datas[indexPath.section][indexPath.row];
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
