//
//  SellViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/24.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "SellViewController.h"
#import "TradeRecordCell.h"

@interface SellViewController ()

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation SellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
-(void)loadData {
    NSDictionary *param = @{@"type":@2};
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_orders parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        /*
         sellMoney  建议售价
         sellCount	 可卖数量
         money  可用RMB
         coinNumber  可用虚拟币
         buyOrders 委托买单集合
         orderMoney 价格
         orderCount 数量
         optType 类型 1.买入2.卖出
         */
        /*
         
         */
        
        [self.dataArray setArray:responseObject[@"buyOrders"]];
        [self.tableView reloadData];
        
        self.sugesstPriceUL.text =[NSString stringWithFormat:@"%@",responseObject[@"sellMoney"]];// responseObject[@"sellMoney"];
        self.canSellXybUL.text =[NSString stringWithFormat:@"%@",responseObject[@"sellCount"]];// responseObject[@"sellCount"];
        self.availCnyUL.text = [NSString stringWithFormat:@"%@",responseObject[@"money"]];//responseObject[@"money"];
        self.availXybUL.text = [NSString stringWithFormat:@"%@",responseObject[@"coinNumber"]];//responseObject[@"coinNumber"];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TradeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TradeRecordCell" forIndexPath:indexPath];
    
    // Configure the cell...
    NSDictionary *itemDic = self.dataArray[indexPath.row];
    
    cell.noLabel.text = [NSString stringWithFormat:@"%d",indexPath.row + 1];
    
    /*
     {
        orderCount = 44;
        orderMoney = "0.3";
     },
     {
        orderCount = "11.5";
        orderMoney = "0.31";
     },
     */
    
    cell.priceLabel.text = [NSString stringWithFormat:@"%@",itemDic[@"orderMoney"]];
    cell.amountLabel.text = [NSString stringWithFormat:@"%@",itemDic[@"orderCount"]];
    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - action
- (IBAction)sell:(id)sender {
    NSDictionary *param = @{@"optType":@"2",
                            @"orderCount":self.orderCountTF.text,
                            @"orderMoney":self.orderMoneyTF.text,
                            @"moneyPwd":self.moneyPwdTF.text
                            };
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_addOrder parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        //更新用户信息
        [SharedAppDelegate.globalUser fillInfoWithInfoDic:responseObject];
        
        [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:responseObject[@"rtMsg"]okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
            
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}
@end
