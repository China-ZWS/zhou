//
//  NSString+stringToSpecialNumber.m
//  HCTProject
//
//  Created by 周文松 on 12-4-9.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import "NSString+stringToSpecialNumber.h"

@implementation NSString (stringToSpecialNumber)
+ (NSString *)stringToNumberWithDot:(CGFloat)number
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    
    [numberFormatter setPositiveFormat:@"###,##0.00;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return formattedNumberString;
}
+ (NSString *)stringToNumber:(CGFloat)number
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setPositiveFormat:@"###,##0;"];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:number]];
    return formattedNumberString;
}

+ (NSMutableAttributedString *)title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont sign:(NSString *)sign signColor:(UIColor *)signColor signFont:(UIFont *)signFont priceFloat:(CGFloat)priceFloat priceColor:(UIColor *)priceColor priceBigFont:(UIFont *)priceBigFont priceSmallFont:(UIFont *)priceSmallFont 
{
    // 价格
    NSString *priceString = [NSString stringToNumberWithDot:priceFloat];
    NSArray *priceArr = [priceString componentsSeparatedByString:@"."];
    // 小数点前的价格
    NSString *priceString1 = priceArr[0];
    NSString *dot = @".";
    //小数点后的价格
    NSString *priceString2 = priceArr[1];
    
    //所有字符串的拼接
    if (!title) {
        title = @"";
    }
    NSString *allPriceString = [NSString stringWithFormat:@"%@%@%@",title,sign,priceString];
    NSMutableAttributedString *attPrice =  [[NSMutableAttributedString alloc] initWithString:allPriceString];
    
    // 所有字符串的range
    NSRange allRange = NSMakeRange(0,allPriceString.length);
    // title 的range
    NSRange titleRange = NSMakeRange(0,title.length);
    // sign 的range
    NSRange signRange = NSMakeRange(title.length, sign.length);
   
    // 价格的 的range
    NSRange priceRange = NSMakeRange(signRange.location + signRange.length,priceString.length);
    // 价格小数点前 的range
    NSRange priceRange1 = NSMakeRange(signRange.location + signRange.length,priceString1.length);
    // 价格小数点的range
    NSRange dotRange = NSMakeRange(priceRange1.location + priceRange1.length,dot.length);
    // 价格小数点后 的range
    NSRange priceRange2 = NSMakeRange(dotRange.location + dotRange.length,priceString2.length);
    
    // title的颜色
    [attPrice addAttribute:NSForegroundColorAttributeName value:titleColor range:titleRange];
    //sign 的颜色
    [attPrice addAttribute:NSForegroundColorAttributeName value:signColor range:signRange];
    //价格小数点前的颜色
    [attPrice addAttribute:NSForegroundColorAttributeName value:priceColor range:priceRange1];
    [attPrice addAttribute:NSForegroundColorAttributeName value:priceColor range:dotRange];
    //价格小数点后的颜色
    [attPrice addAttribute:NSForegroundColorAttributeName value:priceColor range:priceRange2];

    // title的font
    [attPrice addAttribute:NSFontAttributeName value:titleFont range:titleRange];
    // sign的font
    [attPrice addAttribute:NSFontAttributeName value:signFont range:signRange];
    // priceBig的font
    [attPrice addAttribute:NSFontAttributeName value:priceBigFont range:priceRange1];
    // priceSmall的font
    [attPrice addAttribute:NSFontAttributeName value:priceSmallFont range:priceRange2];
    return attPrice;

}

@end
