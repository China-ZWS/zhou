//
//  PJCellDataSource.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/17.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PJCellDataSource;

@protocol PJCellDataSourceDelegate;
@interface PJCellDataSource : NSObject
<UITableViewDelegate, UITableViewDataSource>
{
    id _datas;
   __unsafe_unretained id <PJCellDataSourceDelegate> _delegate;
}
@property (nonatomic) id datas;
@property (nonatomic, assign) id<PJCellDataSourceDelegate>delegate;
@end

@protocol PJCellDataSourceDelegate <NSObject>
@optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end