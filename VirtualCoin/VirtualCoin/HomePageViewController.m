//
//  HomePageViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/10.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "HomePageViewController.h"

@interface HomePageViewController ()

@property(nonatomic,strong)NSMutableArray *recordArray;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.recordArray = [NSMutableArray array];
    
    [self loadData];
    
    [self loadAnnouncements];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - private
-(void)loadData {
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_getHeadInfos parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        /*
         allCoinNumber = "134074.3389";
         allCredit = 364790; //总贡献
         millNum = 49481;//矿机总量
         mineralPoolForCoinNumber = "151768.809847821";//产出总量
         numberCount = 3348;//注册人数
         rtCode = 0;
         rtMsg = "\U64cd\U4f5c\U6210\U529f";
         */
        
        self.allCreditUL.text = [NSString stringWithFormat:@"贡献总量：%@",responseObject[@"allCredit"]];
         self.mineralPoolForCoinNumberUL.text = [NSString stringWithFormat:@"产出总量：%@",responseObject[@"mineralPoolForCoinNumber"]];
         self.numberCountUL.text = [NSString stringWithFormat:@"注册人数：%@",responseObject[@"numberCount"]];
         self.millNumUL.text = [NSString stringWithFormat:@"矿机总量：%@",responseObject[@"millNum"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

//获取公告
-(void)loadAnnouncements {
    NSDictionary *param = @{@"page":@1};
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_getPublicInfos parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        /*
         
         currPage = 1;
         numberCount = 11;
         pageCount = 2;
         publicMessages =     (
         {
         pcontent = "\U5730\U5740www.luckycoin.cn\n\U8c22\U8c22\U5927\U5bb6\U7684\U652f\U6301\Uff0c\U8c22\U8c22\U5927\U5bb6\U7684\U4e0d\U79bb\U4e0d\U5f03\Uff0c\U6211\U4eec\U5c06\U4f1a\U505a\U5230\U6700\U597d\U3002\n\U63d0\U73b0\U65f6\U95f4\U6539\U56de\U5f53\U592918\U70b9\U524d\U7684\U8ba2\U5355\U5f53\U5929\U5904\U7406\Uff0c18\U70b9\U540e\U7684\U8ba2\U5355\U7b2c\U4e8c\U5929\U5904\U7406\U3002";
         pdate = 1418634575000;
         pid = 13;
         ptitle = "\U6b63\U5f0f\U4ecb\U7ecd\U5b98\U7f51\U5df2\U7ecf\U53d1\U5e03";
         sendName = "--\U5e78\U8fd0\U5e01\U8fd0\U8425\U56e2\U961f";
         type = 1;
         },
         
         ....
         
         */
    
        [self.recordArray setArray:responseObject[@"publicMessages"]];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.recordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"msgCell" forIndexPath:indexPath];
    
    NSDictionary *itemDic = self.recordArray[indexPath.row];
    cell.textLabel.text = itemDic[@"ptitle"];
    // Configure the cell...
    
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
