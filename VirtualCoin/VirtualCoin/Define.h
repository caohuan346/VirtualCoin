//
//  Define.h
//  TheGunners
//
//  Created by Happy on 14/10/21.
//  Copyright (c) 2014年 Happy. All rights reserved.
//

#ifndef TheGunners_Define_h
#define TheGunners_Define_h

/////////////////////////////////////////// common ////////////////////////////////////////////
#define SharedAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
#define StandardUserDefaults [NSUserDefaults standardUserDefaults]

//过期
#define DEPRECATED(_version) __attribute__((deprecated))

//singleton
#define SYNTHESIZE_SINGLETON_FOR_HEADER(className) \
\
+ (className *) sharedInstance;

#define SYNTHESIZE_SINGLETON_FOR_CLASS(className) \
\
+ (className *)sharedInstance { \
static className *sharedInstance = nil; \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
sharedInstance = [[self alloc] init]; \
}); \
return sharedInstance; \
}

/////////////////////////////////////////// device ////////////////////////////////////////////
//判断是否是Retina显示屏
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
//判断是否是iPhone5/5s
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isInch4 [UIScreen mainScreen].bounds.size.height==568
//判断是否是iPhone6
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
//判断是否是iPhone6+
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

//判断是否是pad
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
//主屏宽
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
//主屏高
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//当前设备的ios版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
//ios7及以上
#define IOS_VERSION_7_OR_ABOVE (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)? (YES):(NO))
//当前设备的语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

/////////////////////////////////////////// color ////////////////////////////////////////////
//RGB Color macro
#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//RGB color macro with alpha
#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]

#endif
