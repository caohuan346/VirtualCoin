//
//  DrawViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/11.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawViewController : UITableViewController
/*
 参数1 wdMoney【提现金额】
 参数2 wdBankCard【卡号】
 参数3 wdName【姓名】
 参数4 branchBank【支行名称】
 参数5 bank【所属银行】
 参数6 wdDesc【提现备注】
 参数7 tradePwd【提现密码】
 */
@property (weak, nonatomic) IBOutlet UILabel *bankUL;
@property (weak, nonatomic) IBOutlet UILabel *branchBankUL;
@property (weak, nonatomic) IBOutlet UILabel *wdNameUL;
@property (weak, nonatomic) IBOutlet UILabel *wdBankCardUL;

@property (weak, nonatomic) IBOutlet UITextField *wdMoneyTF;

@property (weak, nonatomic) IBOutlet UITextField *tradePwd;

//display part
@property (weak, nonatomic) IBOutlet UILabel *drawAmountUL;
@property (weak, nonatomic) IBOutlet UILabel *feesUL;
@property (weak, nonatomic) IBOutlet UILabel *actualDrawUL;


//提现
- (IBAction)draw:(id)sender;

@end
