//
//  ProfileHeader.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/19.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ProfileHeader.h"

@interface ProfileHeader ()
{
    void(^_headerBlock)();
    void(^_leftBlock)();
    void(^_rightBlock)();
}
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *nameLb;
@property (nonatomic) UILabel *positionLb;
@property (nonatomic) UILabel *companyLb;
@property (nonatomic) UIButton *leftBtn;
@property (nonatomic) UIButton *rightBtn;
@end

@implementation ProfileHeader

- (void)drawRect:(CGRect)rect
{
    CGContextRef  context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    [RGBA(246, 247, 249, 1) setFill];
    CGContextAddRect(context, CGRectMake(0, CGRectGetHeight(rect) - 50, rect.size.width, 50));
    CGContextDrawPath(context,kCGPathFill);
    
    UIImage *imageAccessory = [UIImage imageNamed:@"right.png"];
    [imageAccessory drawInRect:CGRectMake(self.width - imageAccessory.size.width - 10, (rect.size.height - 50 - imageAccessory.size.height) / 2, imageAccessory.size.width, imageAccessory.size.height)];
    
    [self drawRectWithLine:rect start:CGPointMake(0, rect.size.height - 50) end:CGPointMake(rect.size.width, rect.size.height - 50) lineColor:[UIColor blackColor] lineWidth:.1];
    [self drawRectWithLine:rect start:CGPointMake(CGRectGetWidth(rect) / 2, rect.size.height - 50) end:CGPointMake(CGRectGetWidth(rect) / 2 , CGRectGetHeight(rect)) lineColor:[UIColor blackColor] lineWidth:.1];
    [self drawRectWithLine:rect start:CGPointMake(0, rect.size.height - .3) end:CGPointMake(rect.size.width, rect.size.height - .3) lineColor:CustomlightGray lineWidth:.3];
}

- (id)initWithframe:(CGRect)frame header:(void(^)())header left:(void(^)())left right:(void(^)())right;
{
    if ((self = [super initWithFrame:frame])) {
        self.backgroundColor = [UIColor whiteColor];
        _headerBlock = header;
        _leftBlock = left;
        _rightBlock = right;
        
        [self layoutViews];
    }
    return self;
}


- (UIImageView *)imageView
{
    return _imageView = ({
        UIImageView *view = nil;
        if (_imageView) {
            view = _imageView;
        }
        else
        {
            view = UIImageView.new;
            [view getCornerRadius:35 borderColor:[UIColor whiteColor] borderWidth:1 masksToBounds:YES];
            view.backgroundColor = RGBA(246, 247, 249, 1);
        }
        view;
    });
}

- (UILabel *)nameLb
{
    return _nameLb = ({
        UILabel *lb = nil;
        if (_nameLb) {
            lb = _nameLb;
        }
        else
        {
            lb = UILabel.new;
            lb.font = NFontBold(17);
            lb.textColor = CustomBlack;
        }
        lb;
    });
}

- (UILabel *)positionLb
{
    return _positionLb = ({
        UILabel *lb = nil;
        if (_positionLb) {
            lb = _positionLb;
        }
        else
        {
            lb = UILabel.new;
            lb.font = NFont(16);
            lb.textColor = CustomlightGray;
        }
        
        lb;
    });
}


- (UILabel *)companyLb
{
    return _companyLb = ({
        UILabel *lb = nil;
        if (_companyLb) {
            lb = _companyLb;
        }
        else
        {
            lb = UILabel.new;
            lb.font = NFont(16);
            lb.frame = CGRectMake(_imageView.right + 15, _imageView.centerY + 2.3, self.width - _imageView.right + 30, lb.font.lineHeight);
            lb.textColor = CustomlightGray;
        }
        
        lb;
    });
}

- (UIButton *)leftBtn
{
    return _leftBtn = ({
        UIButton *btn = nil;
        if (_leftBtn) {
            btn = _leftBtn;
        }
        else
        {
            UIImage *leftImg = [UIImage imageNamed:@"Profile_balance_icon.png"];
            btn = UIButton.new;
            [btn setImage:leftImg forState:UIControlStateNormal];
            [btn setAttributedTitle: [NSString title:@"余额" titleColor:CustomGray titleFont:NFont(16) sign:@"  ¥" signColor:CustomOrange signFont:NFontBold(14) priceFloat:0 priceColor:CustomOrange priceBigFont:NFontBold(18) priceSmallFont:NFont(14)] forState:UIControlStateNormal];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
            btn.userInteractionEnabled = NO;
        }
        btn;
    });
}

- (UIButton *)rightBtn
{
    return _rightBtn = ({
        UIButton *btn = nil;
        if (_rightBtn) {
            btn = _rightBtn;
        }
        else
        {
            UIImage *rightImg = [UIImage imageNamed:@"Profile_coin_icon.png"];
            btn = UIButton.new;
            [btn setImage:rightImg forState:UIControlStateNormal];
            [btn setAttributedTitle: [NSString title:@"善币" titleColor:CustomGray titleFont:NFont(16) sign:@"  " signColor:CustomBlue signFont:NFontBold(14) priceFloat:0 priceColor:CustomBlue priceBigFont:NFontBold(18) priceSmallFont:NFont(14)] forState:UIControlStateNormal];
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
            btn.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
            btn.userInteractionEnabled = NO;
        }
        btn;
    });
}


- (void)layoutViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.nameLb];
    [self addSubview:self.positionLb];
    [self addSubview:self.companyLb];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(15, 15, 70, 70);
    
    CGFloat allContentFloat = _nameLb.font.lineHeight + _positionLb.font.lineHeight + _companyLb.font.lineHeight + 10;
    _nameLb.frame = CGRectMake(_imageView.right + 15, _imageView.top + (_imageView.height - allContentFloat) / 2, self.width - _imageView.right + 30, _nameLb.font.lineHeight);
    _positionLb.frame = CGRectMake(_imageView.right + 15, _nameLb.bottom + 5, self.width - _imageView.right + 30, _positionLb.font.lineHeight);
    _companyLb.frame = CGRectMake(_imageView.right + 15, _positionLb.bottom + 5, self.width - _imageView.right + 30, _companyLb.font.lineHeight);
    _leftBtn.frame = CGRectMake(0, self.height - 50, self.width / 2, 50);
    _rightBtn.frame = CGRectMake(self.width / 2, self.height - 50, self.width / 2, 50);
}


- (void)refreshData;
{
    
    NSDictionary *userInfo = [keychainItemManager readDatas][@"userInfo"];
  
    [_imageView sd_setImageWithURL:[NSURL URLWithString:userInfo[@"avatar"] ] placeholderImage:[UIImage imageNamed:@"Profile_account_icon.png"]];
    _nameLb.text = userInfo[@"surName"];
    _positionLb.text = userInfo[@"position"];
    _companyLb.text = userInfo[@"companyName"];
    
    CGFloat price1 = 0;
    CGFloat price2 = 0;
    if ([userInfo[@"accountList"] count]) {
        price1 = [userInfo[@"accountList"][0][@"accountBalance"] floatValue];
    }
    if ([userInfo[@"accountList"] count]) {
        price2 = [userInfo[@"accountList"][1][@"accountBalance"] floatValue];
    }
    [_leftBtn setAttributedTitle: [NSString title:NSLocalizedString(@"ProfileViewController.headerLeftTitle",nil) titleColor:CustomGray titleFont:NFont(16) sign:@"  ¥" signColor:CustomOrange signFont:NFontBold(14) priceFloat:price1 priceColor:CustomOrange priceBigFont:NFontBold(18) priceSmallFont:NFont(14)] forState:UIControlStateNormal];

    [_rightBtn setAttributedTitle: [NSString title:NSLocalizedString(@"ProfileViewController.headerRightTitle",nil) titleColor:CustomGray titleFont:NFont(16) sign:@"  " signColor:CustomBlue signFont:NFontBold(14) priceFloat:price2 priceColor:CustomBlue priceBigFont:NFontBold(18) priceSmallFont:NFont(14)] forState:UIControlStateNormal];

}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:self];
    CGRect headerRect = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame) - 50);
    CGRect leftRect = CGRectMake(0, CGRectGetHeight(self.frame) - 50, CGRectGetWidth(self.frame) / 2, 50);
    CGRect rightRect = CGRectMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) - 50, CGRectGetWidth(self.frame), 50);

    BOOL headerContains = CGRectContainsPoint(headerRect, touchPoint);
    BOOL leftContains = CGRectContainsPoint(leftRect, touchPoint);
    BOOL rightContains = CGRectContainsPoint(rightRect, touchPoint);
    
    if (headerContains) {
        _headerBlock();
    }
    else if (leftContains) {
        _leftBlock();
    }
    else if (rightContains)
    {
        _rightBlock();
    }
}




/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
