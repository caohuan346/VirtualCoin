//
//  TradeRecordCell.h
//  VirtualCoin
//
//  Created by hc on 14/12/16.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeRecordCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *noLabel;

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@end
