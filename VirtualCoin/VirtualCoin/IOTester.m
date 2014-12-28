//
//  IOTester.m
//  VirtualCoin
//
//  Created by hc on 14/12/21.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "IOTester.h"
#import "DESUtils.h"
#import "DESede.h"

@implementation IOTester

////18926575205 123456
-(void) test{
    
    /* 加密字符串

    public static final   byte[] keyBytes = {0x21, 0x12, 0x4F, 0x58, (byte)0x88, 0x10, 0x40, 0x28
        , 0x28, 0x25, 0x79, 0x51, (byte)0xCB, (byte)0xDD, 0x55, 0x66
        , 0x78, 0x29, 0x74, (byte)0x98, 0x30, 0x40, 0x36, (byte)0xE2};    //24字节的密钥
  
     冰禾IT——理想国注册传过来的

    public static final String EN_CODE="123liyan_glaozh.iyuanpe#ngtao987";
     */
    
    //1.登录接口     kHttpMethod_login @"login"
//    NSString *desMAC = [DESUtils encryptUseDES:@"aaaaa" key:@"DES"];
    /*
    Byte byte[] = {0x21, 0x12, 0x4F, 0x58, 0x88, 0x10, 0x40, 0x28
        , 0x28, 0x25, 0x79, 0x51, 0xCB, 0xDD, 0x55, 0x66
        , 0x78, 0x29, 0x74, 0x98, 0x30, 0x40, 0x36, 0xE2};
    
    NSData *adata = [[NSData alloc] initWithBytes:byte length:24];
    
    NSString *en_code = @"123liyan_glaozh.iyuanpe#ngtao987";
    
    NSString *enyptCode = [NSString stringWithFormat:@"%@%@",en_code,@"HYxf8VuDPNQ="];
    
    //Byte数组－>16进制数
    Byte *bytes = (Byte *)[adata bytes];
    NSString *hexStr=@"";
    for(int i=0;i<[adata length];i++)
    {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
        if([newHexStr length]==1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    NSLog(@"bytes 的16进制数为:%@",hexStr);
    
    NSString *desedeMac = [DESede TripleDES:enyptCode encryptOrDecrypt:kCCEncrypt encryptOrDecryptKey:hexStr];
    
    NSString *desedeMac2 = [DESede TripleDES:desedeMac encryptOrDecrypt:kCCDecrypt encryptOrDecryptKey:hexStr];
    */
    
#warning mark - msg
    //mac：CE3647E513EA8E9B63A8213392E699CC149AC54C74D0CE2EB4471F687F98EC7B5D544AE96C97303A766E216E0D741C98
    NSDictionary *loginDic = @{@"Mobile":@"18926575205",@"PassWord":@"123456",@"MAC":@"CE3647E513EA8E9B63A8213392E699CC149AC54C74D0CE2EB4471F687F98EC7B5D544AE96C97303A766E216E0D741C98"};
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_login parameters:loginDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        //设置cookie
        NSString *cookieString = [[operation.response allHeaderFields] valueForKey:@"Set-Cookie"];
        NSArray *array = [cookieString componentsSeparatedByString:@";"];
        [VCAFManager sharedInstance].JSESSIONID = array[0];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:responseObject[@"rtMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"%@",error.userInfo);
    }];
    
    
    //2.注册接口     kHttpMethod_register @"register"
    /*
     NSDictionary *registerDic = @{};
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_register parameters:registerDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
     */
    //3.获取手机验证码接口     kHttpMethod_SendphoneCode @"SendphoneCode"
    
    //4.验证码手机验证码接口     kHttpMethod_validatePhoneCode @"validatePhoneCode"
    
    //5.初始化用户实名信息接口     kHttpMethod_setUserInfo @"setUserInfo"
    
    //6.获取用户基本信息接口     kHttpMethod_userMsg @"userMsg"
    
//    NSDictionary *userMsgDic = @{@"Mobile":@"18926575205",@"PassWord":@"123456"};
//    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_userMsg parameters:userMsgDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error.userInfo);
//    }];
    
    
    //7.重置密码接口（找回密码）     kHttpMethod_resetPwd @"resetPwd"
    
    //8.修改密码接口     kHttpMethod_modifyPwd @"modifyPwd"
    
    //9.获取最新成交价格接口    kHttpMethod_lastestPrice @"lastestPrice"
//    NSDictionary *loginDic = @{@"Mobile":@"18926575205",@"PassWord":@"123456"};
//    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_lastestPrice parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@",responseObject);
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",error.userInfo);
//    }];
    
    //10.获取K线走势图接口     kHttpMethod_timerCount @"timerCount"
    
    //11.实时交易信息     kHttpMethod_tranInfos @"tranInfos"
    
    //12.获取最新委托卖单/买单（全网）     kHttpMethod_orders @"orders"
    
    //13.买入/卖出虚拟币接口     kHttpMethod_addOrder @"addOrder"
    
    //14.提现接口     kHttpMethod_addWithDraw @"addWithDraw"
    
    //15.提现记录接口    kHttpMethod_getUserWithDraw @"getUserWithDraw"
    
    //16.撤销提现接口     kHttpMethod_chanelWithDraw @"chanelWithDraw"
    
    //17.获取充值记录接口     kHttpMethod_getRec @"getRec"
    
    //18.获取网银直充订单号接口     kHttpMethod_onRec @"onRec"
    
    //19.获取支付宝手动充值订单号接口     kHttpMethod_addRec @"addRec"
    
    //20.获取矿机价格接口     kHttpMethod_millPrice @"millPrice"
    
    //21.购买矿机接口    kHttpMethod_coinBuyMill @"coinBuyMill"
    
    //22.挖矿记录查询接口     kHttpMethod_wkInfos @"wkInfos"
    
    //23.个人委托管理记录接口    kHttpMethod_isNotFinishedOrders @"isNotFinishedOrders"
    
    //24.撤销委托订单接口    kHttpMethod_chanelOrders @"chanelOrders"
    
    //25.个人交易记录接口    kHttpMethod_tranInfosByUid @"tranInfosByUid"
    
    //26查询推广记录接口    kHttpMethod_refInfos @"refInfos"
    
    //27获取平台数据接口    kHttpMethod_getHeadInfos @"getHeadInfos"
    
    //28获取系统公告接口     kHttpMethod_getPublicInfos @"getPublicInfos"
    
    //29大转盘接口     kHttpMethod_userLuckLy @"userLuckLy"
    
    //30获取大转盘中奖记录接口    kHttpMethod_getLuckyInfo @"getLuckyInfo"
    
    //31在线签到接口    kHttpMethod_signIn @"signIn"
    
    //32排行榜接口    kHttpMethod_millOrRefs @"millOrRefs"
    
    //33退出接口    kHttpMethod_loginOut @"loginOut"
}

@end
