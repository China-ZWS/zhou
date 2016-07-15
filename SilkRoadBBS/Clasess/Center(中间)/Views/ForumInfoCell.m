//
//  ForumInfoCell.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/8.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ForumInfoCell.h"

@implementation ForumInfoCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.contentView.backgroundColor = self.backgroundColor = [UIColor whiteColor];
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.textLabel.font = NFont(16);
        self.textLabel.textColor = CustomBlack;
        [self setSeparatorInset:UIEdgeInsetsMake(0, -10, 0, 0)];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(15, (self.height - 40) / 2, 40, 40);
    self.textLabel.frame = CGRectMake(self.imageView.right + 15, 0, self.width - self.imageView.right - 30, self.height);
}

- (void)setDatas:(id)datas
{
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:datas[@"forumImg"] ] placeholderImage:[UIImage imageNamed:@"btn_get_code_grey.png"]];
    self.textLabel.text = datas[@"forumName"];

}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
