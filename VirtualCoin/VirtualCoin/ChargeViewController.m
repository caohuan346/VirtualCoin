//
//  ChargeViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/13.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "ChargeViewController.h"
#import "ChargeCell.h"
#import "MJRefresh.h"

@interface ChargeViewController (){
    
    int _tempPageIndex;
    
    int _pageCount;// 总页数
    int _currPage;// 当前页数
    
    BOOL _isHeaderRereshing;
}

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)NSArray *btnArray;

@end

@implementation ChargeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataArray = [NSMutableArray array];
    
    self.btnArray = @[self.btn50,self.btn100,self.btn500,self.btn1000];
    
    
    _tempPageIndex  = 1;
    
    _isHeaderRereshing = YES;
    //[self loadData];
    [self setupRefresh];
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
    NSDictionary *param = @{@"page":[NSNumber numberWithInt:_tempPageIndex]};
    
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_getRec parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if(_isHeaderRereshing){
            [self.dataArray setArray:responseObject[@"recharges"]];
        }else{
            [self.dataArray addObjectsFromArray:responseObject[@"recharges"]];
        }
        
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        /*
         pageCount 总页数
         currPage 当前页数
         recharges充值记录集合
             reMoney 充值金额
             reType	充值类型 //1网银充值 2.支付宝充值
             reStatus 状态 //1.成功 2.3代表未到账
             reDate  充值时间（Long类型 需转换成String展示）
         */
        
        _pageCount = [responseObject[@"pageCount"] intValue];
        _currPage = [responseObject[@"currPage"] intValue];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
    }];
}


#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ChargeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChargeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    /*
     currPage = 1;
     numberCount = 21;
     pageCount = 2;
     pid = 0;
     recharges =     (
     {
         reBankCard = "<null>";
         reBankName = "<null>";
         reDate = 1419175009000;
         reDesc = "<null>";
         reId = 4260;
         reMobile = "<null>";
         reMoney = 50;
         reSerialNumber = "<null>";
         reStatus = 3;
         reType = 2;
         reUid = 10815;
     },
     {

     */
    
    NSDictionary *itemDic = self.dataArray[indexPath.row];
    cell.dateLabel.text = [[GlobalHandler sharedInstance] getDateStr:itemDic[@"reDate"]];//itemDic[@"reDate"];
    cell.timeLabel.text = [[GlobalHandler sharedInstance] getTimeStr:itemDic[@"reDate"]];//itemDic[@"reDate"];
    
    //1网银充值 2.支付宝充值
    int reType = [itemDic[@"reType"] intValue];
    if (reType == 1) {
         cell.typeLabel.text = @"网银";
    }else if (reType == 2) {
        cell.typeLabel.text = @"支付宝";
    }
    
    cell.amountLabel.text = [NSString stringWithFormat:@"%@",itemDic[@"reMoney"]];
    
    //reStatus 状态 //1.成功 2.3代表未到账
    int status = [itemDic[@"reStatus"] intValue];
    if (status == 1) {
        cell.stateLabel.text = @"成功";
    }else if(status == 2 || status == 3){
        cell.stateLabel.text = @"未到账";
    }
    
    return cell;
}

#pragma mark - MJRefresh
/**
 *  集成刷新控件
 */
- (void)setupRefresh
{
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    [self.tableView headerBeginRefreshing];
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
}
#pragma mark 开始进入刷新状态
- (void)headerRereshing
{
    _isHeaderRereshing = YES;
    
    _tempPageIndex = 1;
    
    [self loadData];
}

- (void)footerRereshing
{
    //最后一页
    if (_pageCount == _currPage) {
        [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:@"已经是最后一页" okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
            
        }];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        return;
        
    }
    _isHeaderRereshing = NO;
    
    _tempPageIndex = _currPage + 1;
    
    [self loadData];
}

#pragma mark - action
- (IBAction)selectAmount:(id)sender {
    UIButton *selectBtn = (UIButton *)sender;
    self.amountTF.text =  selectBtn.titleLabel.text;
    
    for (UIButton *btn in self.btnArray) {
        if ([btn isEqual:selectBtn]) {
            [btn setImage:[UIImage imageNamed:@"common_radio_tap"] forState:UIControlStateNormal];
        }else{
            [btn setImage:[UIImage imageNamed:@"common_radio"] forState:UIControlStateNormal];
        }
    }
}
- (IBAction)netBankCharge:(id)sender {

}

- (IBAction)alipay:(id)sender {
    [GlobalHandler showActivityViewForView:self.view];
    
    NSDictionary *paras = @{@"reMoney":self.amountTF.text,
                            @"reType":@2};

    
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_addRec parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [GlobalHandler dismissActivityViewAnimated:YES];
        //uid pid
        if ([responseObject[@"rtCode"] intValue] == 0) {
            
        }
        //[[GlobalHandler sharedInstance] showAlertWithMsg:responseObject[@"rtMsg"]];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GlobalHandler dismissActivityViewAnimated:YES];
        
    }];
}

@end
