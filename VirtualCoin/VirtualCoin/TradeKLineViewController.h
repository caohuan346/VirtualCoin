//
//  TradeKLineViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/13.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeKLineViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIView *kLineBgView;

@property (weak, nonatomic) IBOutlet UILabel *buyMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *sellMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *maxMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *minMoneyLabel;

@property (weak, nonatomic) IBOutlet UILabel *tranCountLabel;

@property (weak, nonatomic) IBOutlet UISegmentedControl *kLineTimeSeg;

- (IBAction)segmentAction:(id)sender;
@end
