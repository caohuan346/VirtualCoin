//
//  SellViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/24.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UILabel *sugesstPriceUL;

@property (weak, nonatomic) IBOutlet UILabel *canSellXybUL;

@property (weak, nonatomic) IBOutlet UILabel *availCnyUL;

@property (weak, nonatomic) IBOutlet UILabel *availXybUL;

//卖出
- (IBAction)sell:(id)sender;
/*
 参数2 orderCount【下单数量】
 参数3 orderMoney【下单价格】
 参数4 moneyPwd 【资金密码】
 */
@property (weak, nonatomic) IBOutlet UITextField *orderMoneyTF;

@property (weak, nonatomic) IBOutlet UITextField *orderCountTF;

@property (weak, nonatomic) IBOutlet UITextField *moneyPwdTF;

@end
