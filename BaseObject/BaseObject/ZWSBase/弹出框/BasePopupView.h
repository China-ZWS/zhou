//
//  BasePopupView.h
//  BaseObject
//
//  Created by Song on 16/5/31.
//  Copyright © 2016年 TalkWeb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BasePopupView : UIView
+ (id)showInView:(void(^)(id))showInView;
+ (BOOL)hideForView;
- (BasePopupView *(^)(UIView *contentView))addContentView;

@end
