//
//  PJTableViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/11.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJTableViewController.h"

@interface PJTableViewController ()

@end

@implementation PJTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = RGBA(238, 238, 238, 1);
}

- (void)addNavigationWithPresentViewController:(UIViewController *)controller;
{
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[PJNavigationBar class] toolbarClass:nil];
    nav.viewControllers = @[controller];
    [self presentViewController:nav];
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
