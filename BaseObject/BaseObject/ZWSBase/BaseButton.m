//
//  BaseButton.m
//  BaseObject
//
//  Created by Song on 16/6/10.
//  Copyright © 2016年 TalkWeb. All rights reserved.
//

#import "BaseButton.h"

@implementation BaseButton

#pragma mark 设置Button内部的image的范围
- ( CGRect )imageRectForContentRect:( CGRect )contentRect
{
    return _imageRect;
}

#pragma mark 设置Button内部的title的范围
- ( CGRect )titleRectForContentRect:( CGRect )contentRect
{
    return _labelRect;
}

@end
