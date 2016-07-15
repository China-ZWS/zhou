//
//  SignUpCell.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/11.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJTableViewCell.h"
#import "BaseTextField.h"

@class SignUpCell;
@protocol SignUpCellDelegate;


@interface SignUpCell : PJTableViewCell
@property (nonatomic) BaseTextField *field;
@property (nonatomic) UIButton *codeBtn;
@property (nonatomic, assign) id <SignUpCellDelegate>delegate;
- (void)setDatas:(id)datas indexPath:(NSIndexPath *)indexPath;
- (void)countDown;

@end

@protocol SignUpCellDelegate <NSObject>


@optional
- (void)tableViewCellForTouchesCode:(SignUpCell *)tableViewCell;
- (void)tableViewCellForBeginEditField:(SignUpCell *)tableViewCell;
- (void)tableViewCellForChangeField:(SignUpCell *)tableViewCell;



@end