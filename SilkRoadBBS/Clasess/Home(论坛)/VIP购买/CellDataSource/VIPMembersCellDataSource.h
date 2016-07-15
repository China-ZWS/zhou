//
//  VIPMembersCellDataSource.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/4.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJCellDataSource.h"
@protocol VIPMembersCellDataSourceDelegaet <PJCellDataSourceDelegate>

@optional
- (void)eventWithPay;
@end

@interface VIPMembersCellDataSource : PJCellDataSource
@property (nonatomic) id requestWithDatas;

@end
