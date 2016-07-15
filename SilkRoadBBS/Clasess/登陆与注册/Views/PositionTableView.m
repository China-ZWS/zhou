//
//  PositionTableView.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/18.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PositionTableView.h"

@interface PositionTableView ()
<UITableViewDelegate, UITableViewDataSource>
{
    void(^_selectedBlock)(id);
}
@end

@implementation PositionTableView

- (void)dealloc
{
    NSLog(@"PositionTableView");
}

- (id) initWithFrame:(CGRect)frame datas:(id)datas selected:(void(^)(id))selected;
{
    if ((self = [super initWithFrame:frame style:UITableViewStylePlain])) {
        self.delegate = self;
        self.dataSource = self;
        _datas = datas;
        _selectedBlock = selected;
        self.autoresizingMask = UIViewAutoresizingNone;
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableFooterView = UIView.new;
    }
    
    return self;
}

#pragma tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_datas count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.font = NFont(15);
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        [cell setSeparatorInset:UIEdgeInsetsMake(0, -15, 0, 10)];
    }
    
    NSDictionary *dic = _datas[indexPath.row];
    cell.textLabel.text = dic[@"positionName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_datas[indexPath.row][@"positionId"] integerValue] < 0) {
        return;
    }
    _selectedBlock(_datas[indexPath.row]);
}


@end
