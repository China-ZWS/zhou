//
//  BaseKeyBoardViewController.m
//  BaseObject
//
//  Created by Song on 16/5/30.
//  Copyright © 2016年 TalkWeb. All rights reserved.
//

#import "BaseKeyBoardViewController.h"

@interface BaseKeyBoardViewController ()
{
    NSTimeInterval _animationDuration;
    UIViewAnimationCurve _animationCurve;
    CGRect _keyboardEndFrame;
    BOOL _isShow;
    
}

@property (nonatomic) UIView *calculateView;
@property (nonatomic) UIView *view1;
@property (nonatomic) CGFloat view1MaxY;
@property (nonatomic) UIScrollView *scrollView;


@end

@implementation BaseKeyBoardViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setHasKeyboardnotificationCenter:(BOOL)hasKeyboardnotificationCenter
{
    
    
    if (hasKeyboardnotificationCenter) {
        BaseKeyBoardViewController __weak*safeSelf = self;
        
        self.getCalculateView = ^(UIScrollView *scrollView, UIView *view,UIView *view1)
        {
            if (safeSelf.scrollView) {
                safeSelf.scrollView = nil;
            }
            if (safeSelf.calculateView) {
                safeSelf.calculateView = nil;
            }
            if (safeSelf.view1) {
                safeSelf.view1 = nil;
            }
            safeSelf.scrollView = scrollView;
            safeSelf.calculateView = view;
            safeSelf.view1 = view1;
            if (!safeSelf.view1MaxY) {
                safeSelf.view1MaxY = CGRectGetMaxY(view1.frame);
            }
        };
        
        [self notificationCenter];
    }
    else
    {
        [[NSNotificationCenter defaultCenter] removeObserver:self];
    }
}

- (void)setHasTransform:(BOOL)hasTransform
{
    _hasTransform = hasTransform;
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
    [self keyboardWasShow];
}

#pragma mark - 键盘消失调用的事件
-(void)keyboardWasHidden:(NSNotification *)notification
{
    [self moveTextViewForKeyboard:notification up:NO];
    [self keyboardWasHidden];
}

- (void) moveTextViewForKeyboard:(NSNotification*)aNotification up: (BOOL) up
{
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
        _scrollView.transform = CGAffineTransformIdentity;
        _view1.transform = CGAffineTransformIdentity;
    }
}

- (void)calculateInsetHeight
{
    if (!_isShow) {
        return;
    }
    CGRect rect = [self.view.window convertRect:_keyboardEndFrame toView:self.view];
    CGFloat maxY = CGRectGetMaxY(_calculateView.frame) - _scrollView.contentOffset.y;
    CGFloat insetHeight = maxY - CGRectGetMinY(rect) + CGRectGetHeight(_view1.frame);
    
    CGFloat view1maxY = _view1MaxY;
    CGFloat view1InsetHeight = view1maxY - CGRectGetMinY(rect);
    
    _view1.transform = CGAffineTransformMakeTranslation(0, -view1InsetHeight);
    if (insetHeight > 0)
    {
        _scrollView.transform=CGAffineTransformMakeTranslation(0, -insetHeight);
    }
}

- (void)keyboardWasShow
{
    
}

- (void)keyboardWasHidden
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
