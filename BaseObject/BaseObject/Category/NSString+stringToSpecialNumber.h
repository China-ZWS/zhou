//
//  NSString+stringToSpecialNumber.h
//  HCTProject
//
//  Created by 周文松 on 12-4-9.
//  Copyright (c) 2014年 talkweb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (stringToSpecialNumber)
+ (NSString *)stringToNumberWithDot:(CGFloat)number;
+ (NSString *)stringToNumber:(CGFloat)number;
+ (NSMutableAttributedString *)title:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont sign:(NSString *)sign signColor:(UIColor *)signColor signFont:(UIFont *)signFont priceFloat:(CGFloat)priceFloat priceColor:(UIColor *)priceColor priceBigFont:(UIFont *)priceBigFont priceSmallFont:(UIFont *)priceSmallFont;

@end
