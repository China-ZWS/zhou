
//
//  VIPMembersCell.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/4.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "VIPMembersCell.h"


@interface VIPMembersCell ()
@property (nonatomic) BOOL hasShowRequest;
@property (nonatomic) UIButton *payBtn;
@end
@implementation VIPMembersCell

- (UIButton *)payBtn
{
    return _payBtn = ({
        UIButton *btn = nil;
        if (_payBtn) {
            btn = _payBtn;
        }
        else
        {
            btn = UIButton.new;
            btn.size = CGSizeMake(75, 30);
            [btn setTitle:NSLocalizedString(@"VIPMembersList.payBtnTitle",nil) forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = NFont(14);
            btn.backgroundColor = CustomBlue;
            [btn getCornerRadius:5 borderColor:[UIColor clearColor] borderWidth:0 masksToBounds:YES];
        }
        btn;
    });
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.backgroundColor = self.contentView.backgroundColor = [UIColor whiteColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.backgroundColor = self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.font = NFont(16);
        self.detailTextLabel.font = NFont(14);
        self.textLabel.textColor = CustomBlack;
        self.detailTextLabel.textColor = CustomlightGray;
        self.textLabel.numberOfLines = self.detailTextLabel.numberOfLines = 0;
        [self setSeparatorInset:UIEdgeInsetsMake(0, -10, 0, 0)];
        self.accessoryView = self.payBtn;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_hasShowRequest) {
        self.accessoryView.hidden = NO;
        CGSize size1 = [NSObject getSizeWithText:self.textLabel.text font:self.textLabel.font maxSize:CGSizeMake(self.width - 45 - self.imageView.width, self.textLabel.font.lineHeight * 2)];
        CGSize size2 = [NSObject getSizeWithText:self.detailTextLabel.text font:self.detailTextLabel.font maxSize:CGSizeMake(self.width - 45 - self.imageView.width, self.detailTextLabel.font.lineHeight * 2)];
        

        self.imageView.frame = CGRectMake(15, (self.height - 5 - size1.height - size2.height) / 2, self.imageView.image.size.width, self.imageView.size.height);
        self.textLabel.frame = CGRectMake(self.imageView.right + 15, self.imageView.top, size1.width, size1.height);

        self.detailTextLabel.frame = CGRectMake(self.imageView.left, self.textLabel.bottom + 5, size2.width, size2.height);

    }
    else
    {
        self.accessoryView.hidden = YES;

        self.imageView.frame = CGRectMake(15, (self.height - 40) / 2, 40, 40);
        
        CGSize size1 = [NSObject getSizeWithText:self.textLabel.text font:self.textLabel.font maxSize:CGSizeMake(self.width - 45 - self.imageView.width, self.textLabel.font.lineHeight * 2)];
        CGSize size2 = [NSObject getSizeWithText:self.detailTextLabel.text font:self.detailTextLabel.font maxSize:CGSizeMake(self.width - 45 - self.imageView.width, self.detailTextLabel.font.lineHeight * 2)];
        
        self.textLabel.frame = CGRectMake(self.imageView.right + 15, (self.height - 5 - size1.height - size2.height) / 2, size1.width, size1.height);
        
        self.detailTextLabel.frame = CGRectMake(self.textLabel.left, self.textLabel.bottom + 5, size2.width, size2.height);
    }
}

- (void)setDatas:(id)datas
{
    _hasShowRequest = NO;
    self.imageView.image = [UIImage imageNamed:datas[@"image"]];
    self.textLabel.text = NSLocalizedString(datas[@"title"],nil);
    self.detailTextLabel.text = NSLocalizedString(datas[@"detailTitle"],nil);
}

- (void)setRequestWithDatas:(id)requestWithDatas
{
    _hasShowRequest = YES;
    self.imageView.image = [UIImage imageNamed:@"vip1.png"];
    NSString *commodityName = requestWithDatas[@"commodityName"];
    NSString *commodityPrice = [NSString stringWithFormat:@"%f",[requestWithDatas[@"commodityPrice"] floatValue] / 100];
  
    NSMutableAttributedString *text = NSMutableAttributedString.new;
    NSMutableAttributedString *text1 = [NSString title:commodityName titleColor:CustomBlack titleFont:NFont(16) sign:@" " signColor:CustomOrange signFont:NFontBold(14) priceFloat:commodityPrice.floatValue priceColor:CustomOrange priceBigFont:NFontBold(16) priceSmallFont:NFont(14)];
    NSMutableAttributedString *text2 = [[NSMutableAttributedString alloc] initWithString:NSLocalizedString(@"VIPMembersList.requetPriceModel",nil)];
    [text appendAttributedString:text1];
    [text appendAttributedString:text2];
    NSRange modelRange = NSMakeRange(text1.length, text2.length);
    [text addAttribute:NSForegroundColorAttributeName value:CustomOrange range:modelRange];
    [text addAttribute:NSFontAttributeName value:NFontBold(16) range:modelRange];
    self.textLabel.attributedText = text;
    self.detailTextLabel.text = NSLocalizedString(@"VIPMembersList.requetTitle",nil);
}

- (void)eventWithPay
{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
