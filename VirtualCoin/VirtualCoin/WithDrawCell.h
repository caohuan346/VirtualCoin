//
//  WithDrawCell.h
//  VirtualCoin
//
//  Created by hc on 14/12/28.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithDrawCell : UITableViewCell

/*
 pageCount 总页数
 currPage 当前页数
 withDraws 提现记录集合
     bank 银行名称
     wdBankCard 银行卡号
     wdMoney 提现金额
     wdStatus 提现状态 //1 成功 2失败 3.审核  4撤销
     wdName 持卡人姓名
     wdId id 用于撤销提现

 */


//成功  、 撤销

//data
@property(nonatomic,copy)NSString *wdId;

//ui
@property (weak, nonatomic) IBOutlet UILabel *wdDateUL;
@property (weak, nonatomic) IBOutlet UILabel *wdTimeUL;

@property (weak, nonatomic) IBOutlet UILabel *wdMoneyUL;//金额

@property (weak, nonatomic) IBOutlet UILabel *wdBankCardUL;//提现账户

@property (weak, nonatomic) IBOutlet UILabel *wdStatusUL;//状态

//撤销按钮
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

//取消
- (IBAction)cancelDraw:(id)sender;

@end
