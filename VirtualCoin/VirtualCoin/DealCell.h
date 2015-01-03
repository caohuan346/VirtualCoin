//
//  DealCell.h
//  VirtualCoin
//
//  Created by hc on 15/1/2.
//  Copyright (c) 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DealCell : UITableViewCell

/*
 pageCount 总页数
 currPage 当前页数
 tranInfos 订单集合
     tranType 成交类型 1.买入 2.卖出
     tranMoney 成交价格
     tranCount 成交数量
     tranAccounts 成交金额
     tranDate 成交时间（Long类型 需转换成String展示）
     ....其他属性按照开发需求自定义展示与否
 */

@property (weak, nonatomic) IBOutlet UILabel *tranDateUL;

@property (weak, nonatomic) IBOutlet UILabel *tranTypeUL;

@property (weak, nonatomic) IBOutlet UILabel *tranMoneyUL;

@property (weak, nonatomic) IBOutlet UILabel *tranCountUL;

@property (weak, nonatomic) IBOutlet UILabel *tranAccountsUL;


@end
