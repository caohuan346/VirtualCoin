//
//  ChargeRecordCell.h
//  VirtualCoin
//
//  Created by hc on 14/12/28.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeRecordCell : UITableViewCell

/*
 pageCount 总页数
 currPage 当前页数
 recharges充值记录集合
     reMoney 充值金额
     reType	充值类型 //1网银充值 2.支付宝充值
     reStatus 状态 //1.成功 2.3代表未到账
     reDate  充值时间（Long类型 需转换成String展示）
     
     ....其他属性按照开发需求自定义展示与否

 */


@property (weak, nonatomic) IBOutlet UILabel *reDateUL;
@property (weak, nonatomic) IBOutlet UILabel *reTimeUL;

@property (weak, nonatomic) IBOutlet UILabel *reTypeUL;//类型

@property (weak, nonatomic) IBOutlet UILabel *reMoneyUL;

@property (weak, nonatomic) IBOutlet UILabel *reStatusUL;

@end
