//
//  GlobalUser.m
//  VirtualCoin
//
//  Created by hc on 14/12/21.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "GlobalUser.h"

@implementation GlobalUser
/*
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

-(void)fillInfoWithUserDic:(NSDictionary *)userDic userInfoDic:(NSDictionary *)userInfoDic{
    self.userId = [NSString stringWithFormat:@"%@",userDic[@"uid"]];//;//用户id
    
    self.realName = [NSString stringWithFormat:@"%@",userDic[@"name"]];//;//真实姓名
    
    self.userName = [NSString stringWithFormat:@"%@",userDic[@"userName"]];//;//name【姓名】
    
//    self.password;//密码
    
    //userInfo下的
    self.idCard = [NSString stringWithFormat:@"%@",userInfoDic[@"idCard"]];//;//idCard【身份证】
    self.mobile = [NSString stringWithFormat:@"%@",userInfoDic[@"mobile"]];//;//手机号
    self.bank = [NSString stringWithFormat:@"%@",userInfoDic[@"bank"]];//;//参数3 bank【银行】
    self.bankBranch =[NSString stringWithFormat:@"%@",userInfoDic[@"branchName"]];// ;//参数4 bankBranch【支行】
    self.bankCardNo =[NSString stringWithFormat:@"%@",userInfoDic[@"bankCard"]];// ;// 参数5 cardNo【卡号】
    
    self.accounts = [NSString stringWithFormat:@"%@",userInfoDic[@"accounts"]];//;//accounts 可用人民币
    self.coinNumber = [NSString stringWithFormat:@"%@",userInfoDic[@"coinNumber"]];//;//coinNumber 可用虚拟币
    self.millNum = [NSString stringWithFormat:@"%@",userInfoDic[@"millNum"]];//;// millNum 矿机数
    self.frozenMoney = [NSString stringWithFormat:@"%@",userInfoDic[@"frozenMoney"]];//;//frozenMoney 冻结RMB
    self.frozenCoinNumber = [NSString stringWithFormat:@"%@",userInfoDic[@"frozenCoinNumber"]];//;//frozenCoinNumber 冻结虚拟币
    self.credit = [NSString stringWithFormat:@"%@",userInfoDic[@"credit"]];//;//credit 算力
}

-(void)fillInfoWithInfoDic:(NSDictionary *)infoDic{
    [self fillInfoWithUserDic:infoDic[@"user"] userInfoDic:infoDic[@"userInfo"]];
}
@end
