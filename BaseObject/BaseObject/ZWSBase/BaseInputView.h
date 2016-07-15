//
//  CPInputView.h
//  PocketConcubine
//
//  Created by 周文松 on 15-5-24.
//  Copyright (c) 2015年 TalkWeb. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTextField.h"
#import "BaseTextView.h"

@interface BaseInputView : UIView
<UITextFieldDelegate, UITextViewDelegate>
{
    BOOL _isShow;
    NSTimeInterval _animationDuration;
    UIViewAnimationCurve _animationCurve;
    CGRect _keyboardEndFrame;
    UIView *_currentField;
    void (^_success)(id);
}

- (id)initWithFrame:(CGRect)frame success:(void(^)(id))success;
- (void)layoutViews;
- (UILabel *)setLeftTitle:(NSString *)title;

@end