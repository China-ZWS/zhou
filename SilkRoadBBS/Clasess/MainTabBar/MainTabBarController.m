//
//  MainTabBarController.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/8.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainTabBar.h"
#import "PostViewController.h"
#import "TopicDetailViewController.h"

@interface MainTabBarController ()
<MainTabBarDelegate, UITabBarControllerDelegate>
{
    NSArray *_tabConfigList;
    BaseViewController *_currentController;
}

@end

@implementation MainTabBarController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _tabConfigList = [DataConfigManager getMainTab];
        self.delegate = self;
    }
    return self;
}

#pragma mark - 初始化item
- (NSArray *)createTabItem
{
    NSMutableArray *item = [NSMutableArray array];
    for (int i = 0; i < _tabConfigList.count; i ++)
    {
        NSDictionary *dic = _tabConfigList[i];
        Class class = NSClassFromString(dic[@"viewController"]);
        UIViewController *controller = [class new];
        UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[PJNavigationBar class] toolbarClass:nil];
        nav.viewControllers = @[controller];
        [item addObject:nav];
        if (!i) {
            _currentController = (BaseViewController *)controller;
        }
    }
    return item;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    MainTabBar *tabbar = [[MainTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];

    self.viewControllers = [self createTabItem];     /*设置Bar的items*/
    [self createTabItemContent];
    // Do any additional setup after loading the view.
}

- (void)createTabItemContent;
{
    
    for (int i = 0; i < _tabConfigList.count; i ++)
    {
        NSDictionary *dic = _tabConfigList[i];
        NSString *title = NSLocalizedString(dic[@"title"],nil);
        UIImage *hightlightImg = [[UIImage imageNamed:dic[@"highlightedImage"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] ;
        UIImage *img = [[UIImage imageNamed:dic[@"image"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        [self.tabBar.items objectAtIndex:i].selectedImage = hightlightImg;
        [self.tabBar.items objectAtIndex:i].image = img;
        self.tabBar.items[i].title = title;
        
        [self.tabBar.items[i] setTitleTextAttributes:@{NSForegroundColorAttributeName:CustomGray,NSFontAttributeName:NFontBold(10)} forState:UIControlStateNormal];
        
        [self.tabBar.items[i] setTitleTextAttributes:@{NSForegroundColorAttributeName:CustomBlue,NSFontAttributeName:NFontBold(10)} forState:UIControlStateSelected];
       
        
        [self.tabBar.items[i] setImageInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
        [self.tabBar.items[i] setTitlePositionAdjustment:UIOffsetMake(0, -1)];
    }
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController;
{
    UINavigationController *nav = (UINavigationController *)viewController;
    _currentController = (BaseViewController *)nav.viewControllers[0];
}
/*
- (void)hideRealTabBar
{
    for(UIView *view in self.view.subviews)
    {
        if([view isKindOfClass:[UITabBar class]])
        {
            view.hidden = YES;
            break;
        }
    }
}
*/

#pragma mark - ------------------------------------------------------------------
#pragma mark - TabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(MainTabBar *)tabBar
{
    UINavigationController *nav =[[UINavigationController alloc] initWithNavigationBarClass:[PJNavigationBar class] toolbarClass:nil];
    PostViewController *ctr = [[PostViewController alloc] initWithSubmitSuccess:^(id datas)
    {
        TopicDetailViewController *ctr = [[TopicDetailViewController alloc] initWithParameters:datas];
        ctr.hidesBottomBarWhenPushed = YES;
        [_currentController pushViewController:ctr];
    }];
    nav.viewControllers = @[ctr];
    [self presentViewController:nav animated:YES completion:nil];
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
