//
//  BuyViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/16.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "BuyViewController.h"
#import "TradeRecordCell.h"
#import "AppDelegate.h"

@interface BuyViewController ()

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation BuyViewController

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
    NSDictionary *param = @{@"type":@1};
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_orders
                                      parameters:param
                                         success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                             
                                             NSLog(@"%@",responseObject);
                                             /*
                                                  buyMoney 建议买入价格
                                                  buyCount 可买数量
                                                  money  可用RMB
                                                  coinNumber  可用虚拟币
                                                  sellOrders 委托卖单集合
                                                  orderMoney
                                                  orderCount
                                                  optType
                                              */
                                             
                                             /*
                                              {
                                                  buyCount = 0;
                                                  buyMoney = "0.29";
                                                  buyOrders = "<null>";
                                                  coinNumber = "0.4268";
                                                  money = 0;
                                                  rtCode = 0;
                                                  rtMsg = "\U64cd\U4f5c\U6210\U529f";
                                                  sellCount = 0;
                                                  sellMoney = 0;
                                                  sellOrders =     (
                                                      {
                                                      orderCount = "77.41";
                                                      orderMoney = "0.29";
                                                      },
                                                      {
                                                      orderCount = 44;
                                                      orderMoney = "0.3";
                                                      },
                                                      {
                                                      orderCount = "11.5";
                                                      orderMoney = "0.31";
                                                      },
                                                      {
                                                      orderCount = "349.7";
                                                      orderMoney = "0.32";
                                              },
                                              */
                                             
                                             [self.dataArray setArray:responseObject[@"sellOrders"]];
                                             [self.tableView reloadData];
                                             
                                            
                                             self.sugesstPriceUL.text = [NSString stringWithFormat:@"%@",responseObject[@"buyMoney"]];//responseObject[@"buyMoney"];
                                             self.canBuyXybUL.text = [NSString stringWithFormat:@"%@",responseObject[@"buyCount"]];//responseObject[@"buyCount"];
                                             self.availCnyUL.text = [NSString stringWithFormat:@"%@",responseObject[@"money"]];//responseObject[@"money"];
                                             self.availXybUL.text =[NSString stringWithFormat:@"%@",responseObject[@"coinNumber"]];// responseObject[@"coinNumber"];
                                             
                                             
                                              
                                               
                                                
                                             
                                         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                             NSLog(@"%@",error.userInfo);
                                         }];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
//    return 15;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TradeRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TradeRecordCell" forIndexPath:indexPath];
    
    // Configure the cell...
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
- (IBAction)buy:(id)sender {
    NSDictionary *param = @{@"optType":@"1",
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
