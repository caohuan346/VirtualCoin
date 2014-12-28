//
//  DrawViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/11.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "DrawViewController.h"
#import "MJRefresh.h"

@interface DrawViewController ()

@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initExistData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
-(void)initExistData{
    /*
     参数1 wdMoney【提现金额】
     参数2 wdBankCard【卡号】
     参数3 wdName【姓名】
     参数4 branchBank【支行名称】
     参数5 bank【所属银行】
     参数6 wdDesc【提现备注】
     参数7 tradePwd【提现密码】

    @property (weak, nonatomic) IBOutlet UILabel *bankUL;
    @property (weak, nonatomic) IBOutlet UILabel *branchBankUL;
    @property (weak, nonatomic) IBOutlet UILabel *wdNameUL;
    @property (weak, nonatomic) IBOutlet UILabel *wdBankCardUL;
    
    @property (weak, nonatomic) IBOutlet UITextField *wdMoneyTF;
    
    @property (weak, nonatomic) IBOutlet UITextField *tradePwd;
    
    //display part
    @property (weak, nonatomic) IBOutlet UILabel *drawAmountUL;
    @property (weak, nonatomic) IBOutlet UILabel *feesUL;
    @property (weak, nonatomic) IBOutlet UILabel *actualDrawUL;
     
     @property (nonatomic,copy) NSString *userId;//用户id
     @property (nonatomic,copy) NSString *realName;//真实姓名
     @property (nonatomic,copy) NSString *userName;//name【姓名】
     @property (nonatomic,copy) NSString *password;//密码
     @property (nonatomic,copy) NSString *idCard;//idCard【身份证】
     @property (nonatomic,copy) NSString *mobile;//手机号
     @property (nonatomic,copy) NSString *bank;//参数3 bank【银行】
     @property (nonatomic,copy) NSString *bankBranch;//参数4 bankBranch【支行】
     @property (nonatomic,copy) NSString *bankCardNo;// 参数5 cardNo【卡号】
    */
   self.bankUL.text = SharedAppDelegate.globalUser.bank;
   self.branchBankUL.text = SharedAppDelegate.globalUser.bankBranch;
   self.wdNameUL.text = SharedAppDelegate.globalUser.realName;
   self.wdBankCardUL.text = SharedAppDelegate.globalUser.bankCardNo;
   
}

#pragma mark - action
- (IBAction)draw:(id)sender {
    
    /*
     参数1 wdMoney【提现金额】
     参数2 wdBankCard【卡号】
     参数3 wdName【姓名】
     参数4 branchBank【支行名称】
     参数5 bank【所属银行】
     参数6 wdDesc【提现备注】
     参数7 tradePwd【提现密码】
     
     @property (weak, nonatomic) IBOutlet UILabel *bankUL;
     @property (weak, nonatomic) IBOutlet UILabel *branchBankUL;
     @property (weak, nonatomic) IBOutlet UILabel *wdNameUL;
     @property (weak, nonatomic) IBOutlet UILabel *wdBankCardUL;
     
     @property (weak, nonatomic) IBOutlet UITextField *wdMoneyTF;
     
     @property (weak, nonatomic) IBOutlet UITextField *tradePwd;
     
     //display part
     @property (weak, nonatomic) IBOutlet UILabel *drawAmountUL;
     @property (weak, nonatomic) IBOutlet UILabel *feesUL;
     @property (weak, nonatomic) IBOutlet UILabel *actualDrawUL;
     */
    
    NSDictionary *param = @{@"wdMoney":self.wdMoneyTF.text,
                            @"wdBankCard":SharedAppDelegate.globalUser.bankCardNo,
                            @"wdName":SharedAppDelegate.globalUser.realName,
                            @"branchBank":SharedAppDelegate.globalUser.bankBranch,
                            @"bank":SharedAppDelegate.globalUser.bank,
                            @"wdDesc":@"我要提现",
                            @"tradePwd":self.tradePwd.text};
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_addWithDraw parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        //更新用户信息
        //[SharedAppDelegate.globalUser fillInfoWithInfoDic:responseObject];
        if([responseObject[@"rtCode"] intValue] == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationKey_DrawSuccess object:nil];
        }
        [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:responseObject[@"rtMsg"]okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}
@end
