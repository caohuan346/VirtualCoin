//
//  PassportHandler.h
//  zsd-templet-project
//
//  Created by Happy on 14-8-13.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  点击按钮的回调
 *
 *  @param selectIndex 点击的索引值
 */
typedef void(^AlertViewCompleteHandle)(NSInteger selectedIndex);

@interface GlobalHandler : NSObject<UIAlertViewDelegate>

@property (nonatomic,copy) AlertViewCompleteHandle completeHandle;

//singleton
+ (GlobalHandler *) sharedInstance;

#pragma mark - alertView

- (void)showAlertWithMsg:(NSString *)msg;

/**
 *  简单alert
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okButtonTitle clickedHandle:(AlertViewCompleteHandle)clickedHandle;

/**
 * 多按钮alert
 */
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message oneButtonTitle:(NSString *)oneTitle anotherButtonTitle:(NSString *)anotherButtonTitle clickedHandle:(AlertViewCompleteHandle)clickedHandle;

#pragma mark - ProgressHUD
/**
 *  showActivity
 */
+ (void) showActivityViewForView:(UIView *)view;

/**
 *  dismissActivityView
 */
+ (void)dismissActivityViewAnimated:(BOOL)animated;

#pragma mark - number format
/**
 *  number格式化 ->  500,000,000.00
 *
 *  @param dbValue 需要被格式化的值
 *
 *  @return 500,000,000.00
 */
+ (NSString*)formateStringFromDouble:(double)dbValue DEPRECATED(2_01);

/**
 *  number格式化 ->  500000000
 *
 *  @param dbValue 需要被格式化的值
 *
 *  @return 500,000,000
 */
- (NSString*)handleStringNoDotFromCurrency:(NSString *)currencyStr;

/**
 *  格式化金额，含货币符号
 *
 *  @param dbValue 50000.00
 *
 *  @return ￥50,000.00
 */
- (NSString *)handleStringFromCurrencyDouble:(double)dbValue;

/**
 *  格式化金额，含货币符号
 *
 *  @param currencyStr 50000.00
 *
 *  @return ￥50,000.00
 */
- (NSString *)handleStringFromCurrencyString:(NSString *)currencyStr;

/**
 *  格式化金额，无符号
 *
 *  @param dbValue 50000.00
 *
 *  @return 50,000.00
 */
- (NSString *)handleStringWithoutSymbolFromCurrencyDouble:(double)dbValue;

/**
 *  格式化金额，无符号
 *
 *  @param currencyStr 50000.00
 *
 *  @return 50,000.00
 */
- (NSString *)handleStringWithoutSymbolFromCurrencyString:(NSString *)currencyStr;

- (NSString *)handleChineseUpperCaseStringFromCurrencyDouble:(double)dbValue;

//四舍五入
- (NSString *) decimalwithFloatV:(float)floatV afterPoint:(int)position;
#pragma mark - date format

/**
 *  根据当前时间确定是早上还是下午
 *
 *  @return NSString
 */
+ (NSString *)morningOrAfternoon;

//2015-01-02 19:37:57
-(NSString *)getFullDateStr:(NSString *)timestampStr;
//获取时间：2014-12-28
-(NSString *)getDateStr:(NSString *)timestampStr;
//获取时间：17:05:45
-(NSString *)getTimeStr:(NSString *)timestampStr;

@end
