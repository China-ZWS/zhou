//
//  ForgetPwdCell.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/18.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJTableViewCell.h"
#import "BaseTextField.h"

@class ForgetPwdCell;
@protocol ForgetPwdCellDelegate <NSObject>

@optional
- (void)tableViewCellForTouchesCode:(ForgetPwdCell *)tableViewCell;
- (void)tableViewCellForChangeField:(ForgetPwdCell *)tableViewCell;
- (void)tableViewCellForBeginEditField:(ForgetPwdCell *)tableViewCell;

@end


@interface ForgetPwdCell : PJTableViewCell

@property (nonatomic) BaseTextField *field;
@property (nonatomic) UIButton *codeBtn;
@property (nonatomic, assign) id <ForgetPwdCellDelegate>delegate;
- (void)setDatas:(id)datas indexPath:(NSIndexPath *)indexPath;
- (void)countDown;

@end
