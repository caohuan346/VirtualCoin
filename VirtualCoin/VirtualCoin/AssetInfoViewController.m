//
//  AssetInfoViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/17.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "AssetInfoViewController.h"
#import "AppDelegate.h"

@interface AssetInfoViewController ()

@end

@implementation AssetInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    @property (nonatomic,copy) NSString *accounts;//accounts 可用人民币
//    @property (nonatomic,copy) NSString *coinNumber;//coinNumber 可用虚拟币
//    @property (nonatomic,copy) NSString *millNum;// millNum 矿机数
//    @property (nonatomic,copy) NSString *frozenMoney;//frozenMoney 冻结RMB
//    @property (nonatomic,copy) NSString *frozenCoinNumber;//frozenCoinNumber 冻结虚拟币
//    @property (nonatomic,copy) NSString *credit;//credit 算力
    
    
    
    self.availCnyUL.text = [NSString stringWithFormat:@"%@元",SharedAppDelegate.globalUser.accounts];//人民币
    self.availXybUL.text = [NSString stringWithFormat:@"%@XYB",SharedAppDelegate.globalUser.coinNumber];//幸运币
    self.availmillNumUL.text = [NSString stringWithFormat:@"%@G",SharedAppDelegate.globalUser.millNum];//矿机
    self.creditUL.text = [NSString stringWithFormat:@"%@台",SharedAppDelegate.globalUser.credit];//算力
    
    self.frozenCnyUL.text = [NSString stringWithFormat:@"%@元",SharedAppDelegate.globalUser.frozenMoney];//冻结人民币
    self.frozenXybUL.text = [NSString stringWithFormat:@"%@XYB",SharedAppDelegate.globalUser.frozenCoinNumber];//冻结幸运币
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
