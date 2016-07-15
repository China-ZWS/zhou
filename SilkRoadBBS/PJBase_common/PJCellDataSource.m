//
//  PJCellDataSource.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/17.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJCellDataSource.h"

@implementation PJCellDataSource

- (void)dealloc
{
    NSLog(@"%@",self);
}

#pragma mark -
#pragma mark  delegate
#pragma mark -
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 0;
}

#pragma mark -
#pragma mark dataSource
#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 0;
}



// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [scrollView endEditing:YES];
}

@end
