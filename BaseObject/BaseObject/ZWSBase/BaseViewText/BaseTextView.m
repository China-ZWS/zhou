//
//  BaseTextView.m
//  GrowingSupermarket
//
//  Created by 周文松 on 15-4-15.
//  Copyright (c) 2015年 com.talkweb.Test. All rights reserved.
//

#import "BaseTextView.h"



@interface BaseTextView ()
{
    NSMutableArray *_insetsHeight;
}
@end

@implementation BaseTextView



- (void)dealloc
{
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
 }



- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}


- (void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
