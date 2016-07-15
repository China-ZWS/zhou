//
//  Header.h
//  NetSchool
//
//  Created by 周文松 on 15/8/27.
//  Copyright (c) 2015年 TalkWeb. All rights reserved.
//

#ifndef NetSchool_Header_h
#define NetSchool_Header_h

#define WEAKSELF typeof(self) __weak weakSelf = self;
#define RGBA(r,g,b,a)	[UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a] //RGB颜色
#define img(image) [UIImage imageNamed:image]

#define CustomBlack RGBA(20,20,20,1)
#define CustomDarkBlue RGBA(47, 56, 85, 1) //与蓝色导航条一样的颜色
#define CustomBlue RGBA(27, 116, 163, 1) //与蓝色导航条一样的颜色
#define CustomGray RGBA(81,82,83,1) //绿色下载
#define CustomlightGray RGBA(172,173,174,1) //绿色下载
#define CustomRed RGBA(205,25,36,1) //绿色下载
#define CustomOrange RGBA(188, 87, 14, 1) //橘红色



#define kUserDefaults [NSUserDefaults standardUserDefaults]

//判断wifi
#define kSettingIsAllowWIFI  @"kSettingAllowWIFI"
//获取是否wifi
#define kISWIFI ([[NSUserDefaults standardUserDefaults] boolForKey:kSettingIsAllowWIFI])


#define NSNotificationAdd(Server,Sel,Name,Object) [[NSNotificationCenter defaultCenter] addObserver:Server selector:@selector(Sel) name:Name object:Object]
#define NSNotificationPost(name,Object,info) [[NSNotificationCenter defaultCenter] postNotificationName:name object:Object userInfo:info]

#define RefreshWithViews @"refreshWithViews"

#ifdef DEBUG
# define DLog(format, ...) NSLog((@"[文件名:%s]" "[函数名:%s]" "[行号:%d]" format), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

/*
 专门用来保存单例代码
 最后一行不要加 \
 */

// @interface
#define singleton_interface(className) \
+ (className *)shared##className;


// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

#endif
