//
//  TradeCell.h
//  VirtualCoin
//
//  Created by hc on 14/12/28.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeCell : UITableViewCell


/*pageCount 总页数
 currPage 当前页数
 transactions个人交易记录集合
 tranType交易类型 1买入2.卖出
 tranMoney交易价格
 tranCount交易数量
 tranAccounts 交易总金额
 tranDate交易时间 （Long类型 需转换成String展示）
 
 ....其他属性按照开发需求自定义展示与否
 */


@property (weak, nonatomic) IBOutlet UILabel *tranDateUL;
@property (weak, nonatomic) IBOutlet UILabel *tranTimeUL;

@property (weak, nonatomic) IBOutlet UILabel *tranTypeUL;

@property (weak, nonatomic) IBOutlet UILabel *tranMoneyUL;

@property (weak, nonatomic) IBOutlet UILabel *tranCountUL;

@property (weak, nonatomic) IBOutlet UILabel *tranAccountsUL;

@end
