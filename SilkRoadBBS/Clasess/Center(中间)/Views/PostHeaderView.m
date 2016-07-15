//
//  PostHeaderView.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PostHeaderView.h"
#import "PJTextField.h"
#import "PJTextView.h"

@interface PostHeaderView ()
<UITextViewDelegate>
@property (nonatomic) PJTextField *titleField;
@property (nonatomic) PJTextView *textView;
@end

@implementation PostHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor whiteColor];
        [self layoutViews];
    }
    return self;
}

- (PJTextField *)titleField
{
    return _titleField = ({
        PJTextField *field = nil;
        if (_titleField) {
            field = _titleField;
        }
        else
        {
            field = PJTextField.new;
            field.borderColor = CustomlightGray;
            field.borderType = kLine;
            field.placeholder = NSLocalizedString(@"PostViewController.fieldPlaceholder",nil);
            [field setValue:CustomlightGray forKeyPath:@"_placeholderLabel.textColor"];
            field.font = NFont(16);
            field.textColor = CustomBlack;
            [field addTarget:self action:@selector(changeFieldText) forControlEvents:UIControlEventEditingChanged];
        }
        field;
    });
}

- (PJTextView *)textView
{
    return _textView = ({
        PJTextView *text = nil;
        if (_textView) {
            text = _textView;
        }
        else
        {
            text = PJTextView.new;
            text.font = NFont(15);
            text.textColor = CustomBlack;
            text.delegate = self;
        }
        text;
    });
}




- (void)layoutViews
{
    [self addSubview:self.titleField];
    [self addSubview:self.textView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _titleField.frame = CGRectMake(15, 5, self.width - 30, 45);
    _textView.frame = CGRectMake(15, _titleField.bottom + 5, self.width - 30, 150);
}

- (void)setChangeText:(void (^)(NSString *, NSString *))changeText
{
    if (_changeText) {
        _changeText = nil;
    }
    _changeText = changeText;
}

- (void)changeFieldText
{
    _changeText(_titleField.text, _textView.text);
}


- (void)textViewDidChange:(PJTextView *)textView;
{
    if(![textView.text isEqualToString:@""])
    {
        [textView.placeHolder setHidden:YES];
    }
    else
    {
        [textView.placeHolder setHidden:NO];
    }

    _changeText(_titleField.text, _textView.text);
}
@end
