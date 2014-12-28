//
//  SpreadViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/26.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpreadViewController  : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong) IBOutlet UITableView *tableView;

@end
