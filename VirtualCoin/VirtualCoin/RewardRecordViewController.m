//
//  RewardRecordViewController.m
//  VirtualCoin
//
//  Created by hc on 15/1/3.
//  Copyright (c) 2015年 happy. All rights reserved.
//

#import "RewardRecordViewController.h"
#import "RewardRecordCell.h"
#import "MJRefresh.h"

@interface RewardRecordViewController (){
    int _tempPageIndex;
    
    int _pageCount;// 总页数
    int _currPage;// 当前页数
    
    BOOL _isHeaderRereshing;
    
    int _segSelectedIndex;

}

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation RewardRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    _tempPageIndex  = 1;
    
    _isHeaderRereshing = YES;

    [self setupRefresh];
    
    _segSelectedIndex = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RewardRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RewardRecordCell" forIndexPath:indexPath];

    NSDictionary *itemDic = self.dataArray[indexPath.row];
    
    cell.dateUL.text = [[GlobalHandler sharedInstance] getDateStr:itemDic[@"pdate"]];
   
   cell.timeUL.text = [[GlobalHandler sharedInstance] getTimeStr:itemDic[@"pdate"]];
   
   cell.acountUL.text = itemDic[@"uname"];
   
   cell.rewardUL.text = itemDic[@"pname"];
    /*
     luckyDraws 中奖记录集合
     pname 奖品名称
     uname 中间人账号（手机号）
     pdate  时间 （Long类型需转换成String展示）
     */
    return cell;
}

#pragma mark - private
-(void)loadData {
    NSDictionary *param = @{@"page":@(_tempPageIndex),
                            @"type":@(_segSelectedIndex)};
    
    [GlobalHandler showActivityViewForView:self.view];
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_getLuckyInfo parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [GlobalHandler dismissActivityViewAnimated:YES];
        NSLog(@"%@",responseObject);
        if(_isHeaderRereshing){
            [self.dataArray setArray:responseObject[@"luckyDraws"]];
        }else{
            [self.dataArray addObjectsFromArray:responseObject[@"luckyDraws"]];
        }
        
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
//        _pageCount = [responseObject[@"pageCount"] intValue];
//        _currPage = [responseObject[@"currPage"] intValue];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [GlobalHandler dismissActivityViewAnimated:YES];
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
    
//     取出上拉
//    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
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
    /*
    if (_pageCount == _currPage) {
        [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:@"已经是最后一页" okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
            
        }];
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        return;
    }
     */
    _isHeaderRereshing = NO;
    
    _tempPageIndex = _currPage + 1;
    
    [self loadData];
}



#pragma mark - action
- (IBAction)selectType:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    _segSelectedIndex = seg.selectedSegmentIndex;
    
    [self headerRereshing];
}
@end
