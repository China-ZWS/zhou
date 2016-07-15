//
//  ReSignUpCell.m
//  SilkRoadBBS
//
//  Created by Song on 16/6/12.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "ReSignUpCell.h"
@interface ReSignUpCell ()
<UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic) NSIndexPath *indexPath;

@end

@implementation ReSignUpCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
    {
        self.backgroundColor = self.contentView.backgroundColor = [UIColor whiteColor];
        _field = BaseTextField.new;
        _field.font = NFont(16);
        _field.textColor = CustomBlack;
        _field.tintColor = CustomlightGray;
        _field.delegate = self;
        [self.contentView addSubview:_field];
        [_field addTarget:self action:@selector(eventWithFieldBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [_field addTarget:self action:@selector(eventWithFieldChanged:) forControlEvents:UIControlEventEditingChanged];

        
        
        _tView = PJTextView.new;
        _tView.font = NFont(16);
        _tView.textColor = CustomBlack;
        _tView.tintColor = CustomlightGray;
        _tView.delegate = self;
        [self.contentView addSubview:_tView];
        
        self.textLabel.font = NFont(16);
        self.textLabel.textColor = CustomBlack;
        self.textLabel.backgroundColor = [UIColor clearColor];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    CGSize size = [NSObject getSizeWithText:self.textLabel.text font:self.textLabel.font maxSize:CGSizeMake(self.width,self.textLabel.font.lineHeight)];
    self.textLabel.width = size.width;
    self.textLabel.height = 45;
    _field.frame = CGRectMake(self.textLabel.right + 10, 0, self.width - self.textLabel.right - 40, self.height);
    _tView.frame = CGRectMake(self.textLabel.right + 10, self.textLabel.top + 5, self.width - self.textLabel.right - 40, self.height - self.textLabel.top * 2 - 8);
}


- (void)setDatas:(id)datas indexPath:(NSIndexPath *)indexPath;
{
    _indexPath = indexPath;
    
    _field.hasEvent = NO;
    _field.inputView = nil;
    if (indexPath.section == 0)
    {
        _tView.hidden = YES;
        _field.hidden = NO;
        _field.tag = indexPath.row + 1;
        switch (indexPath.row) {
            case 0:
            {
                
                NSString *title = [@"*" stringByAppendingString:NSLocalizedString(datas[@"title"],nil)];
                NSMutableAttributedString *attString =  [[NSMutableAttributedString alloc] initWithString:title];
                
                NSRange range = NSMakeRange(0,1);
                [attString addAttribute:NSForegroundColorAttributeName value:CustomRed range:range];
                self.textLabel.attributedText = attString;
                _field.placeholder = NSLocalizedString(datas[@"placeholder"],nil);
            }
                break;
            case 1:
            {
                NSString *title = [@"*" stringByAppendingString:NSLocalizedString(datas[@"title"],nil)];
                NSMutableAttributedString *attString =  [[NSMutableAttributedString alloc] initWithString:title];
                
                NSRange range = NSMakeRange(0,1);
                [attString addAttribute:NSForegroundColorAttributeName value:CustomRed range:range];
                self.textLabel.attributedText = attString;
                _field.placeholder = NSLocalizedString(datas[@"placeholder"],nil);
                
            }
                break;
            case 2:
            {
                self.textLabel.text = NSLocalizedString(datas[@"title"],nil);
                _field.placeholder = NSLocalizedString(datas[@"placeholder"],nil);
                
            }
                break;
            case 3:
            {
                self.textLabel.text = NSLocalizedString(datas[@"title"],nil);
                _field.placeholder = NSLocalizedString(datas[@"placeholder"],nil);
                _field.hasEvent = YES;
                _field.inputView = UIView.new;
            }
                break;
                
            default:
                break;
        }
        
    }
    else
    {
        _tView.tag = indexPath.row + 1;
        NSString *title = [@"*" stringByAppendingString:NSLocalizedString(datas[@"title"],nil)];
        NSMutableAttributedString *attString =  [[NSMutableAttributedString alloc] initWithString:title];
        
        NSRange range = NSMakeRange(0,1);
        [attString addAttribute:NSForegroundColorAttributeName value:CustomRed range:range];
        self.textLabel.attributedText = attString;
        _field.hidden = YES;
        _tView.hidden = NO;
    }
}

- (void)eventWithFieldBegin:(BaseTextField *)field
{
    
    if ([_delegate respondsToSelector:@selector(tableViewCellForBeginEditField:)] && [_delegate conformsToProtocol:@protocol(ReSignUpCellDelegate)])
    {
        [_delegate tableViewCellForBeginEditField:self];
    }
}

- (void)eventWithFieldChanged:(BaseTextField *)field
{
    
    if ([_delegate respondsToSelector:@selector(tableViewCellForChangeField:)] && [_delegate conformsToProtocol:@protocol(ReSignUpCellDelegate)])
    {
        [_delegate tableViewCellForChangeField:self];
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
    if ([_delegate respondsToSelector:@selector(tableViewCellForBeginEditTView:)] && [_delegate conformsToProtocol:@protocol(ReSignUpCellDelegate)])
    {
        [_delegate tableViewCellForBeginEditTView:self];
    }
    return YES;
}


- (void)textViewDidChange:(PJTextView *)textView;
{
    if ([_delegate respondsToSelector:@selector(tableViewCellForChangeTView:)] && [_delegate conformsToProtocol:@protocol(ReSignUpCellDelegate)])
    {
        [_delegate tableViewCellForChangeTView:self];
    }
    
    if(![textView.text isEqualToString:@""])
    {
        [textView.placeHolder setHidden:YES];
    }
    else
    {
        [textView.placeHolder setHidden:NO];
    }
    

}


- (BOOL)textFieldShouldBeginEditing:(BaseTextField *)textField
{
    if (textField.hasEvent) {
        if ([_delegate respondsToSelector:@selector(tableViewCellForShowPosition:)] && [_delegate conformsToProtocol:@protocol(ReSignUpCellDelegate)])
        {
            [_delegate tableViewCellForShowPosition:self];
        }
        
    }
    return YES;
}





/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
