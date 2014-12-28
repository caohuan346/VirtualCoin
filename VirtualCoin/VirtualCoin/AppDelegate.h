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

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//测滑菜单
@property (nonatomic,strong) MMDrawerController *sliderViewController;

@property (nonatomic,strong) GlobalUser *globalUser;

@end

