//
//  ChargeViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/13.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIButton *btn50;
@property (weak, nonatomic) IBOutlet UIButton *btn100;
@property (weak, nonatomic) IBOutlet UIButton *btn500;
@property (weak, nonatomic) IBOutlet UIButton *btn1000;
@property (weak, nonatomic) IBOutlet UITextField *amountTF;

//选择
- (IBAction)selectAmount:(id)sender;

//网银直冲
- (IBAction)netBankCharge:(id)sender;
//支付宝
- (IBAction)alipay:(id)sender;

@end
