//
//  PostItem.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PostItem.h"

@interface PostItem ()
@property (nonatomic) UIButton *deleteBtn;
@end

@implementation PostItem

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
            view.contentMode = UIViewContentModeScaleAspectFill;
            view.clipsToBounds  = YES;

        }
        view;
    });
}

- (UIButton *)deleteBtn
{
    return _deleteBtn = ({
        UIButton *btn = nil;
        if (_deleteBtn) {
            btn = _deleteBtn;
        }
        else
        {
            btn = UIButton.new;
            [btn setImage:[UIImage imageNamed:@"delete_picture_pre.png"] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(eventWithDelete:) forControlEvents:UIControlEventTouchUpInside];
        }
        btn;
    });
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.deleteBtn];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _imageView.frame = CGRectMake(0, 0, self.width, self.height);
    _deleteBtn.frame = CGRectMake(self.width - _deleteBtn.currentImage.size.width - 5, 5, _deleteBtn.currentImage.size.width, _deleteBtn.currentImage.size.height);
}

- (void)setDatas:(id)datas indexPath:(NSIndexPath *)indexPath;
{
    if ([datas count] == indexPath.row) {
        _deleteBtn.hidden = YES;
        _deleteBtn.enabled = NO;
        _imageView.image = [UIImage imageNamed:@"add_picture_pre.png"];
        _imageView.backgroundColor = [UIColor clearColor];
    }
    else
    {
        _imageView.backgroundColor = RGBA(238, 238, 238, 1);
        _deleteBtn.hidden = NO;
        _deleteBtn.enabled = YES;
        _imageView.image = nil;
        _imageView.image = datas[indexPath.row];
        _imageView.backgroundColor = RGBA(238, 238, 238, 1);
    }
}

- (void)eventWithDelete:(UIButton *)btn
{
    if ([_delegate respondsToSelector:@selector(eventWithDelete:)] && [_delegate conformsToProtocol:@protocol(PostItemDelegate)])
    {
        [_delegate eventWithDelete:btn];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
