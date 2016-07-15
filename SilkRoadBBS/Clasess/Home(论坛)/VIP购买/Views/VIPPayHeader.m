
//
//  VIPPayHeader.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/5.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "VIPPayHeader.h"

@interface VIPPayHeader ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *name;
@property (nonatomic) UILabel *vipPrice;
@end

@implementation VIPPayHeader

- (void)drawRect:(CGRect)rect
{
    UIImage *image = [UIImage imageNamed:@"pay_top_bg.png"];
    CGFloat top = 5; // 顶端盖高度
    CGFloat bottom = 20 ; // 底端盖高度
    CGFloat left = 5; // 左端盖宽度
    CGFloat right = 5; // 右端盖宽度
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    image = [image resizableImageWithCapInsets:insets ];
    [image drawInRect:rect];
}

- (id)init
{
    if ((self = [super init])) {
        self.backgroundColor = [UIColor clearColor];
        [self layoutViews];
    }
    return self;
}

- (UIImageView *)imageView
{
    return _imageView = ({
        UIImageView *v = nil;
        if (_imageView) {
            v = _imageView;
        }
        else
        {
            v = UIImageView.new;
            v.image = [UIImage imageNamed:@"pay_icon.png"];
        }
        v;
    });
}

- (UILabel *)name
{
    return _name = ({
        UILabel *lb = nil;
        if (_name) {
            lb = _name;
        }
        else
        {
            lb = UILabel.new;
            lb.numberOfLines = 0;
            lb.backgroundColor = [UIColor clearColor];
            lb.textColor = CustomlightGray;
            lb.font = NFont(16);
        }
        lb;
    });
}

- (UILabel *)vipPrice
{
    return _vipPrice = ({
        UILabel *lb = nil;
        if (_vipPrice) {
            lb = _vipPrice;
        }
        else
        {
            lb = UILabel.new;
            lb.numberOfLines = 0;
            lb.backgroundColor = [UIColor clearColor];
            lb.font = NFont(16);
            lb.textColor = CustomOrange;
        }
        lb;
    });
}

- (void)layoutViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.name];
    [self addSubview:self.vipPrice];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(15, (self.height - self.imageView.image.size.height) / 2, _imageView.image.size.width, _imageView.image.size.height);
    _name.frame = CGRectMake(_imageView.right + 15, _imageView.centerY - _name.font.lineHeight - 2.5, self.width - 45 - _imageView.size.width, _name.font.lineHeight);
    _vipPrice.frame = CGRectMake(_name.left, _imageView.centerY + 2.5, _name.width, _vipPrice.font.lineHeight);
}

- (void)setDatas:(id)datas
{
    _name.text = [NSString stringWithFormat:@"%@ %@",datas[@"commodityName"],NSLocalizedString(@"VIPPayViewController.VIPTime",nil)];
   
    
    NSString *commodityPrice = [NSString stringWithFormat:@"%f",[datas[@"commodityPrice"] floatValue] / 100];
    
    NSMutableAttributedString *text = NSMutableAttributedString.new;
    NSMutableAttributedString *text1 = [NSString title:nil titleColor:nil titleFont:nil sign:@" " signColor:CustomOrange signFont:NFontBold(14) priceFloat:commodityPrice.floatValue priceColor:CustomOrange priceBigFont:NFontBold(16) priceSmallFont:NFont(14)];
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"VIPMembersList.requetPriceModel",nil)];
    [text appendAttributedString:text1];
    [text appendAttributedString:text2];
    NSRange modelRange = NSMakeRange(text1.length, text2.length);
    [text addAttribute:NSForegroundColorAttributeName value:CustomOrange range:modelRange];
    [text addAttribute:NSFontAttributeName value:NFontBold(16) range:modelRange];
    _vipPrice.attributedText = text;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
