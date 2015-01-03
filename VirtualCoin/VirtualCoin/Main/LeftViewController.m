//
//  LeftViewController.m
//  demo
//
//  Created by zhaoxiao on 14-11-10.
//  Copyright (c) 2014年 zhaoxiao. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableCell.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

#define kTopHeaderHeight 100.0f

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *normalImageList;
    NSMutableArray *selectImageList;
    NSMutableArray *textList;
}

@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;

@property (nonatomic,retain) NSIndexPath *selectedIndexPath;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    self.view.backgroundColor = [UIColor colorWithPatternImage:bgImg];
    
    UIImage *bgImg = [UIImage imageNamed:@"ommon_ico_bg"];
    UIImageView *bgImgView = [[UIImageView alloc]initWithImage:bgImg];
    _leftTableView.backgroundView = bgImgView;
    
    _leftTableView.dataSource = self;
    _leftTableView.delegate = self;

    
    [self updateDataWithNotification];
    
    normalImageList = [[NSMutableArray alloc]initWithObjects:@"ommon_ico_help",@"ommon_ico_opinion",@"ommon_ico_remove",@"ommon_ico_site",@"ommon_ico_opinion_tap",@"ommon_ico_remove_tap",@"ommon_ico_site_tap",@"ommon_ico_opinion_tap",@"ommon_ico_remove_tap",@"ommon_ico_site_tap",@"ommon_ico_site_tap", nil];
    selectImageList = [[NSMutableArray alloc]initWithObjects:@"ommon_ico_help_tap",@"ommon_ico_opinion_tap",@"ommon_ico_remove_tap",@"ommon_ico_site_tap",@"ommon_ico_opinion_tap",@"ommon_ico_remove_tap",@"ommon_ico_site_tap",@"ommon_ico_opinion_tap",@"ommon_ico_remove_tap",@"ommon_ico_site_tap",@"ommon_ico_site_tap", nil];
    textList = [[NSMutableArray alloc]initWithObjects:@"幸运首页",@"行情中心",@"交易中心",@"充值RMB",@"提现RMB",@"矿机中心",@"资产信息",@"幸运转盘",@"排行榜",@"设置",@"退出", nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return textList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"leftCell";
    
    LeftTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    UIView *selectedBgView = [[UIView alloc]init];
    selectedBgView.backgroundColor = UIColorFromRGB(0x404040);
    cell.selectedBackgroundView = selectedBgView;
    
    if([indexPath isEqual:_selectedIndexPath])
    {
        cell.titleLabel.textColor = UIColorFromRGB(0xda4453);
    }
    else
    {
        cell.titleLabel.textColor = UIColorFromRGB(0x999999);
    }
    cell.iconImageView.autoresizingMask = UIViewAutoresizingNone;
    cell.titleLabel.text = [textList objectAtIndex:indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIViewController *pushVC = nil;
    switch (indexPath.row) {
        case 0:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"HomePageViewController"];
            
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 1:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"TradeKLineViewController"];
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 2:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Trade" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"TradeSlideViewController"];
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 3:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"ChargeViewController"];

            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 4:
        {
            //DrawViewController 提现人民币
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"DrawViewController"];
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 5:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"MechineCenterViewController"];
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 6:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"AssetInfo" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"AssetInfoViewController"];
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 7:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"RewardViewController"];
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 8:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"MechineRankingListViewController"];
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 9:
        {
            UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Setting" bundle:nil];
            pushVC = [storyBoard instantiateViewControllerWithIdentifier:@"SettingViewController"];
            
            [appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 10:
        {
            //退出
            [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:@"确定退出吗?" oneButtonTitle:@"确定" anotherButtonTitle:@"取消" clickedHandle:^(NSInteger selectedIndex) {
                
                if (selectedIndex == 0) {
                    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_loginOut parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSLog(@"%@",responseObject);
                        
                        //set cookie nil
                        [VCAFManager sharedInstance].JSESSIONID = nil;
                        
                        //go to loginCtl
                        UIStoryboard *initSB = [UIStoryboard storyboardWithName:@"Init" bundle:nil];
                        LoginViewController *loginVC = [initSB instantiateViewControllerWithIdentifier:@"LoginViewController"];
                        UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
                        SharedAppDelegate.window.rootViewController = loginNav;
                        
                        [[GlobalHandler sharedInstance] showAlertWithMsg:responseObject[@"rtMsg"]];
                    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        NSLog(@"%@",error.userInfo);
                    }];
                }
                
            }];
            
            //[appDelegate.sliderViewController closeDrawerAnimated:YES completion:nil];
        }
            break;
        default:
            break;
    }
    
    if(pushVC)
    {
        UINavigationController *nav = (UINavigationController *)appDelegate.sliderViewController.centerViewController;
        [nav pushViewController:pushVC animated:YES];

//        [appDelegate.sliderViewController setMaximumLeftDrawerWidth:160.0f animated:YES completion:^(BOOL finished) {
//            NSLog(@"11");
//        } ];
    }
    self.selectedIndexPath = indexPath;
    [tableView reloadData];
}

//-(void)caculateCacheSize{
//    //缓存size
//    NSString *cacheString;
//    long long size = [[SDImageCache sharedImageCache]  getSize];
//    if (size /1024.f /1024   < 1) {
//        cacheString = [NSString  stringWithFormat:@"%.1fKB",size /1024.f];
//    }else {
//        cacheString = [NSString  stringWithFormat:@"%.1fMB",size /1024.f/1024];
//    }
//    self.cacheSizeLabel.text = cacheString;
//}

/**
 *  清理缓存
 */
-(void)clearCache
{

}

#pragma mark - private
- (void)updateDataWithNotification
{

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

@end
