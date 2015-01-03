//
//  AppDelegate.h
//  VirtualCoin
//
//  Created by hc on 14/12/9.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMDrawerController.h"
#import "GlobalUser.h"

//18126288722
//ch0803


//李志鹏 18926575205
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//测滑菜单
@property (nonatomic,strong) MMDrawerController *sliderViewController;

@property (nonatomic,strong) GlobalUser *globalUser;

@end

