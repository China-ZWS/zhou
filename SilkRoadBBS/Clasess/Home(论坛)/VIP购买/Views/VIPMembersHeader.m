//
//  VIPMembersHeader.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/4.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "VIPMembersHeader.h"
@interface VIPMembersHeader ()
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *nameLb;
@property (nonatomic) UILabel *positionLb;
@property (nonatomic) UILabel *companyLb;
@end

@implementation VIPMembersHeader


- (void)drawRect:(CGRect)rect
{
    [self drawRectWithLine:rect start:CGPointMake(0, rect.size.height - .3) end:CGPointMake(rect.size.width, rect.size.height - .3) lineColor:CustomlightGray lineWidth:.3];
}

- (id)init
{
    if ((self = [super init])) {
        self.backgroundColor = [UIColor whiteColor];
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
            lb.frame = CGRectMake(_imageView.right + 15, _imageView.centerY + 2.5, self.width - _imageView.right + 30, lb.font.lineHeight);
            lb.textColor = CustomlightGray;
        }
        lb;
    });
}

- (void)layoutViews
{
    [self addSubview:self.imageView];
    [self addSubview:self.nameLb];
    [self addSubview:self.positionLb];
    [self addSubview:self.companyLb];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(15, (self.height - 70) / 2, 70, 70);
    
    CGFloat allContentFloat = _nameLb.font.lineHeight + _positionLb.font.lineHeight + _companyLb.font.lineHeight + 10;
    _nameLb.frame = CGRectMake(_imageView.right + 15, _imageView.top + (_imageView.height - allContentFloat) / 2, self.width - _imageView.right + 30, _nameLb.font.lineHeight);
    _positionLb.frame = CGRectMake(_imageView.right + 15, _nameLb.bottom + 5, self.width - _imageView.right + 30, _positionLb.font.lineHeight);
    _companyLb.frame = CGRectMake(_imageView.right + 15, _positionLb.bottom + 5, self.width - _imageView.right + 30, _companyLb.font.lineHeight);
}

- (void)refreshData;
{
    NSDictionary *userInfo = [keychainItemManager readDatas][@"userInfo"];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:userInfo[@"avatar"] ] placeholderImage:[UIImage imageNamed:@"Profile_account_icon.png"]];
    _nameLb.text = userInfo[@"surName"];
    _positionLb.text = userInfo[@"position"];
    _companyLb.text = userInfo[@"companyName"];
    

}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
