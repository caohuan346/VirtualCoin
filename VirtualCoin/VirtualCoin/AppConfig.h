//
//  AppConfig.h
//  Qian100
//
//  Created by Happy on 14-8-28.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#ifndef TheGunners_AppConfig_h
#define TheGunners_AppConfig_h

/////////////////////////////////////////// 用户信息 ////////////////////////////////////////////
#define kUserName @"userName"

/////////////////////////////////////////// 全局通知 ////////////////////////////////////////////
//撤销委托记录
#define kNotificationKey_CancelEntrust @"kNotificationKey_CancelEntrust"
//撤销提现
#define kNotificationKey_CancelWithDraw @"kNotificationKey_CancelWithDraw"
//提现申请成功
#define kNotificationKey_DrawSuccess @"kNotificationKey_DrawSuccess"
/////////////////////////////////////////// 接口配置 ////////////////////////////////////////////
#define kHttpBaseURL @"http://183.61.146.120:8688/luckyMsg/"       //base url
//18926575205 123456

#define kHttpServer @"http://183.61.146.120:8688"

//1.登录接口
#define kHttpMethod_login @"ulogin.html"

//2.注册接口
#define kHttpMethod_register @"register.html"

//3.获取手机验证码接口
#define kHttpMethod_SendphoneCode @"SendphoneCode.html"

//4.验证码手机验证码接口
#define kHttpMethod_validatePhoneCode @"validatePhoneCode.html"

//5.初始化用户实名信息接口
#define kHttpMethod_setUserInfo @"setUserInfo.html"

//6.获取用户基本信息接口
#define kHttpMethod_userMsg @"userMsg.html"

//7.重置密码接口（找回密码）
#define kHttpMethod_resetPwd @"resetPwd.html"

//8.修改密码接口
#define kHttpMethod_modifyPwd @"modifyPwd.html"

//9.获取最新成交价格接口
#define kHttpMethod_lastestPrice @"lastestPrice.html"

//10.获取K线走势图接口
#define kHttpMethod_klineData @"klineData.html"

//11.实时交易信息
#define kHttpMethod_tranInfos @"tranInfos.html"

//12.获取最新委托卖单/买单（全网）
#define kHttpMethod_orders @"orders.html"

//13.买入/卖出虚拟币接口
#define kHttpMethod_addOrder @"addOrder.html"

//14.提现接口
#define kHttpMethod_addWithDraw @"addWithDraw.html"

//15.提现记录接口
#define kHttpMethod_getUserWithDraw @"getUserWithDraw.html"

//16.撤销提现接口
#define kHttpMethod_chanelWithDraw @"chanelWithDraw.html"

//17.获取充值记录接口
#define kHttpMethod_getRec @"getRec.html"

//18.获取网银直充订单号接口
#define kHttpMethod_onRec @"onRec.html"

//19.获取支付宝手动充值订单号接口
#define kHttpMethod_addRec @"addRec.html"

//20.获取矿机价格接口
#define kHttpMethod_millPrice @"millPrice.html"

//21.购买矿机接口
#define kHttpMethod_coinBuyMill @"coinBuyMill.html"

//22.挖矿记录查询接口
#define kHttpMethod_wkInfos @"wkInfos.html"

//23.个人委托管理记录接口
#define kHttpMethod_isNotFinishedOrders @"isNotFinishedOrders.html"

//24.撤销委托订单接口
#define kHttpMethod_chanelOrders @"chanelOrders.html"

//25.个人交易记录接口
#define kHttpMethod_tranInfosByUid @"tranInfosByUid.html"

//26查询推广记录接口
#define kHttpMethod_refInfos @"refInfos.html"

//27获取平台数据接口
#define kHttpMethod_getHeadInfos @"getHeadInfos.html"

//28获取系统公告接口
#define kHttpMethod_getPublicInfos @"getPublicInfos.html"

//29大转盘接口
#define kHttpMethod_userLuckLy @"userLuckLy.html"

//30获取大转盘中奖记录接口
#define kHttpMethod_getLuckyInfo @"getLuckyInfo.html"

//31在线签到接口
#define kHttpMethod_signIn @"signIn.html"

//32排行榜接口
#define kHttpMethod_millOrRefs @"millOrRefs.html"

//33退出接口
#define kHttpMethod_loginOut @"loginOut.html"

/////////////////////////////////////////// 界面配置 ////////////////////////////////////////////
//绿色
#define kThemeGreenColor [UIColor colorWithRed:11.0/255.0f green:112.0/255.0f blue:91.0/255.0f alpha:1]

//背景色
#define kThemeBackGroundColor [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1]
//主题红色
#define kThemeRedColor [UIColor colorWithRed:0.84 green:0.23 blue:0.29 alpha:1]
//边框颜色
#define kThemeBorderColor [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1].CGColor
//边框高亮颜色
#define kThemeBorderRedColor [UIColor colorWithRed:0.84 green:0.23 blue:0.29 alpha:1].CGColor

//红色按钮正常状态  #da4453
#define kRedButtonNormalColor [UIColor colorWithRed:0.84 green:0.23 blue:0.29 alpha:1]
//红色按钮点击状态  #c01c26
#define kRedButtonClickedColor [UIColor colorWithRed:0.72 green:0.1 blue:0.13 alpha:1]

//黄色按钮正常状态  #da4453
#define kYellowButtonNormalColor [UIColor colorWithRed:1 green:0.69 blue:0.02 alpha:1]
//黄色按钮点击状态  #c01c26
#define kYellowButtonClickedColor [UIColor colorWithRed:1 green:0.53 blue:0.02 alpha:1]

//蓝色按钮正常状态  #da4453
#define kBlueButtonNormalColor [UIColor colorWithRed:0.18 green:0.77 blue:0.84 alpha:1]
//蓝色按钮点击状态  #c01c26
#define kBlueButtonClickedColor [UIColor colorWithRed:0.32 green:0.71 blue:0.80 alpha:1]

//红色按钮失效下的颜色 #c6c6c6
#define kButtonDisabledGrayColor [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1]

//灰度中  #989898
#define kGrayFontColor [UIColor colorWithRed:0.55 green:0.55 blue:0.55 alpha:1];
//灰度高  #232323
#define kBlackFontColor [UIColor colorWithRed:0.12 green:0.12 blue:0.12 alpha:1];


#endif
