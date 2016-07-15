//
//  SignUpCell.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/11.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "SignUpCell.h"

@interface SignUpCell ()
<UITextFieldDelegate>
{
    dispatch_source_t _timer;

}
@property (nonatomic) NSIndexPath *indexPath;
@end

@implementation SignUpCell

- (void)dealloc
{
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
    {
        self.backgroundColor = self.contentView.backgroundColor = [UIColor whiteColor];
        _field = BaseTextField.new;
        _field.font = NFont(16);
        _field.textColor = CustomBlack;
        _field.tintColor = CustomlightGray;
        _field.delegate = self;
        [_field addTarget:self action:@selector(eventWithFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [_field addTarget:self action:@selector(eventWithFieldChanged:) forControlEvents:UIControlEventEditingChanged];


        [self.contentView addSubview:_field];
        
        _codeBtn = UIButton.new;
        _codeBtn.backgroundColor = CustomBlue;
        [_codeBtn getCornerRadius:5 borderColor:nil borderWidth:0 masksToBounds:NO];
        [_codeBtn setTitle:NSLocalizedString(@"sendCode",nil) forState:UIControlStateNormal];
        [_codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _codeBtn.titleLabel.font = NFont(13);
        [_codeBtn addTarget:self action:@selector(eventWithGetAuthCode) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_codeBtn];

        self.textLabel.font = NFont(16);
        self.textLabel.textColor = CustomBlack;
        self.textLabel.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [NSObject getSizeWithText:self.textLabel.text font:self.textLabel.font maxSize:CGSizeMake(100,self.textLabel.font.lineHeight)];
    self.textLabel.width = size.width;
    if (!_codeBtn.hidden) {
        _codeBtn.frame = CGRectMake(self.width - (self.width / 4 - 5) - 10, 5, self.width / 4 - 10, self.height - 10);
    }
    else
    {
        _codeBtn.frame = CGRectZero;
    }

    _field.frame = CGRectMake(size.width?(self.textLabel.right + 10):self.textLabel.left, 0, self.width - self.textLabel.right - 40 - (_codeBtn.width), self.height);
}

- (void)setDatas:(id)datas indexPath:(NSIndexPath *)indexPath
{
    _field.hasEvent = NO;
    if (indexPath.section == 0)
    {
        self.textLabel.hidden = YES;
        _field.secureTextEntry = NO;

        if (indexPath.row == 0) {
            _codeBtn.hidden = YES;
            NSInteger type = NSLocalizedString(@"type",nil).integerValue;
            if (type == 1) {
                _field.keyboardType = UIKeyboardTypeNumberPad;
            }
            // 孟加拉
            else if (type == 2)
            {
                _field.keyboardType = UIKeyboardTypeEmailAddress;
            }
            _field.tag = 1;
        }
        else if (indexPath.row == 1)
        {
            _codeBtn.hidden = NO;
            _field.keyboardType = UIKeyboardTypeNumberPad;
            _field.tag = 2;
        }
    }
    else if (indexPath.section == 1)
    {
        self.textLabel.hidden = _codeBtn.hidden = YES;
        _field.keyboardType = UIKeyboardTypeDefault;
        _field.secureTextEntry = YES;

        if (indexPath.row == 0) {
            _field.tag = 3;
        }
        else if (indexPath.row == 1)
        {
            _field.tag = 4;
        }
    }
    else if (indexPath.section == 2)
    {
        
        _field.keyboardType = UIKeyboardTypeDefault;
        self.textLabel.hidden = NO;
        _field.secureTextEntry = NO;
        _codeBtn.hidden = YES;
        NSString *title = [@"*" stringByAppendingString:NSLocalizedString(datas[@"title"],nil)];
        NSMutableAttributedString *attString =  [[NSMutableAttributedString alloc] initWithString:title];
        
        NSRange range = NSMakeRange(0,1);
        [attString addAttribute:NSForegroundColorAttributeName value:CustomRed range:range];
        self.textLabel.attributedText = attString;
  
        _field.tag = 5;
    }
    _field.placeholder = NSLocalizedString(datas[@"placeholder"],nil);
}

- (void)eventWithGetAuthCode
{
    
    
    if ([_delegate respondsToSelector:@selector(tableViewCellForTouchesCode:)] && [_delegate conformsToProtocol:@protocol(SignUpCellDelegate)])
    {
        [_delegate tableViewCellForTouchesCode:self];
    }
}

- (void)countDown
{
    _codeBtn.backgroundColor = CustomlightGray;
    _codeBtn.userInteractionEnabled = NO;
    
    UIButton __weak*safeBtn = _codeBtn;
    __block NSInteger timeout = 30; //倒计时时间
    if (_timer) {
        dispatch_source_cancel(_timer);
        _timer = nil;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_t __weak safeTimer = _timer;
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(safeTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                safeBtn.userInteractionEnabled = YES;
                safeBtn.backgroundColor = CustomBlue;
                [safeBtn setTitle:NSLocalizedString(@"sendCode",nil) forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 31;
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [safeBtn setTitle:[NSString stringWithFormat:@"%@(%d)",NSLocalizedString(@"reSendCode",nil), seconds] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    
    dispatch_resume(_timer);

}


- (void)eventWithFieldBegin:(BaseTextField *)field
{
    if ([_delegate respondsToSelector:@selector(tableViewCellForBeginEditField:)] && [_delegate conformsToProtocol:@protocol(SignUpCellDelegate)])
    {
        [_delegate tableViewCellForBeginEditField:self];
    }
}

- (void)eventWithFieldChanged:(BaseTextField *)field
{
   
    if ([_delegate respondsToSelector:@selector(tableViewCellForChangeField:)] && [_delegate conformsToProtocol:@protocol(SignUpCellDelegate)])
    {
        [_delegate tableViewCellForChangeField:self];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
