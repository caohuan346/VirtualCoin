//
//  BuyViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/16.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BuyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *sugesstPriceUL;

@property (weak, nonatomic) IBOutlet UILabel *canBuyXybUL;

@property (weak, nonatomic) IBOutlet UILabel *availCnyUL;

@property (weak, nonatomic) IBOutlet UILabel *availXybUL;

/*
 参数2 orderCount【下单数量】
 参数3 orderMoney【下单价格】
 参数4 moneyPwd 【资金密码】
 */
@property (weak, nonatomic) IBOutlet UITextField *orderMoneyTF;

@property (weak, nonatomic) IBOutlet UITextField *orderCountTF;

@property (weak, nonatomic) IBOutlet UITextField *moneyPwdTF;

//买入
- (IBAction)buy:(id)sender;

@end
