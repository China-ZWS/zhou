//
//  ProfileCell.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/19.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ProfileCell.h"

@implementation ProfileCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.backgroundColor = self.contentView.backgroundColor = [UIColor whiteColor];
        self.textLabel.font = NFont(16);
        self.textLabel.textColor = CustomBlack;
        self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

- (void)setDatas:(id)datas
{
    self.imageView.image = [UIImage imageNamed:datas[@"image"]];
    self.textLabel.text = NSLocalizedString(datas[@"title"],nil);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
