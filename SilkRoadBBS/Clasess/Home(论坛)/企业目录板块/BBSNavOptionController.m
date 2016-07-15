//
//  BBSNavOptionController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "BBSNavOptionController.h"
#import "PostViewController.h"
#import "TopicDetailViewController.h"

@interface BBSNavOptionController ()

@end

@implementation BBSNavOptionController

- (id)initWithViewControllers:(NSArray *)viewControllers
{
    if ((self = [super initWithViewControllers:viewControllers])) {
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
        [self.navigationItem setRightItemWithTarget:self title:nil  action:@selector(eventWithRight) image:@"nav_write.png"];
    }
    return self;
}

- (void)back
{
    [self popViewController];
}

- (void)eventWithRight
{
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[PJNavigationBar class] toolbarClass:nil];
    PostViewController *ctr = [[PostViewController alloc] initWithSubmitSuccess:^(id datas){

        [self pushViewController:[[TopicDetailViewController alloc] initWithParameters:datas]];
        NSNotificationPost(datas[@"forumId"], nil, nil);
        
    }];
    nav.viewControllers = @[ctr];
    [self presentViewController:nav];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBA(238, 238, 238, 1);
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
