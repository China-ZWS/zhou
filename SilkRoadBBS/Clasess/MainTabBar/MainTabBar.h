//
//  MainTabBar.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MainTabBar;

@protocol MainTabBarDelegate <NSObject>
@optional
- (void)tabBarPlusBtnClick:(MainTabBar *)tabBar;
@end

@interface MainTabBar : UITabBar
@property (nonatomic, weak) id<MainTabBarDelegate> myDelegate ;

@end
