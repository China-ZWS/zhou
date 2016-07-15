
//
//  VIPPayCell.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/5.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "VIPPayCell.h"

@interface VIPPayCell ()
@property (nonatomic) UIButton *checkBtn;
@end

@implementation VIPPayCell

- (UIButton *)checkBtn
{
    return _checkBtn = ({
        UIButton *btn = nil;
        if (_checkBtn) {
            btn = _checkBtn;
        }
        else
        {
            UIImage *lighthighimage = [UIImage imageNamed:@"pay_choose.png"];
            btn = UIButton.new;
            btn.frame = CGRectMake(0, 0, 50, 50);
            btn.size = CGSizeMake(75, 30);
            [btn setImage:lighthighimage forState:UIControlStateSelected];
            btn.titleLabel.font = NFont(14);
            btn.selected = YES;
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
        self.textLabel.numberOfLines = self.detailTextLabel.numberOfLines = 0;
        self.textLabel.textColor = CustomBlack;
        self.detailTextLabel.textColor = CustomlightGray;
        [self setSeparatorInset:UIEdgeInsetsMake(0, -10, 0, 0)];
        self.accessoryView = self.checkBtn;
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size1 = [NSObject getSizeWithText:self.textLabel.text font:self.textLabel.font maxSize:CGSizeMake(self.width - 45 - self.imageView.width - 50, self.textLabel.font.lineHeight * 2)];
    CGSize size2 = [NSObject getSizeWithText:self.detailTextLabel.text font:self.detailTextLabel.font maxSize:CGSizeMake(self.width - 45 - self.imageView.width - 50, self.detailTextLabel.font.lineHeight * 2)];
    
    self.textLabel.frame = CGRectMake(self.imageView.right + 15, (self.height - 5 - size1.height - size2.height) / 2, size1.width, size1.height);
    
    self.detailTextLabel.frame = CGRectMake(self.textLabel.left, self.textLabel.bottom + 5, size2.width, size2.height);

}

- (void)setDatas:(id)datas
{
    self.imageView.image = [UIImage imageNamed:datas[@"image"]];
    self.textLabel.text = NSLocalizedString(datas[@"title"],nil);
    self.detailTextLabel.text = NSLocalizedString(datas[@"detailTitle"],nil);
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
