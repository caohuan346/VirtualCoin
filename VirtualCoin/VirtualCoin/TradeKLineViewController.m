//
//  TradeKLineViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/13.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "TradeKLineViewController.h"
#import "lineView.h"
#import "UIColor+helper.h"
#import "DealCell.h"
#import "MJRefresh.h"

@interface TradeKLineViewController (){
    lineView *lineview;
    UIButton *btnDay;
    UIButton *btnWeek;
    UIButton *btnMonth;
    
    
    int _tempPageIndex;
    
    int _pageCount;// 总页数
    int _currPage;// 当前页数
    
    BOOL _isHeaderRereshing;
}

@property(nonatomic,strong)NSMutableArray *dataArray;


@end

@implementation TradeKLineViewController

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    return YES;
}

-(void)viewDidLoad{
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //dataList
    self.dataArray = [NSMutableArray array];
    _tempPageIndex  = 1;
    
    _isHeaderRereshing = YES;
    [self setupRefresh];
    
    //other data
    [self loadData];
        //注释掉 日k 周k 按钮
    /*
 
    // 日k按钮
    btnDay = [[UIButton alloc] initWithFrame:CGRectMake(20, 70, 50, 30)];
    [btnDay setTitle:@"日K" forState:UIControlStateNormal];
    [btnDay addTarget:self action:@selector(kDayLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnDay];
    [self.view addSubview:btnDay];
    // 周k按钮
    btnWeek = [[UIButton alloc] initWithFrame:CGRectMake(75, 70, 50, 30)];
    [btnWeek setTitle:@"周K" forState:UIControlStateNormal];
    [btnWeek addTarget:self action:@selector(kWeekLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnWeek];
    [self.view addSubview:btnWeek];
    // 月k按钮
    btnMonth = [[UIButton alloc] initWithFrame:CGRectMake(130, 70, 50, 30)];
    [btnMonth setTitle:@"月K" forState:UIControlStateNormal];
    [btnMonth addTarget:self action:@selector(kMonthLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnMonth];
    [self.view addSubview:btnMonth];
    
    // 放大
    UIButton *btnBig = [[UIButton alloc] initWithFrame:CGRectMake(185, 70, 50, 30)];
    [btnBig setTitle:@"+" forState:UIControlStateNormal];
    [btnBig addTarget:self action:@selector(kBigLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnBig];
    [self.view addSubview:btnBig];
    
    // 缩小
    UIButton *btnSmall = [[UIButton alloc] initWithFrame:CGRectMake(240, 70, 50, 30)];
    [btnSmall setTitle:@"-" forState:UIControlStateNormal];
    [btnSmall addTarget:self action:@selector(kSmallLine) forControlEvents:UIControlEventTouchUpInside];
    [self setButtonAttr:btnSmall];
    [self.view addSubview:btnSmall];
     */
    
    self.kLineBgView.backgroundColor = [UIColor colorWithHexString:@"#111111" withAlpha:1];
    // 添加k线图
    lineview = [[lineView alloc] init];
    CGRect frame = self.view.frame;
    frame.origin = CGPointMake(0, 0);
    frame.size = CGSizeMake(310, 200);
    lineview.frame = frame;
    //lineview.backgroundColor = [UIColor blueColor];
    lineview.req_type = @"d";
    lineview.req_freq = @"601888.SS";
    lineview.kLineWidth = 5;
    lineview.kLinePadding = 0.5;
    [self.kLineBgView addSubview:lineview];
    [lineview start]; // k线图运行
    [self setButtonAttrWithClick:btnDay];
    
}

-(void)kDayLine{
    [self setButtonAttrWithClick:btnDay];
    [self setButtonAttr:btnMonth];
    [self setButtonAttr:btnWeek];
    lineview.req_type = @"d";
    [self kUpdate];
}

-(void)kWeekLine{
    [self setButtonAttrWithClick:btnWeek];
    [self setButtonAttr:btnMonth];
    [self setButtonAttr:btnDay];
    lineview.req_type = @"w";
    [self kUpdate];
}

-(void)kMonthLine{
    [self setButtonAttrWithClick:btnMonth];
    [self setButtonAttr:btnWeek];
    [self setButtonAttr:btnDay];
    lineview.req_type = @"m";
    [self kUpdate];
}

-(void)kBigLine{
    lineview.kLineWidth += 1;
    [self kUpdate];
}

-(void)kSmallLine{
    lineview.kLineWidth -= 1;
    if (lineview.kLineWidth<=1) {
        lineview.kLineWidth = 1;
    }
    [self kUpdate];
}

-(void)kUpdate{
    [lineview update];
}

-(void)setButtonAttr:(UIButton*)button{
    button.backgroundColor = [UIColor blackColor];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}
-(void)setButtonAttrWithClick:(UIButton*)button{
    button.backgroundColor = [UIColor colorWithHexString:@"cccccc" withAlpha:1];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DealCell" forIndexPath:indexPath];
    /*
     pageCount 总页数
     currPage 当前页数
     tranInfos 订单集合
         tranType 成交类型 1.买入 2.卖出
         tranMoney 成交价格
         tranCount 成交数量
         tranAccounts 成交金额
         tranDate 成交时间（Long类型 需转换成String展示）
     ....其他属性按照开发需求自定义展示与否
     */

    NSDictionary *itemDic = self.dataArray[indexPath.row];
    
    cell.tranDateUL.text = [[GlobalHandler sharedInstance] getTimeStr:itemDic[@"tranDate"]];

    cell.tranMoneyUL.text = [NSString stringWithFormat:@"%@元",itemDic[@"tranMoney"]];

    cell.tranCountUL.text = [NSString stringWithFormat:@"%@XYB",itemDic[@"tranCount"]];

    NSString *amount = [[GlobalHandler sharedInstance] decimalwithFloatV:[itemDic[@"tranAccounts"] floatValue] afterPoint:2];
    cell.tranAccountsUL.text = [NSString stringWithFormat:@"%@元",amount];
    
    int type = [itemDic[@"tranType"] intValue];
    if (type == 1) {
        cell.tranTypeUL.text = @"买入";
        
        cell.tranTypeUL.textColor = kThemeGreenColor;
        cell.tranDateUL.textColor = kThemeGreenColor;
        cell.tranMoneyUL.textColor = kThemeGreenColor;
        cell.tranCountUL.textColor = kThemeGreenColor;
        cell.tranAccountsUL.textColor = kThemeGreenColor;
    }else if (type == 2) {
        cell.tranTypeUL.text = @"卖出";
        
        cell.tranTypeUL.textColor = [UIColor redColor];
        cell.tranDateUL.textColor = [UIColor redColor];
        cell.tranMoneyUL.textColor = [UIColor redColor];
        cell.tranCountUL.textColor = [UIColor redColor];
        cell.tranAccountsUL.textColor = [UIColor redColor];
    }

    
    return cell;
}


#pragma mark - private
-(void)loadData {
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_lastestPrice parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        /*
         buyMoney 买一价
         sellMoney 卖一价
         maxMoney 最高价
         minMoney 最低价
         tranCount 24小时交易量
         */
        
        
        self.buyMoneyLabel.text =[NSString stringWithFormat:@"%@",responseObject[@"buyMoney"]];// 买一价
        self.sellMoneyLabel.text =[NSString stringWithFormat:@"%@",responseObject[@"sellMoney"]] ;// 卖一价
        self.maxMoneyLabel.text =[NSString stringWithFormat:@"%@",responseObject[@"maxMoney"]] ;// 最高价
        self.minMoneyLabel.text =[NSString stringWithFormat:@"%@",responseObject[@"minMoney"]] ; //最低价
        self.tranCountLabel.text =[NSString stringWithFormat:@"%@",responseObject[@"tranCount"]] ; //24小时交易量
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

-(void)loadDealData {
    /*
     pageCount 总页数
     currPage 当前页数
     tranInfos 订单集合
         tranType 成交类型 1.买入 2.卖出
         tranMoney 成交价格
         tranCount 成交数量
         tranAccounts 成交金额
         tranDate 成交时间（Long类型 需转换成String展示）
         ....其他属性按照开发需求自定义展示与否
     */
    NSDictionary *param = @{@"page":[NSNumber numberWithInt:_tempPageIndex]};
    
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_tranInfos parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        if(_isHeaderRereshing){
            [self.dataArray setArray:responseObject[@"tranInfos"]];
        }else{
            [self.dataArray addObjectsFromArray:responseObject[@"tranInfos"]];
        }
        
        [self.tableView reloadData];
        
        [self.tableView headerEndRefreshing];
        [self.tableView footerEndRefreshing];
        
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
    
    [self loadDealData];
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
    
    [self loadDealData];
}

#pragma mark - action

- (IBAction)segmentAction:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    NSInteger index = seg.selectedSegmentIndex;
    
    NSLog(@"Index %i", index);
    
    switch (index) {
            
        case 0:

            break;
            
        case 1:
            
            
            break;
            
        case 2:

            
            break;
            
        case 3:

            
            break;
            
        default:
            
            break;
    }
}
@end

