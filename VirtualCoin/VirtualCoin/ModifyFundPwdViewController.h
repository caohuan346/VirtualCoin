//
//  ModifyFundPwdViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/23.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ModifyFundPwdViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPwd;

@property (weak, nonatomic) IBOutlet UITextField *myNewPwd;

@property (weak, nonatomic) IBOutlet UITextField *confirmPwd;

- (IBAction)submit:(id)sender;

@end
