//
//  RewardRecordViewController.h
//  VirtualCoin
//
//  Created by hc on 15/1/3.
//  Copyright (c) 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardRecordViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISegmentedControl *typeSelectSeg;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)selectType:(id)sender;

@end
