//
//  PostView.h
//  SilkRoadBBS
//
//  Created by Song on 16/7/7.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^getForumInfoBlock)(NSString *);
typedef void(^optionImageBlock)(UIImage *);


@interface PostView : UICollectionView

@property (nonatomic) NSString *postTitle;
@property (nonatomic) NSString *postContent;

- (id)initWithFrame:(CGRect)frame pushForumInfo:(void(^)(getForumInfoBlock))pushForumInfo selectedImage:(void(^)(optionImageBlock))selectedImage deleteImage:(void(^)(UIImage *))deleteImage;
@end
