//
//  UserInfoViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/23.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "UserInfoViewController.h"
#import "AppDelegate.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private
-(void)loadData {
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_userMsg parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        /*
         orderInfos = "<null>";
         rtCode = 0;
         rtMsg = "\U64cd\U4f5c\U6210\U529f";
         user =     {
             checkStatus = 1;
             mac = HYxf8VuDPNQ;
             mail = NULL;
             name = "\U6b27\U9633\U950b";
             password = "<null>";
             regDate = 1417229825000;
             ruid = 0;
             uid = 10815;
             userName = "\U6b27\U9633\U950b";
         };
         userInfo =     {
             accounts = 0;
             bank = "\U5efa\U8bbe\U94f6\U884c";
             bankCard = 6222021001116245702;
             branchName = "\U6cb3\U5317\U652f\U884c";
             cardAddress = "";
             coinNumber = "0.4268";
             credit = 50;
             frozenCoinNumber = 0;
             frozenMoney = 0;
             idCard = 411025198905010789;
             infoId = 816;
             integral = 0;
             millNum = 0;
             minge = 0;
             mobile = 18926575205;
             moneyPwd = "<null>";
             subNumber = 0;
             tempCredit = 0;
             uid = 10815;
             upgradeCoin = 0;
         };

         */
        NSDictionary *userDic = responseObject[@"user"];
        NSDictionary *userInfoDic = responseObject[@"userInfo"];
        
        //保存信息到内存
        [SharedAppDelegate.globalUser fillInfoWithUserDic:userDic userInfoDic:userInfoDic];
      
       self.userNameUL.text = userDic[@"userName"];
       self.mobileNoUL.text = userInfoDic[@"mobile"];
//       self.spreadIdUL.text = userInfoDic[@"infoId"];
       self.nameUL.text = userDic[@"name"];
       self.idCardUL.text = userInfoDic[@"idCard"];
        
       self. bankNameUL.text = userInfoDic[@"bank"];
       self.branchBankUL.text = userInfoDic[@"branchName"];
       self.carkNoUL.text = userInfoDic[@"bankCard"];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

@end
