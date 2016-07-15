//
//  PostViewController.m
//  SilkRoadBBS
//
//  Created by Song on 16/7/1.
//  Copyright © 2016年 周文松. All rights reserved.
//

#import "PostViewController.h"
#import "PostView.h"
#import "BasePhotoPickerManager.h"
#import "ForumInfoViewController.h"
@interface PostViewController ()
{
    void(^_successBlock)(id);
}
@property (nonatomic) PostView *postView;
@property (nonatomic) void(^requestWithUploadPic)();
@property (nonatomic) void(^requestWithSubmitTopic)(NSString *);
@property (nonatomic) NSMutableArray *images;

@end

@implementation PostViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithSubmitSuccess:(void(^)(id))success;
{
    if ((self = [super init])) {
        _successBlock = success;
        self.title = NSLocalizedString(@"PostViewController.navTitle",nil);
        [self.navigationItem setBackItemWithTarget:self title:@"" action:@selector(back) image:@"nav_return.png"];
        [self.navigationItem setRightItemWithTarget:self title:NSLocalizedString(@"NavSubmit",nil) action:@selector(eventWithRight) image:nil];
        _images = NSMutableArray.new;
    }
    return self;
}

- (void)back
{
    [self.view endEditing:YES];
    [self dismissViewController];
}

- (void)eventWithRight
{
    _requestWithUploadPic();
}

- (PostView *)postView
{
    return _postView = ({
        PostView *view = nil;
        if (_postView) {
            view = _postView;
        }
        else
        {
            WEAKSELF
            view = [[PostView alloc] initWithFrame:self.view.frame pushForumInfo:^(getForumInfoBlock info)
                    {
                        [weakSelf pushViewController:[[ForumInfoViewController alloc] initWithSeleted:^(id datas)
                                                      {
                                                          weakSelf.parameters = datas;
                                                          info(datas[@"forumName"]);
                                                      }]];
                    } selectedImage:^(optionImageBlock image)
                    {
                        [weakSelf selectedImage:image];
                    }
                                       deleteImage:^(UIImage *image){
                                           [weakSelf.images removeObject:image];
                                       }
                    ];
        }
        view;
    });
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.postView];
    
    WEAKSELF
    self.requestWithUploadPic = ^{
        [weakSelf uploadPic];
    };
    self.requestWithSubmitTopic = ^(NSString *imagesString)
    {
        [weakSelf submitTopic:imagesString];
    };
}

#pragma mark - 图片上传
- (void)uploadPic
{
    
    if (!(NSUInteger)_postView.postTitle.length || !(NSUInteger)_postView.postContent.length) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.unInfo",nil)];
        return;
    }
    if (![_parameters count]) {
        [SVProgressHUD showInfoWithStatus:NSLocalizedString(@"public.alert.unInfo",nil)];
        return;
    }

    
    NSMutableArray *images = NSMutableArray.new;
    for (UIImage *image in _images)
    {
            NSString *imageString = [UIImageJPEGRepresentation(image,0.1) base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [images addObject:imageString];
    }

    if (!images.count) {
        _requestWithSubmitTopic(nil);
        return;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uploadType"] = @"bbsimg";
    params[@"picType"] = @"jpg";
    params[@"fileStrList"] = images;
    [RequestViewModels requestWithUploadPic:self params:params success:^(id datas)
     {
         [SVProgressHUD showWithStatus:NSLocalizedString(@"public.alert.submitting",nil)];
         _requestWithSubmitTopic(datas[@"httppathList"]);
     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
     }];

}

#pragma mark - 发帖
- (void)submitTopic:(NSString *)imagesString
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"categoryId"] = @"1"; // 分区ID
    params[@"forumid"] = _parameters[@"forumId"];
    params[@"topicId"] = @""; // 帖子ID (发帖时传空字符串)
    params[@"typeId"] = @"1"; // 主题类别（暂时1-4随便填一个）
    params[@"postTitle"] = _postView.postTitle;
    params[@"postContent"] = _postView.postContent;;
    params[@"httppathList"] = imagesString;
    
    
    
    [RequestViewModels requestWithSubmitTopic:self params:params success:^(id datas)
     {
        
         [SVProgressHUD showSuccessWithStatus:NSLocalizedString(@"public.alert.uploadSuccess",nil)];
         [self.navigationController dismissViewControllerAnimated:YES completion:^{
             _successBlock(@{@"topicId":datas[@"postId"],@"topicTitle":datas[@"title"],@"forumId":_parameters[@"forumId"]});
         }];
     }failure:^(NSString *msg, NSString *status)
     {
         [SVProgressHUD showInfoWithStatus:msg];
     }];

}

- (void)selectedImage:(optionImageBlock)image
{
    [[BasePhotoPickerManager shared] showActionSheetInView:self.view fromController:self completion:^(id datas)
     {
         image(datas[@"file"]);
         
         [_images addObject:datas[@"file"]];

     }
                                                otherBlock:^(id datas)
     {
         
     }
                                               cancelBlock:^()
     {
         
     } cancelTitle:NSLocalizedString(@"",nil) destructiveTitle:NSLocalizedString(@"public.btnTitle.photos",nil) otherTitle:NSLocalizedString(@"public.btnTitle.photograph",nil)];

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
