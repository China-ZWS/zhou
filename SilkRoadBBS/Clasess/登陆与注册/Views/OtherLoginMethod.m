//
//  OtherLoginMethod.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/10.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "OtherLoginMethod.h"
#import "BaseButton.h"
@interface LoginLineView : UILabel

@end

@implementation LoginLineView

- (id)init
{
    if ((self = [super init])) {
        self.text = @"或";
        self.textColor = CustomBlack;
        self.font = NFont(20);
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [self drawRectWithLine:rect start:CGPointMake(30, rect.size.height / 2) end:CGPointMake(rect.size.width / 2 - 30, rect.size.height / 2) lineColor:CustomlightGray lineWidth:1];
    
    [self drawRectWithLine:rect start:CGPointMake(rect.size.width / 2 + 30, rect.size.height / 2) end:CGPointMake(rect.size.width - 30, rect.size.height / 2) lineColor:CustomlightGray lineWidth:1];
    [super drawRect:rect];
}

@end


@interface OtherLoginMethod ()
{
    void(^_selectedBlock)();
}
@property (nonatomic) LoginLineView *line;
@property (nonatomic) BaseButton *wechatBtn;

@end
@implementation OtherLoginMethod

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        [self layoutViews];
    }
    return self;
}

+ (id)frame:(CGRect)frame selected:(void(^)())selected;
{
    OtherLoginMethod *view = [[OtherLoginMethod alloc] initWithFrame:frame];
    view->_selectedBlock = selected;
    return view;
}

#pragma mark 划分其他登陆方式的线条
- (LoginLineView *)line
{
    return _line = ({
        LoginLineView *view = nil;
        if (_line) {
            view = _line;
        }
        else
        {
            view = LoginLineView.new;
            view.frame = CGRectMake(0, 0, self.width, 30);
        }
        view;
    });
}


#pragma mark - 微信登陆
- (BaseButton *)wechatBtn
{
    return _wechatBtn = ({
        BaseButton *btn = nil;;
        if (_wechatBtn) {
            btn =  _wechatBtn;
        }
        else
        {
            btn = [BaseButton buttonWithType:UIButtonTypeCustom];
            btn.frame = CGRectMake((self.width - 80) / 2, _line.bottom + 20, 80, 80);
            btn.titleLabel.font = NFont(14);
            [btn setTitleColor:CustomBlack forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(eventWithWeChatLogin) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[UIImage imageNamed:@"WeChat.png"] forState:UIControlStateNormal];
            [btn setTitle:@"微信登陆" forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.imageRect = CGRectMake((btn.width - btn.currentImage.size.width) / 2, 5, btn.currentImage.size.width, btn.currentImage.size.height);
            btn.labelRect = CGRectMake(0, btn.currentImage.size.height + 10, btn.width, NFont(16).lineHeight);
        }
        btn;
    });
}



- (void)layoutViews
{
    [self addSubview:self.line];
    [self  addSubview:self.wechatBtn];
}


#pragma mark - 点击微信登陆
- (void)eventWithWeChatLogin
{
    _selectedBlock();
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
