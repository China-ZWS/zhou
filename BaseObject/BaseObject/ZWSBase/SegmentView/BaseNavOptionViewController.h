//
//  BaseNavOptionViewController.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "BaseViewController.h"
#import "SideSegmentControllerDelegate.h"
#import "SideSegmentControllerDataSource.h"

@interface BaseNavOptionViewController : BaseViewController

@property (nonatomic, assign) id <SideSegmentControllerDelegate> delegate;
@property (nonatomic, assign) id <SideSegmentControllerDataSource> dataSource;

- (id)initWithViewControllers:(NSArray *)viewControllers;
@property (nonatomic) UIColor *backgroudColor;
@property (nonatomic) UIColor *lineColor;
@property (nonatomic) CGRect segmentBarFrame;
@property (nonatomic) UIColor *titleColor;
@property (nonatomic) UIColor *selectedTitleColor;

@end
