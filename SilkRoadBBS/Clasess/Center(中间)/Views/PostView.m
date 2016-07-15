//
//  PostView.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PostView.h"
#import "BaseTextField.h"
#import "BaseTextView.h"
#import "PostViewProtocol.h"

@interface PostView ()
<PostViewProtocolDelegat>
{
    void(^_pushForumInfoBlock)(getForumInfoBlock);
    void(^_selectedImageBlock)(optionImageBlock);
    void(^_deleteImageBlock)(UIImage *);

    getForumInfoBlock _getForumInfoBlock;
    optionImageBlock _addImageBlock;
    PostItem *_deleteItem;
}
@property(nonatomic) PostViewProtocol *protocol;

@end
@implementation PostView

- (UICollectionViewFlowLayout *)segmentBarLayout:(CGRect)frame
{
    UICollectionViewFlowLayout *segmentBarLayout = [[UICollectionViewFlowLayout alloc] init];
    segmentBarLayout.itemSize = CGSizeMake((CGRectGetWidth(frame) - 35) / 4,(CGRectGetWidth(frame) - 35) / 4);
    segmentBarLayout.minimumLineSpacing = 5;
    segmentBarLayout.minimumInteritemSpacing = 5;
    segmentBarLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    segmentBarLayout.headerReferenceSize = CGSizeMake(CGRectGetWidth(frame), 210);
    segmentBarLayout.footerReferenceSize = CGSizeMake(CGRectGetWidth(frame), 65);
    return segmentBarLayout;
}


- (id)initWithFrame:(CGRect)frame pushForumInfo:(void(^)(getForumInfoBlock))pushForumInfo selectedImage:(void(^)(optionImageBlock))selectedImage deleteImage:(void(^)(UIImage *))deleteImage;
{
    if ((self = [super initWithFrame:frame collectionViewLayout:[self segmentBarLayout:frame] ])) {
        self.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.backgroundColor = [UIColor whiteColor];
        [self registerClass:[PostItem class] forCellWithReuseIdentifier:@"cell"];
        [self registerClass:[PostHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [self registerClass:[PostFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];

        _protocol = PostViewProtocol.new;
        _protocol.delegate = self;
        self.delegate = _protocol;
        self.dataSource = _protocol;
        
        _pushForumInfoBlock = pushForumInfo;
        _selectedImageBlock = selectedImage;
        _deleteImageBlock = deleteImage;
        [self creatBlock];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.height = self.contentSize.height;
        });

    }
    return self;
}

- (void)creatBlock
{
    WEAKSELF
    _getForumInfoBlock = ^(NSString *title)
    {
        [weakSelf.protocol showSeleteedTitle:title];
    };
    
    _addImageBlock = ^(UIImage *image){
        [weakSelf.protocol.images addObject:image];
     
//        [weakSelf insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:_protocol.images.count - 1 inSection:0]]];
        [weakSelf reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.contentSize.height >= self.superview.height)
            {
                weakSelf.height = weakSelf.superview.height;
            }
            else
            {
                weakSelf.height = weakSelf.contentSize.height;
            }
        });
    };
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self endEditing:YES];
    if (_protocol.images.count == indexPath.row) {
        _selectedImageBlock(_addImageBlock);
    }
}

- (void)collectionView:(UICollectionView *)collectionView fieldText:(NSString *)fieldText viewText:(NSString *)viewText;
{
    _postTitle = fieldText;
    _postContent = viewText;
}

- (void)collectionViewWithPushForumInfo:(UICollectionView *)collectionView;
{
    _pushForumInfoBlock(_getForumInfoBlock);
}

- (void)deleteItem:(PostItem *)item;
{
    _deleteItem = item;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认删除" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0);
{
    if (alertView.firstOtherButtonIndex == buttonIndex)
    {
        NSIndexPath *indexPath = [self indexPathForCell:_deleteItem];
        _deleteImageBlock([_protocol.images objectAtIndex:indexPath.row]);
        [_protocol.images removeObjectAtIndex:indexPath.row];
//        [self deleteItemsAtIndexPaths:@[indexPath]];
        [self reloadData];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.contentSize.height >= self.superview.height)
            {
                self.height = self.superview.height;
            }
            else
            {
                self.height = self.contentSize.height;
            }
        });

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
