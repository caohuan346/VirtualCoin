//
//  RecordSlideViewController.m
//  Qian100
//
//  Created by hc on 14-9-7.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import "TradeSlideViewController.h"
#import "SellViewController.h"

@interface TradeSlideViewController ()
{
    UIView *maskView;
}

@property(nonatomic,strong)NSMutableArray *recordCtlArray;

@end

@implementation TradeSlideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.recordCtlArray = [NSMutableArray array];
    
    self.title = @"交易中心";
    self.slideSwitchView.tabItemNormalColor = kBlackFontColor;
    self.slideSwitchView.tabItemSelectedColor = kThemeRedColor;
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"red_line_and_shadow.png"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:0.0f];
    
    //所有 回款 充值 提现 投标 推荐奖励
//    NSArray *titleArray = @[@"买入XYB",@"卖出XYB"];
//    
//    NSInteger typeCount = titleArray.count;
    
    UIStoryboard *pagerSB=[UIStoryboard storyboardWithName:@"Trade" bundle:nil];
    BuyViewController *buy = [pagerSB instantiateViewControllerWithIdentifier:@"BuyViewController"];
    [buy setTitle:@"买入XYB"];
    [self.recordCtlArray addObject:buy];
    
    SellViewController *sell = [pagerSB instantiateViewControllerWithIdentifier:@"SellViewController"];
    [sell setTitle:@"卖出XYB"];
    [self.recordCtlArray addObject:sell];
    
    [self.slideSwitchView buildUI];
}

-(void)showMaskView
{
    if(maskView == nil)
    {
        maskView = [[UIView alloc]init];
        maskView.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view insertSubview:maskView atIndex:0];
        
        NSArray *maskView_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[maskView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(maskView)];
        NSArray *maskView_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-44-[maskView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(maskView)];
        [self.view addConstraints:maskView_H];
        [self.view addConstraints:maskView_V];
    }
    [maskView setHidden:NO];
    [self.view bringSubviewToFront:maskView];
}

-(void)hideMaskView
{
    [maskView setHidden:YES];
}

#pragma mark - 滑动tab视图代理方法


- (NSUInteger)numberOfTab:(QCSlideSwitchViewChanged *)view
{
    // you can set the best you can do it ;
    return 2;
}

- (UIViewController *)slideSwitchView:(QCSlideSwitchViewChanged *)view viewOfTab:(NSUInteger)number
{
    return self.recordCtlArray[number];
}

//- (void)slideSwitchView:(QCSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
//{
//    QCViewController *drawerController = (QCViewController *)self.navigationController.mm_drawerController;
//    [drawerController panGestureCallback:panParam];
//}

- (void)slideSwitchView:(QCSlideSwitchViewChanged *)view didselectTab:(NSUInteger)number
{
    BuyViewController *vc = self.recordCtlArray[number];
    
//    [vc viewDidCurrentViewWithIndex:number];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
