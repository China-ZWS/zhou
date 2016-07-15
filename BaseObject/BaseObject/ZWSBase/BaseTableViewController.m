//
//  BaseTableViewController.m
//  BabyStory
//
//  Created by 周文松 on 14-11-6.
//  Copyright (c) 2014年 com.talkweb.BabyStory. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Device.h"
#import "BaseTableViewController.h"
@interface BaseTableViewController ()
{
    NSTimeInterval _animationDuration;
    UIViewAnimationCurve _animationCurve;
    CGRect _keyboardEndFrame;
    BOOL _isShow;

}
@property (nonatomic) UIView *calculateView;
@property (nonatomic) UIView *view1;
@property (nonatomic) CGFloat view1MaxY;

@end

@implementation BaseTableViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithTableViewStyle:(UITableViewStyle)style parameters:(id)parameters;
{
    if ((self = [super init])) {
        _style = style;
        _parameters = parameters;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    self.table = [[BaseTableView alloc] initWithFrame:self.view.frame style:_style];
    [self.view addSubview:_table];
    _table.touchDelegate = self;
    _table.delegate = self;
    _table.dataSource  = self;
//    _table.tableFooterView = [UIView new];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}




- (void)setTableWithFrame:(CGRect)rect
{
    self.table.frame = rect;
}

- (void)reloadTabData
{
   
    [self.table reloadData];
}

- (void)setHasKeyboardnotificationCenter:(BOOL)hasKeyboardnotificationCenter
{
    
    
    if (hasKeyboardnotificationCenter) {
        BaseTableViewController __weak*safeSelf = self;
        
        self.getCalculateView = ^(UIView *view,UIView *view1)
        {
            if (safeSelf.calculateView) {
                safeSelf.calculateView = nil;
            }
            if (safeSelf.view1) {
                safeSelf.view1 = nil;
            }
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
    if (!self.view.window) {
        return;
    }
    [self moveTextViewForKeyboard:notification up:YES];
    [self keyboardWasShow];
}

#pragma mark - 键盘消失调用的事件
-(void)keyboardWasHidden:(NSNotification *)notification
{
    if (!self.view.window) {
        return;
    }
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
        _table.transform = CGAffineTransformIdentity;
        _view1.transform = CGAffineTransformIdentity;
    }
}

- (void)calculateInsetHeight
{
    if (!_isShow) {
        return;
    }
    CGRect rect = [self.view.window convertRect:_keyboardEndFrame toView:self.view];
    CGFloat maxY = CGRectGetMaxY(_calculateView.frame) - _table.contentOffset.y;
    CGFloat insetHeight = maxY - CGRectGetMinY(rect) + CGRectGetHeight(_view1.frame);
   
    CGFloat view1maxY = _view1MaxY;
    CGFloat view1InsetHeight = view1maxY - CGRectGetMinY(rect);

    _view1.transform = CGAffineTransformMakeTranslation(0, -view1InsetHeight);
   if (insetHeight > 0)
    {
        _table.transform=CGAffineTransformMakeTranslation(0, -insetHeight);
    }
}

- (void)keyboardWasShow
{

}

- (void)keyboardWasHidden
{

}

#pragma mark -
#pragma mark  touchDelegate 
#pragma mark -

//- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
//{
//    [self setEditing:NO];
//}
//
//- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
//{
//
//}
//
//- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
//{
//
//}
//
//- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
//{
//    [self setEditing:NO];
//}


#pragma mark -
#pragma mark  delegate
#pragma mark -

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 0;
}

#pragma mark -
#pragma mark dataSource
#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 0;
}

// Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
// Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

{
   static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}


- (void)didReceiveMemoryWarning
{
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
