//
//  PJTextView.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJTextView.h"


@interface PJTextView ()
@property (nonatomic) UIButton *btn;
@end
@implementation PJTextView


- (UIButton *)btn
{
    return _btn = ({
        UIButton *v = nil;
        if (_btn) {
            v = _btn;
        }
        else
        {
            v = UIButton.new;
            [v setContentHorizontalAlignment:UIControlContentHorizontalAlignmentRight];
            [v setImage:[UIImage imageNamed:@"jianpan.png"] forState:UIControlStateNormal];
            [v setImage:[UIImage imageNamed:@"jianpan_action.png"] forState:UIControlStateHighlighted];
            [v addTarget:self action:@selector(hideKeyBoard:) forControlEvents:UIControlEventTouchUpInside];
        }
        v;
    });
}

- (UILabel *)placeHolder
{
    return _placeHolder = ({
        UILabel *lb = nil;
        if (_placeHolder) {
            lb = _placeHolder;
        }
        else
        {
            lb = UILabel.new;
            lb.enabled = NO;
            lb.text = NSLocalizedString(@"PostViewController.textPlaceholder",nil);
            lb.font = NFont(15);
            lb.textColor = CustomlightGray;
        }
        lb;
    });
}

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];
        self.tintColor= CustomlightGray;
        UIView *v= UIView.new;
        v.height = 30;
        [v addSubview:self.btn];
        [self addSubview:self.placeHolder];
        self.inputAccessoryView = v;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _btn.frame = CGRectMake(DeviceW - 50, 0, 40, 30);
    _placeHolder.frame = CGRectMake(10,self.textContainerInset.top,100,20);
}

-(void)hideKeyBoard:(id)sender
{
    [self resignFirstResponder];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
