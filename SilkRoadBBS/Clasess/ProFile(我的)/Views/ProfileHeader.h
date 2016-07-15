//
//  ProfileHeader.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/19.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileHeader : UIView
- (id)initWithframe:(CGRect)frame header:(void(^)())header left:(void(^)())left right:(void(^)())right;
- (void)refreshData;
@end
