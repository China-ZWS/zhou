//
//  BasePopupView.m
//  BaseObject
//
//  Created by Song on 16/5/31.
//  Copyright © 2016年 TalkWeb. All rights reserved.
//

#import "BasePopupView.h"
#import "UIView+Additions.h"

#define insetHeight 35
@interface BasePopupView ()
{
    void(^_successBlock)(id);
    void(^_cancel)();
}
@property (nonatomic) UIView *contentView;
@property (assign) BOOL removeFromSuperViewOnHide;
@property (nonatomic) UIView *coverView;
@property (nonatomic) UIButton *cancelBtn;
@property (nonatomic) UIView *clarityView;
@end

@implementation BasePopupView

#pragma mark - 类方法
#pragma mark  显示
+ (id)showView:(UIWindow *)window
{
    BasePopupView *view = [BasePopupView new];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.shadowPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:5].CGPath;
    view.layer.cornerRadius = 5;
    view.layer.borderColor = [UIColor clearColor].CGColor;
    view.layer.borderWidth = 1;
    view.layer.masksToBounds = YES;

    [window addSubview:view.coverView];
    [window addSubview:view.clarityView];
    [view.clarityView addSubview:view];
    [view.clarityView addSubview:view.cancelBtn];
    return view;
}

+ (id)showInView:(void(^)(id))showInView
{
    BasePopupView *view = [BasePopupView showView:[UIApplication sharedApplication].keyWindow];
    showInView(view);
    return view;

}

+ (BOOL)hideForView
{
    BasePopupView *view = [self menuForView:[UIApplication sharedApplication].keyWindow];
    if (view != nil)
    {
        view.removeFromSuperViewOnHide = YES;
        [view hide];
        return YES;
    }
    return NO;
}

+ (BasePopupView *)menuForView:(UIView *)view
{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        subviewsEnum = [subview.subviews reverseObjectEnumerator];
        for (UIView *reSubview in subviewsEnum)
        {
            if ([reSubview isKindOfClass:self])
            {
                return (BasePopupView *)reSubview;
            }
        }
    }
    return nil;
}

#pragma mark - 实例方法
- (BasePopupView *(^)(UIView *contentView))addContentView;
{
    return ^BasePopupView *(UIView *contentView)
    {
        self.contentView = contentView;
        [self addSubview:contentView];
        [self setFrameWithSelf];
        return self;
    };
}
#pragma mark - 实例化subViews
- (UIView *)coverView
{
    if (!_coverView)
    {
        _coverView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _coverView.backgroundColor = [UIColor colorWithRed:20.f/255.0 green:20.f/255.0 blue:20.f/255.0 alpha:1];
        _coverView.alpha = 0;
    }
    return _coverView;
}

- (UIView *)clarityView
{

    
    if (!_clarityView) {
        _clarityView = UIView.new;
        _clarityView.frame = [UIScreen mainScreen].bounds;
        _clarityView.backgroundColor = [UIColor clearColor];
    }
    return _clarityView;
}

- (UIButton *)cancelBtn
{
    return _cancelBtn = ({
        UIImage *cancelImg = [UIImage imageNamed:@"red_packge_close.png"];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(CGRectGetWidth(self.frame) - cancelImg.size.width / 2, CGRectGetHeight(self.frame) - cancelImg.size.height / 2, cancelImg.size.width, cancelImg.size.height);
        [btn setImage:cancelImg forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(eventWithCancel) forControlEvents:UIControlEventTouchUpInside];
        btn;
    });
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _cancelBtn.center = CGPointMake(CGRectGetMaxX(self.frame), CGRectGetMinY(self.frame));
    _contentView.center = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) / 2 );

    _coverView.alpha = 0.5;
    self.alpha = 1.0;
    
    [UIView shakeToShow:_clarityView duration:.3f];

}

- (void)setFrameWithSelf
{
    
    CGFloat width = CGRectGetWidth(_contentView.frame);
    CGFloat height = CGRectGetHeight(_contentView.frame) + insetHeight;
    CGFloat minX = (CGRectGetWidth(_clarityView.frame) - width) / 2;
    CGFloat minY = (CGRectGetHeight(_clarityView.frame) - height) / 2;
    self.frame = CGRectMake(minX, minY, width, height);
}


#pragma mark - 事件
- (void)eventWithCancel
{
    _removeFromSuperViewOnHide = YES;
    [self hide];

}

- (void)hide
{
    [self.window endEditing:YES];
    if (_removeFromSuperViewOnHide)
        _removeFromSuperViewOnHide = NO;

    [UIView animateWithDuration:.3 animations:^
     {
         _coverView.alpha = 0;
         _cancelBtn.alpha = 0;
         _clarityView.alpha  = 0;
         self.alpha = 0;
         _clarityView.transform = CGAffineTransformMakeScale(.1,.1);
     }completion:^(BOOL finished){
         [_coverView removeFromSuperview];
         [_clarityView removeFromSuperview];
         [_cancelBtn removeFromSuperview];
         [self removeFromSuperview];
     }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
