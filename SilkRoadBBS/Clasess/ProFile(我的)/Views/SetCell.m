//
//  SetCell.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "SetCell.h"

@implementation SetCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.backgroundColor = self.contentView.backgroundColor = [UIColor whiteColor];
        self.textLabel.font = NFont(16);
        self.detailTextLabel.font = NFont(14);
        self.detailTextLabel.textColor = CustomlightGray;
    }
    return self;
}

- (void)setDatas:(id)datas indexPath:(NSIndexPath *)indexPath
{
    self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    self.detailTextLabel.text = @"";
    if (indexPath.row == 2) {
        self.accessoryType  = UITableViewCellAccessoryNone;
        NSString * localVersion=[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
        self.detailTextLabel.text = [NSString stringWithFormat:@"V%@",localVersion];
    }
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
