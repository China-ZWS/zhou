//
//  RepliesViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "RepliesViewController.h"
#import "RepliesView.h"

@interface RepliesViewController ()
{
    NSTimeInterval _animationDuration;
    UIViewAnimationCurve _animationCurve;
    CGRect _keyboardEndFrame;
    void(^_successBlock)();
}
@property (nonatomic) RepliesView *replies;
@end

@implementation RepliesViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithDatas:(id)datas success:(void(^)())success;
{
    if ((self = [super init])) {
        _parameters = datas;
        self.title = NSLocalizedString(@"RepliesViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
        [self.navigationItem setRightItemWithTarget:self title:NSLocalizedString(@"NavSubmit",nil) action:@selector(eventWithRight) image:nil];
        _successBlock = success;
    }
    return self;
}

- (void)back
{
    [self.view endEditing:YES];
    [self popViewController];
}

- (void)eventWithRight
{
    NSString *postTitle = [_replies getPostTitle];
    NSString *postContent = [_replies getpostContent];

    if (!(NSUInteger)postTitle.length || !(NSUInteger)postContent.length) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.unInfo",nil)];
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"topicId"] = _parameters[@"topicId"];
    params[@"typeId"] = @"1";
    params[@"postTitle"] = postTitle;
    params[@"postContent"] = postContent;
    params[@"postId"] = _parameters[@"postId"];

    [RequestViewModels requestWithSubmitReply:self params:params success:^(id datas)
     {
         [SVProgressHUD dismiss];
         _successBlock();
         [self back];

     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
     }];

}

- (RepliesView *)replies
{
    return _replies = ({
        RepliesView *view = nil;
        if (_replies) {
            view = _replies;
        }
        else
        {
            view = RepliesView.new;
            view.frame = self.view.bounds;
        }
        view;
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self notificationCenter];
}

#pragma mark - 初始化通知
-(void)notificationCenter
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
}

#pragma mark - 键盘调用的事件
- (void)keyboardWasShow:(NSNotification *)notification
{
    NSDictionary* userInfo = [notification userInfo];
    // Get animation info from userInfo
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&_animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&_animationDuration];
    [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&_keyboardEndFrame];
    _replies.height = self.view.height - CGRectGetHeight(_keyboardEndFrame);
}

- (void)layoutViews
{
    [self.view addSubview:self.replies];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self layoutViews];
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
