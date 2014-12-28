//
//  ChargeRecordTableViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/28.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChargeRecordTableViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) IBOutlet UITableView *tableView;

@end
