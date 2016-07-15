
//
//  BaseTextField.m
//  PocketConcubine
//
//  Created by 周文松 on 15-5-8.
//  Copyright (c) 2015年 TalkWeb. All rights reserved.
//

#import "BaseTextField.h"
#import "UIView+CGQuartz.h"
@implementation BaseTextField

- (void)drawRect:(CGRect)rect
{
    switch (_borderType) {
        case kNone:
            break;
        case kLine:
            [self drawRectWithLine:rect start:CGPointMake(0, CGRectGetHeight(rect) - _borderWidth) end:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) - _borderWidth) lineColor:_borderColor lineWidth:_borderWidth];
            break;
        case kFoldLine:
            [self drawRectWithLine:rect start:CGPointMake(0, CGRectGetHeight(rect)) end:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)) lineColor:_borderColor lineWidth:_borderWidth];
            [self drawRectWithLine:rect start:CGPointMake(0, CGRectGetHeight(rect) - 5) end:CGPointMake(0, CGRectGetHeight(rect)) lineColor:_borderColor lineWidth:_borderWidth];
            [self drawRectWithLine:rect start:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect) - 5) end:CGPointMake(CGRectGetWidth(rect), CGRectGetHeight(rect)) lineColor:_borderColor lineWidth:_borderWidth];
            break;
        case kFullLine:
            [self drawWithChamferOfRectangle:rect inset:UIEdgeInsetsMake(1, 1, 1, 1) radius:3 lineWidth:_borderWidth lineColor:_borderColor backgroundColor:[UIColor clearColor]];
        default:
            break;
    }
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _borderColor = [UIColor whiteColor];
        _borderWidth = 1.0f;
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setClearButtonMode:UITextFieldViewModeWhileEditing];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.tintColor = [UIColor whiteColor] ;
    }
    return self;
}



- (void)setBorderType:(BorderType)borderType
{
    _borderType = borderType;
    [self setNeedsDisplay];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    _borderColor = borderColor;
    [self setNeedsDisplay];
}

- (void)setBorderWidth:(CGFloat)borderWidth
{
    _borderWidth = borderWidth;
    [self setNeedsDisplay];
}

/**
 *  @brief  控制placeHolder的位置，左右缩20
 *
 *  @param bounds 范围
 *
 *  @return 返回的范围
 */
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(CGRectGetMaxX(self.leftView.frame) + 7, bounds.origin.y, bounds.size.width - (CGRectGetMaxX(self.leftView.frame) + 10), bounds.size.height);//更好理解些
    return inset;

}
//
/**
 *  @brief  控制显示文本的位置
 *
 *  @param bounds 范围
 *
 *  @return 返回的范围
 */
-(CGRect)textRectForBounds:(CGRect)bounds
{
    CGRect inset = CGRectMake(CGRectGetMaxX(self.leftView.frame) + 7, bounds.origin.y , bounds.size.width - (CGRectGetMaxX(self.leftView.frame) + 10) , bounds.size.height);//更好理解些
        return inset;
}


/**
 *  @brief  控制编辑文本的位置
 *
 *  @param bounds 范围
 *
 *  @return 返回的范围
 */
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    
    CGRect inset = CGRectMake(CGRectGetMaxX(self.leftView.frame) + 7, bounds.origin.y, bounds.size.width - (CGRectGetMaxX(self.leftView.frame) + 10) , bounds.size.height);
    return inset;
}

/**
 *  @brief  控制左视图位置
 *
 *  @param bounds 范围
 *
 *  @return 返回的范围
 */
 - (CGRect)leftViewRectForBounds:(CGRect)bounds
 {
     CGRect inset = CGRectMake(bounds.origin.x + 7, (CGRectGetHeight(bounds) - CGRectGetHeight(self.leftView.frame)) / 2, self.leftView.frame.size.width, self.leftView.frame.size.height);
     return inset;
 }
//



////控制placeHolder的颜色、字体
//- (void)drawPlaceholderInRect:(CGRect)rect
//{
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1].CGColor);
//    [[self placeholder] drawInRect:rect withFont:self.font];
//}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
