//
//  ForgetPwdCellDataSource.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/18.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJCellDataSource.h"
#import "ForgetPwdCell.h"

@protocol ForgetPwdCellDataSourceDelegate <PJCellDataSourceDelegate>
@optional
- (void)tableViewCellForTouchesCode:(ForgetPwdCell *)tableViewCell;
- (void)tableViewCellForBeginEditField:(ForgetPwdCell *)tableViewCell;
@end

@interface ForgetPwdCellDataSource : PJCellDataSource
@property (nonatomic) NSString *account;
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *pwd;

@end

