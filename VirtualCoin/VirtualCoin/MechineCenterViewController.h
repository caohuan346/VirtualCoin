//
//  MechineCenterViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/17.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MechineCenterViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *itemPriceUL;
@property (weak, nonatomic) IBOutlet UILabel *maxBuyNumUL;

//购买数量
@property (weak, nonatomic) IBOutlet UITextField *buyTF;

- (IBAction)buyMechine:(id)sender;

@end
