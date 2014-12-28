//
//  AssetInfoViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/17.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AssetInfoViewController : UITableViewController
@property (weak, nonatomic) IBOutlet UILabel *availCnyUL;//人民币
@property (weak, nonatomic) IBOutlet UILabel *availXybUL;//幸运币
@property (weak, nonatomic) IBOutlet UILabel *availmillNumUL;//矿机
@property (weak, nonatomic) IBOutlet UILabel *creditUL;//算力

@property (weak, nonatomic) IBOutlet UILabel *frozenCnyUL;//冻结人民币
@property (weak, nonatomic) IBOutlet UILabel *frozenXybUL;//冻结幸运币
@end
