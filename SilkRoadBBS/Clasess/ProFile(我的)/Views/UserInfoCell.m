//
//  UserInfoCell.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "UserInfoCell.h"

@implementation UserInfoCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) {
        self.backgroundColor = self.contentView.backgroundColor = [UIColor whiteColor];
        self.textLabel.font = NFont(16);
        self.textLabel.textColor = CustomBlack;
        self.detailTextLabel.font = NFont(14);
        self.detailTextLabel.textColor = CustomlightGray;
        [self setSeparatorInset:UIEdgeInsetsMake(0, 10, 0, 0)];
        self.textLabel.backgroundColor = self.detailTextLabel.backgroundColor = [UIColor clearColor];
        [self.imageView getCornerRadius:30 borderColor:[UIColor whiteColor] borderWidth:1 masksToBounds:YES];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize textSize = [NSObject getSizeWithText:self.textLabel.text font:self.textLabel.font maxSize:CGSizeMake(self.width / 2, self.height)];
    CGSize detailTextSize = [NSObject getSizeWithText:self.detailTextLabel.text font:self.detailTextLabel.font maxSize:CGSizeMake(self.width / 2, self.height)];

    self.imageView.frame = CGRectMake(self.width - 100, (self.height - 60) / 2, 60, 60);
    self.textLabel.frame = CGRectMake(15, 0, self.width - textSize.width, self.height);
    self.detailTextLabel.frame = CGRectMake(self.width - 40 - detailTextSize.width, 0, detailTextSize.width, self.height);
}

- (void)setDatas:(id)datas indexPath:(NSIndexPath *)indexPath;
{
    self.accessoryType  = UITableViewCellAccessoryNone;

    self.imageView.image = nil;
    
    NSDictionary *userInfo = [keychainItemManager readDatas][@"userInfo"];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                [self.imageView sd_setImageWithURL:[NSURL URLWithString:userInfo[@"avatar"] ] placeholderImage:[UIImage imageNamed:@"Profile_account_icon.png"]];
                self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 1:
            {
                self.detailTextLabel.text = userInfo[@"surName"];
            }
                break;
            case 2:
            {
                self.detailTextLabel.text = userInfo[@"telephone"];
                self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
            }
                break;
            case 3:
            {
                self.detailTextLabel.text = userInfo[@"companyName"];
            }
                break;
   
            default:
                break;
        }
        
    }
    else if (indexPath.section == 1)
    {
        self.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
        switch (indexPath.row) {
            case 0:
            {
                self.detailTextLabel.text = userInfo[@"position"];
            }
                break;
            case 1:
            {
                self.detailTextLabel.text = userInfo[@"email"];
            }
                break;
  
            default:
                break;
        }
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
