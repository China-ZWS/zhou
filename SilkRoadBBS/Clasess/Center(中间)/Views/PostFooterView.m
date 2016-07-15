//
//  PostFooterView.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PostFooterView.h"

@interface PostFooterView ()
@property (nonatomic) UILabel *textLb;
@property (nonatomic) UILabel *detailTextLb;
@property (nonatomic) UIImageView *accessoryView;
@end

@implementation PostFooterView

- (void)drawRect:(CGRect)rect
{
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    
    [RGBA(238, 238, 238, 1) setFill];
    CGContextAddRect(context, CGRectMake(0, 0, rect.size.width, 10));
    CGContextAddRect(context, CGRectMake(0, rect.size.height - 10, rect.size.width, 10));
    CGContextDrawPath(context,kCGPathFill);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor whiteColor];
        [self layoutViews];
    }
    return self;
}


- (UILabel *)textLb
{
    return _textLb = ({
        UILabel *lb = nil;
        if (_textLb) {
            lb = _textLb;
        }
        else
        {
            lb = UILabel.new;
            lb.textColor = CustomBlack;
            lb.font = NFont(16);
            lb.text = NSLocalizedString(@"PostViewController.optionPlate",nil);
        }
        lb;
    });
}

- (UILabel *)detailTextLb
{
    return _detailTextLb = ({
        UILabel *lb = nil;
        if (_detailTextLb) {
            lb = _detailTextLb;
        }
        else
        {
            lb = UILabel.new;
            lb.textColor = CustomlightGray;
            lb.font = NFont(16);
            lb.textAlignment = NSTextAlignmentRight;
            lb.text = NSLocalizedString(@"ForumInfoViewController.navTitle",nil);
        }
        lb;
    });
}

- (UIImageView *)accessoryView
{
    return _accessoryView = ({
        UIImageView *v = nil;
        if (_accessoryView) {
            v = _accessoryView;
        }
        else
        {
            v = UIImageView.new;
            v.contentMode = UIViewContentModeScaleAspectFit;
            v.image = [UIImage imageNamed:@"right.png"];
        }
        v;
    });
    
}

- (void)layoutViews
{
    [self addSubview:self.textLb];
    [self addSubview:self.detailTextLb];
    [self addSubview:self.accessoryView];
    WEAKSELF
    _showSelectedTitle = ^(NSString *title)
    {
        weakSelf.detailTextLb.text = title;
        weakSelf.detailTextLb.textColor = CustomBlack;
    };

}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _textLb.frame = CGRectMake(15, 0, 100, self.height);
    _accessoryView.frame = CGRectMake(self.width - 15 - _accessoryView.image.size.width, (self.height - _accessoryView.image.size.height) / 2, _accessoryView.image.size.width, _accessoryView.image.size.height);
    _detailTextLb.frame = CGRectMake(_textLb.right + 5, 0, _accessoryView.left - _textLb.right - 10, self.height);
}

- (void)setPushForumInfo:(void (^)())pushForumInfo
{
    if (_pushForumInfo) {
        _pushForumInfo = nil;
    }
    _pushForumInfo = pushForumInfo;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;
{
    _pushForumInfo();
}

@end
