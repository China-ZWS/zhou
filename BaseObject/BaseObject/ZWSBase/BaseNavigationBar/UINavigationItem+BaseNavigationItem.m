//
//  UINavigationItem+BaseNavigationItem.m
//  MoodMovie
//
//  Created by 周文松 on 14-8-28.
//  Copyright (c) 2014年 com.talkweb.MoodMovie. All rights reserved.
//

#import "UINavigationItem+BaseNavigationItem.h"
#import "BaseNavBarButtonItem.h"
#import "Header.h"
#import "Category.h"
#import "Device.h"

@implementation UINavigationItem (BaseNavigationItem)


- (void)setNewTitle:(NSString *)title
{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 22, 22);
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:19];
    label.textColor =  [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = title;
    self.titleView = label;
}

- (UIButton *)setRightItemWithTarget:(id)target title:(NSString *)title action:(SEL)action image:(NSString *)image;
{
    BaseNavBarButtonItem *buttonItem = [BaseNavBarButtonItem itemWithTarget:target title:title action:action image:image];
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem.button];
    return buttonItem.button;
}

- (void)setBackItemWithTarget:(id)target title:(NSString *)title  action:(SEL)action image:(NSString *)image;
{
    BaseNavBarButtonItem *buttonItem = [BaseNavBarButtonItem itemWithTarget:target title:title action:action image:image];
    self.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:buttonItem.button];
}


- (void)setRightItemView:(UIView *)view
{
    self.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}






@end
