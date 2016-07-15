//
//  CPInputView.m
//  PocketConcubine
//
//  Created by 周文松 on 15-5-24.
//  Copyright (c) 2015年 TalkWeb. All rights reserved.
//

#import "BaseInputView.h"
#import "Header.h"

@interface BaseInputView ()
{
    CGFloat _selfMinY;
}
@end

@implementation BaseInputView

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (UILabel *)setLeftTitle:(NSString *)title;
{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    label.textColor = [UIColor blackColor];
    [label sizeToFit];
    return label;
}


- (id)initWithFrame:(CGRect)frame success:(void(^)(id))success;
{
    if ((self = [super initWithFrame:frame]))
    {
        _success = [success copy];
        _selfMinY = CGRectGetMinY(frame);
        [self layoutViews];
        [self notificationCenter];
    }
    return self;
}

- (void)layoutViews
{
    
}

- (void)setFieldDelegate:(BaseTextField *)fieldDelegate
{
    fieldDelegate.delegate = self;
}

- (void)setTextDelegate:(BaseTextView *)textDelegate
{
    textDelegate.delegate = self;
}


#pragma mark - 初始化通知
-(void)notificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}



#pragma mark - 键盘调用的事件
- (void)keyboardWasShow:(NSNotification *)notification
{
    [self moveTextViewForKeyboard:notification up:YES];
}

#pragma mark - 键盘消失调用的事件
-(void)keyboardWasHidden:(NSNotification *)notification
{
    [self moveTextViewForKeyboard:notification up:NO];
}

- (void) moveTextViewForKeyboard:(NSNotification*)aNotification up: (BOOL) up
{
    
    if (!self.window) {
        return;
    }

    NSDictionary* userInfo = [aNotification userInfo];
    // Get animation info from userInfo
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&_animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&_animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&_keyboardEndFrame];
    _isShow = up;
    
    if (up)
    {
        [self calculateInsetHeight];
        
    }
    else
    {
        self.transform = CGAffineTransformIdentity;
        
    }
}

- (void)calculateInsetHeight
{
    if (!_isShow) {
        return;
    }
    CGRect rect = [self.window convertRect:_keyboardEndFrame toView:self.superview];
    CGFloat insetHeight = CGRectGetMaxY(_currentField.frame) + _selfMinY - CGRectGetMinY(rect);
    if (insetHeight > 0)
    {
        self.transform=CGAffineTransformMakeTranslation(0, -insetHeight);
    }
    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField;           // became first responder
{
    if (_currentField)
    {
        
        _currentField = nil;
    }
    
    _currentField = textField;
}



- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    if (_currentField)
    {
        _currentField = nil;
    }
    
    _currentField = textView;
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (1 == range.length) {//按下回格键
        return YES;
    }
    
    if ([text isEqualToString:@"\n"]) {//按下return键
        //这里隐藏键盘，不做任何处理
        [textView resignFirstResponder];
        return NO;
    }else {
        if ([textView.text length] <= 200) {//判断字符件数
            return YES;
        }
    }
    return NO;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
