//
//  ResetPwdViewController.h
//  VirtualCoin
//
//  Created by hc on 15/1/2.
//  Copyright (c) 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ResetPwdViewController : UITableViewController
//data
@property (copy, nonatomic) NSString *mobile;
@property (copy, nonatomic) NSString *code;

//ui
@property (weak, nonatomic) IBOutlet UITextField *myNewPwdTF;

@property (weak, nonatomic) IBOutlet UITextField *confermPwdTF;

- (IBAction)submit:(id)sender;


@end
