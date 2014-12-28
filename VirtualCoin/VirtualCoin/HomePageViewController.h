//
//  HomePageViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/10.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

//总贡献
@property (weak, nonatomic) IBOutlet UILabel *allCreditUL;

//产出总量
@property (weak, nonatomic) IBOutlet UILabel *mineralPoolForCoinNumberUL;
//册人数
@property (weak, nonatomic) IBOutlet UILabel *numberCountUL;

//矿机总量 
@property (weak, nonatomic) IBOutlet UILabel *millNumUL;

@end
