//
//  HomePageViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/10.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "HomePageViewController.h"
#import "MJRefresh.h"
#import "AnnounceDetailViewController.h"

@interface HomePageViewController (){
    
    int _tempPageIndex;
    
    int _pageCount;// 总页数
    int _currPage;// 当前页数
    
    BOOL _isHeaderRereshing;
    
    NSDictionary *_detailDic;

}

@property(nonatomic,strong)NSMutableArray *recordArray;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.recordArray = [NSMutableArray array];
    
    _tempPageIndex  = 1;
    
    _isHeaderRereshing = YES;
    //[self loadData];
    
    [self setupRefresh];
    
    [self loadData];
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
    NSDictionary *param = @{@"page":@(_tempPageIndex)};
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
    
        if(_isHeaderRereshing){
            [self.recordArray setArray:responseObject[@"publicMessages"]];
        }else{
            [self.recordArray addObjectsFromArray:responseObject[@"publicMessages"]];
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
     _detailDic = self.recordArray[indexPath.row];
    [self performSegueWithIdentifier:@"toDetail" sender:self];
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
    
    [self loadAnnouncements];
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
    
    [self loadAnnouncements];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toDetail"]) {
        AnnounceDetailViewController *detailCtl = segue.destinationViewController;
        detailCtl.announceDetailDic = _detailDic;
    }
}

@end
