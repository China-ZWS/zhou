//
//  LoginInputView.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "LoginInputView.h"
#import "BaseTextField.h"



@interface LoginInputView ()
@property (nonatomic) BaseTextField *fieldOne;
@property (nonatomic) BaseTextField *fieldTwo;
@property (nonatomic) UIButton *loginBtn;
@end

@implementation LoginInputView

- (id)initWithFrame:(CGRect)frame success:(void (^)(id))success
{
    if ((self = [super initWithFrame:frame success:success])) {
    }
    return self;
}

- (BaseTextField *)fieldOne
{
    return _fieldOne = ({
        BaseTextField *view = nil;;
        if (_fieldOne) {
            view =  _fieldOne;
        }
        else
        {
            view = BaseTextField.new;
            view.tintColor = CustomlightGray;
            [view getCornerRadius:5 borderColor:CustomlightGray borderWidth:1 masksToBounds:YES];
            view.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_1.png"]];
            [view setValue:CustomlightGray forKeyPath:@"_placeholderLabel.textColor"];
            view.placeholder = NSLocalizedString(@"loginFieldOne",nil);
            view.textColor = CustomBlack;
            view.font = NFont(16);
        }
        
        view;
    });
}

- (BaseTextField *)fieldTwo
{
    return _fieldTwo = ({
        BaseTextField *view = nil;;
        if (_fieldTwo) {
            view =  _fieldTwo;
        }
        else
        {
            view = BaseTextField.new;
            view.secureTextEntry = YES;
            view.delegate = self;
            view.tintColor = CustomlightGray;
            [view getCornerRadius:5 borderColor:CustomlightGray borderWidth:1 masksToBounds:YES];
            [view setValue:CustomlightGray forKeyPath:@"_placeholderLabel.textColor"];
            view.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"login_icon_2.png"]];
            view.placeholder = NSLocalizedString(@"loginFieldTwo",nil);
            view.textColor = CustomBlack;
            view.font = NFont(16);
        }
        view;
    });
}

- (UIButton *)loginBtn
{
    return _loginBtn = ({
        UIButton *btn = nil;
        if (_loginBtn) {
            btn = _loginBtn;
        }
        else
        {
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.titleLabel.font = NFont(16);
            [btn setTitle:NSLocalizedString(@"nextStep",nil) forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(eventWithNext) forControlEvents:UIControlEventTouchUpInside];
            [btn getCornerRadius:5 borderColor:[UIColor clearColor] borderWidth:1 masksToBounds:YES];
            btn.backgroundColor = CustomBlue;
        }
        btn;
    });
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _fieldOne.frame = CGRectMake(0, 0, self.width, 45);
    _fieldTwo.frame = CGRectMake(0, _fieldOne.bottom + 10, self.width, 45);
    _loginBtn.frame = CGRectMake(0, _fieldTwo.bottom + 20, self.width, 45);

    NSInteger type = NSLocalizedString(@"type",nil).integerValue;
    // 中国
    if (type == 1) {
        _fieldOne.keyboardType = UIKeyboardTypeNumberPad;
    }
    // 孟加拉
    else if (type == 2)
    {
        _fieldOne.keyboardType = UIKeyboardTypeEmailAddress;
    }
}

- (void)layoutViews
{
    [self addSubview:self.fieldOne];
    [self addSubview:self.fieldTwo];
    [self addSubview:self.loginBtn];
}


- (void)eventWithNext
{
    _success(@{@"acc":_fieldOne.text,@"pwd":_fieldTwo.text});
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
