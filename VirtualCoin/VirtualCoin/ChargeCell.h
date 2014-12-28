//
//  ChargeCell.h
//  VirtualCoin
//
//  Created by hc on 14/12/17.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
