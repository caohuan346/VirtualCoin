//
//  AppDelegate.m
//  VirtualCoin
//
//  Created by hc on 14/12/9.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "AppDelegate.h"
#import "LeftViewController.h"
#import "IOTester.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self initViewControllers];
    
    [self initUserInfo];
    
    return YES;
}

-(void)initUserInfo {
    self.globalUser = [[GlobalUser alloc] init];
    //18926575205 123456
    self.globalUser.password = @"123456";
    self.globalUser.mobile = @"18926575205";
    
    IOTester *tester = [[IOTester alloc]init];
    [tester test];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - private
-(void)initViewControllers
{
    UIViewController *firstViewCtl = [[UIViewController alloc] init];
    firstViewCtl.view.backgroundColor = [UIColor purpleColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:firstViewCtl];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LeftSlider" bundle:nil];
    LeftViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    _sliderViewController = [[MMDrawerController alloc]initWithCenterViewController:nav leftDrawerViewController:leftVC];
    _sliderViewController.maximumLeftDrawerWidth = 160.0f;
    _sliderViewController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    _sliderViewController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    self.window.rootViewController = _sliderViewController;
    
    
    
    [self.window makeKeyAndVisible];
}


@end
