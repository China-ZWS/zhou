//
//  ReSignUpCell.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/12.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJTableViewCell.h"
#import "BaseTextField.h"
#import "PJTextView.h"

@protocol ReSignUpCellDelegate ;

@interface ReSignUpCell : PJTableViewCell
@property (nonatomic) BaseTextField *field;
@property (nonatomic) PJTextView *tView;
@property (nonatomic, assign) id <ReSignUpCellDelegate>delegate;

- (void)setDatas:(id)datas indexPath:(NSIndexPath *)indexPath;

@end

@protocol ReSignUpCellDelegate <NSObject>

@optional
- (void)tableViewCellForBeginEditField:(ReSignUpCell *)tableViewCell;
- (void)tableViewCellForChangeField:(ReSignUpCell *)tableViewCell;
- (void)tableViewCellForBeginEditTView:(ReSignUpCell *)tableViewCell;
- (void)tableViewCellForChangeTView:(ReSignUpCell *)tableViewCell;
- (void)tableViewCellForShowPosition:(ReSignUpCell *)tableViewCell;
@end
