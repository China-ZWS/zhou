//
//  PositionTableView.h
//  SilkRoadBBS
//
//  Created by Song on 16/6/18.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "BaseTableView.h"

@interface PositionTableView : BaseTableView


- (id) initWithFrame:(CGRect)frame datas:(id)datas selected:(void(^)(id))selected;

@end
