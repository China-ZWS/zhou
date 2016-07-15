//
//  ReSignUpCellDataSource.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/17.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJCellDataSource.h"
#import "ReSignUpCell.h"
@protocol ReSignUpCellDataSourceDelegaet <PJCellDataSourceDelegate>

@optional
- (void)tableViewCellForBeginEditField:(ReSignUpCell *)tableViewCell;
- (void)tableViewCellForBeginEditTView:(ReSignUpCell *)tableViewCell;
- (void)tableViewCellForShowPosition:(ReSignUpCell *)tableViewCell;
@end

@interface ReSignUpCellDataSource : PJCellDataSource
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSString *email;
@property (nonatomic) NSString *businessScope;
@property (nonatomic) NSString *address;
@end
