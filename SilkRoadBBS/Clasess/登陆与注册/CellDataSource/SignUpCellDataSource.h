//
//  SignUpCellDataSource.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/17.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJCellDataSource.h"
#import "SignUpCell.h"

@protocol SignUpCellDataSourceDelegaet <PJCellDataSourceDelegate>

@optional
- (void)tableViewCellForTouchesCode:(SignUpCell *)tableViewCell;
- (void)tableViewCellForBeginEditField:(SignUpCell *)tableViewCell;
@end
@interface SignUpCellDataSource : PJCellDataSource
@property (nonatomic) NSString *account;
@property (nonatomic) NSString *code;
@property (nonatomic) NSString *pwd;
@property (nonatomic) NSString *rePwd;
@property (nonatomic) NSString *caregory;
@property (nonatomic) NSString *company;
@end
