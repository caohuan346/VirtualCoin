//
//  MechineCenterViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/17.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "MechineCenterViewController.h"
#import "MechineRecordCell.h"
#import "MJRefresh.h"

@interface MechineCenterViewController (){
    int _tempPageIndex;
    
    int _pageCount;// 总页数
    int _currPage;// 当前页数
    
    BOOL _isHeaderRereshing;
}
@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MechineCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self getMechinePrice];
    
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
#pragma mark - private
-(void)getMechinePrice {
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_millPrice parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.itemPriceUL.text = [NSString stringWithFormat:@"每台矿机售价%@",responseObject[@"price"]];
        self.maxBuyNumUL.text = [NSString stringWithFormat:@"最多购买%@",responseObject[@"maxMillNumber"]];
        /*
         price 人民币价格
         coinNumber 需要多少虚拟币
         maxMillNumber 最大可购买
         */
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

-(void)loadData {
    /*
     pageCount 总页数
     currPage 当前页数
     wkInfos挖矿记录集合
        wkCoinNumber产出数量
        wkType	产出类型 //1网页产出 2.APP产出
        wkCreateDate产出时间（Long类型 需转换成String展示）
     */
    
    NSDictionary *param = @{@"page":[NSNumber numberWithInt:_tempPageIndex]};
    
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_wkInfos parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(_isHeaderRereshing){
            [self.dataArray setArray:responseObject[@"wkInfos"]];
        }else{
            [self.dataArray addObjectsFromArray:responseObject[@"wkInfos"]];
        }
        
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
        /*

         */
        
        _pageCount = [responseObject[@"pageCount"] intValue];
        _currPage = [responseObject[@"currPage"] intValue];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
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


#pragma mark - tableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MechineRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MechineRecordCell" forIndexPath:indexPath];
    
    // Configure the cell...
    /*
     pageCount 总页数
     currPage 当前页数
     wkInfos挖矿记录集合
         wkCoinNumber产出数量
         wkType	产出类型 //1网页产出 2.APP产出
         wkCreateDate产出时间（Long类型 需转换成String展示）
     */
    
    NSDictionary *itemDic = self.dataArray[indexPath.row];

    cell.typeLabel.text = [NSString stringWithFormat:@"%@",itemDic[@"wkType"]];//itemDic[@"wkType"];
    cell.amountLabel.text = [NSString stringWithFormat:@"%@",itemDic[@"wkCoinNumber"]];//itemDic[@"wkCoinNumber"];
    cell.dateLabel.text = [[GlobalHandler sharedInstance] getDateStr:itemDic[@"wkCreateDate"]];
    cell.timeLabel.text = [[GlobalHandler sharedInstance] getTimeStr:itemDic[@"wkCreateDate"]];
    
    return cell;
}

#pragma mark - action
- (IBAction)buyMechine:(id)sender {
    if ([self.buyTF.text isEqualToString:@""]) {
        [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:@"请输入购买数量" okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
            
        }];
        return;
    }
    
    //购买
    NSDictionary *param = @{@"buyNum":self.buyTF.text};
    
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_coinBuyMill parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:responseObject[@"rtMsg"] okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
            
        }];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];

}

@end
