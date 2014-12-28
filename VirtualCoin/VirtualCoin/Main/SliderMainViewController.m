//
//  SliderMainViewController.m
//  demo
//
//  Created by zhaoxiao on 14-11-10.
//  Copyright (c) 2014年 zhaoxiao. All rights reserved.
//

#import "SliderMainViewController.h"
#import "LeftViewController.h"
#import "CenterViewController.h"

@interface SliderMainViewController ()

@end

@implementation SliderMainViewController

+(SliderMainViewController *)mainViewController
{
    static SliderMainViewController *mainVC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CenterViewController *centerVC = [[CenterViewController alloc]init];
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LeftSlider" bundle:nil];
        
        LeftViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
        mainVC = [[SliderMainViewController alloc]initWithCenterViewController:centerVC leftDrawerViewController:leftVC];
        mainVC.maximumLeftDrawerWidth = 275.0f;
        mainVC.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
        mainVC.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    });
    
    return mainVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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
