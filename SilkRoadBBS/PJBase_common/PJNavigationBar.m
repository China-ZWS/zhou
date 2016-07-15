//
//  PJNavigationBar.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/8.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PJNavigationBar.h"

@implementation PJNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
    {
        self.barTintColor = CustomDarkBlue;
        self.translucent = NO;
        self.tintColor = [UIColor whiteColor];
        NSDictionary * dict = [NSDictionary dictionaryWithObject:self.tintColor forKey:NSForegroundColorAttributeName];
        self.titleTextAttributes = dict;
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        self.barTintColor = CustomDarkBlue;
        self.translucent = NO;
        self.tintColor = [UIColor whiteColor];
        NSDictionary * dict = [NSDictionary dictionaryWithObject:self.tintColor forKey:NSForegroundColorAttributeName];
        self.titleTextAttributes = dict;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
