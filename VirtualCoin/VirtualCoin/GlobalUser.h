//
//  GlobalUser.h
//  VirtualCoin
//
//  Created by hc on 14/12/21.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalUser : NSObject

@property (nonatomic,copy) NSString *userId;//用户id

@property (nonatomic,copy) NSString *realName;//真实姓名

@property (nonatomic,copy) NSString *userName;//name【姓名】

@property (nonatomic,copy) NSString *password;//密码

@property (nonatomic,copy) NSString *idCard;//idCard【身份证】

@property (nonatomic,copy) NSString *mobile;//手机号

@property (nonatomic,copy) NSString *bank;//参数3 bank【银行】

@property (nonatomic,copy) NSString *bankBranch;//参数4 bankBranch【支行】

@property (nonatomic,copy) NSString *bankCardNo;// 参数5 cardNo【卡号】

//userInfo下的
@property (nonatomic,copy) NSString *accounts;//accounts 可用人民币
@property (nonatomic,copy) NSString *coinNumber;//coinNumber 可用虚拟币
@property (nonatomic,copy) NSString *millNum;// millNum 矿机数
@property (nonatomic,copy) NSString *frozenMoney;//frozenMoney 冻结RMB
@property (nonatomic,copy) NSString *frozenCoinNumber;//frozenCoinNumber 冻结虚拟币
@property (nonatomic,copy) NSString *credit;//credit 算力


//other
@property(nonatomic,copy)NSString *openUDID;

//method
-(void)fillInfoWithUserDic:(NSDictionary *)userDic userInfoDic:(NSDictionary *)userInfoDic;

-(void)fillInfoWithInfoDic:(NSDictionary *)infoDic;

@end
