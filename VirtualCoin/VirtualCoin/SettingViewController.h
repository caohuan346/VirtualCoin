//
//  SettingViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/10.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UISwitch *switchBtn;


- (IBAction)rememberPwd:(id)sender;

@end
