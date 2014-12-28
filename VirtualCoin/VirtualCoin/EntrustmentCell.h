//
//  EntrustmentCell.h
//  VirtualCoin
//
//  Created by hc on 14/12/28.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EntrustmentCell : UITableViewCell

/*
 pageCount 总页数
 currPage 当前页数
 orderInfos 个人委托记录集合
     orderId 订单ID
     optType 类型 1买入2.卖出
     orderMoney 委托价格
     orderUnFinishedCount 委托量
     orderAccounts 委托总金额
     orderDate 委托时间 （Long类型 需转换成String展示）
 
 ....其他属性按照开发需求自定义展示与否
 */
//data
@property(nonatomic,copy)NSString *orderId;

//ui
@property (weak, nonatomic) IBOutlet UILabel *orderDateUL;
@property (weak, nonatomic) IBOutlet UILabel *orderTimeUL;

@property (weak, nonatomic) IBOutlet UILabel *optTypeUL;

@property (weak, nonatomic) IBOutlet UILabel *orderMoneyUL;

@property (weak, nonatomic) IBOutlet UILabel *orderUnFinishedCountUL;

@property (weak, nonatomic) IBOutlet UILabel *orderAccountsUL;


@property (weak, nonatomic) IBOutlet UIButton *optBtn;

//撤销委托
- (IBAction)cancelEntrust:(id)sender;

@end
