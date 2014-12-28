//
//  TradeRecordViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/28.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "TradeRecordViewController.h"
#import "MJRefresh.h"
#import "TradeCell.h"

@interface TradeRecordViewController (){
    int _tempPageIndex;
    
    int _pageCount;// 总页数
    int _currPage;// 当前页数
    
    BOOL _isHeaderRereshing;
}

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation TradeRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.dataArray = [NSMutableArray array];
    _tempPageIndex  = 1;
    
    _isHeaderRereshing = YES;
    //[self loadData];
    [self setupRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TradeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TradeCell" forIndexPath:indexPath];
    
    // Configure the cell...
    /*
     /*pageCount 总页数
     currPage 当前页数
     transactions个人交易记录集合
         tranType交易类型 1买入2.卖出
         tranMoney交易价格
         tranCount交易数量
         tranAccounts 交易总金额
         tranDate交易时间 （Long类型 需转换成String展示）
     
     ....其他属性按照开发需求自定义展示与否
     */
    
    NSDictionary *itemDic = self.dataArray[indexPath.row];
    
    cell.tranDateUL.text = [[GlobalHandler sharedInstance] getDateStr:[NSString stringWithFormat:@"%@",itemDic[@"tranDate"]]];
    cell.tranTimeUL.text = [[GlobalHandler sharedInstance] getTimeStr:[NSString stringWithFormat:@"%@",itemDic[@"tranDate"]]];
    
    cell.tranTypeUL.text = [NSString stringWithFormat:@"%@",itemDic[@"tranType"]];//itemDic[@"tranType"];
    
    cell.tranMoneyUL.text = [NSString stringWithFormat:@"%@",itemDic[@"tranMoney"]];//itemDic[@"tranMoney"];
    
    cell.tranCountUL.text = [NSString stringWithFormat:@"%@",itemDic[@"tranCount"]];//itemDic[@"tranCount"];
    
    cell.tranAccountsUL.text = [NSString stringWithFormat:@"%@",itemDic[@"tranAccounts"]];//itemDic[@"tranAccounts"];
    
    return cell;
}

#pragma mark - private
-(void)loadData {
    NSDictionary *param = @{@"page":[NSNumber numberWithInt:_tempPageIndex]};
    
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_tranInfosByUid parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if(_isHeaderRereshing){
            [self.dataArray setArray:responseObject[@"transactions"]];
        }else{
            [self.dataArray addObjectsFromArray:responseObject[@"transactions"]];
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
    }];
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


@end
