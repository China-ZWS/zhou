//
//  RepliesView.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "RepliesView.h"
#import "PJTextField.h"
#import "PJTextView.h"

@interface RepliesView ()
@property (nonatomic) PJTextField *titleField;
@property (nonatomic) PJTextView *textView;
@end

@implementation RepliesView

- (id)initWithFrame:(CGRect)frame
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
            field.placeholder = NSLocalizedString(@"RepliesViewController.fieldPlaceholder",nil);
            field.font = NFont(16);
            field.textColor = CustomBlack;
            [field becomeFirstResponder];
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
    _textView.frame = CGRectMake(15, _titleField.bottom + 5, self.width - 30, self.height - _titleField.bottom - 10);
}

- (NSString *)getPostTitle;
{
    return _titleField.text;
}

- (NSString *)getpostContent;
{
    return _textView.text;
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
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
