//
//  MechineRankingListViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/17.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "MechineRankingListViewController.h"

@interface MechineRankingListViewController ()

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation MechineRankingListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_millOrRefs parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [self.dataArray setArray:responseObject[@"millRefs"]];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RankingListCell" forIndexPath:indexPath];
    /*
     请求参数：1 type【类型 //1是矿机排行 2.是推广排行 可扩展】
     返回值：参考返回值表格
     正确返回参数说明：
     pageCount 总页数
     currPage 当前页数
     
     publicMessages 公告集合
     mobile 账号（手机号马赛克）
     numberCount 数量(可为矿机数量、推广人数)
     rankingType  类型
     */
    // Configure the cell...
    NSDictionary *itemDic = self.dataArray[indexPath.row];
    cell.textLabel.text = itemDic[@"mobile"];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",itemDic[@"numberCount"]];
    return cell;
}

#pragma mark - tableView delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end