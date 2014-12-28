//
//  PassportHandler.m
//  zsd-templet-project
//
//  Created by Happy on 14-8-13.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import "GlobalHandler.h"
#import "DejalActivityView.h"

@interface GlobalHandler ()

@property(strong) NSNumberFormatter *numberFormatter;
@property(strong) NSDateFormatter *dateFormatter;

@end

@implementation GlobalHandler

//singleton
+ (GlobalHandler *)sharedInstance {
    static GlobalHandler *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{ \
        sharedInstance = [[self alloc] init];
        
        sharedInstance.numberFormatter = [[NSNumberFormatter alloc] init];
        [sharedInstance.numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
        NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        [sharedInstance.numberFormatter setLocale:locale];
        
        sharedInstance.dateFormatter = [[NSDateFormatter alloc] init];
        
    });
    return sharedInstance;
}

#pragma mark - AlertView
//单按钮
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message okButtonTitle:(NSString *)okButtonTitle clickedHandle:(AlertViewCompleteHandle)clickedHandle
{
    self.completeHandle = clickedHandle;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:okButtonTitle otherButtonTitles:nil, nil];
    alert.delegate = self;
    [alert show];
}

//两按钮
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message oneButtonTitle:(NSString *)oneTitle anotherButtonTitle:(NSString *)anotherButtonTitle clickedHandle:(AlertViewCompleteHandle)clickedHandle
{
    self.completeHandle = clickedHandle;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:oneTitle otherButtonTitles:anotherButtonTitle, nil];
     alert.delegate = self;
    [alert show];
}

#pragma mark - alertView delegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    self.completeHandle(buttonIndex);
}

#pragma mark - ProgressHUD
+ (void)showActivityViewForView:(UIView *)view
{
    [DejalBezelActivityView activityViewForView:view withLabel:nil];
}

+ (void)dismissActivityViewAnimated:(BOOL)animated
{
    [DejalBezelActivityView removeViewAnimated:YES];
}

#pragma mark - number format
+ (NSString*)formateStringFromDouble:(double)dbValue 
{
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *formattedNumberString = [numberFormatter stringFromNumber:[NSNumber numberWithDouble:dbValue]];
    return formattedNumberString;
}

- (NSString*)handleStringNoDotFromCurrency:(NSString *)currencyStr{
    [self.numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    return [self.numberFormatter stringFromNumber:[NSNumber numberWithDouble:currencyStr.doubleValue]];
}

- (NSString *)handleStringFromCurrencyDouble:(double)dbValue
{
    [self.numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    return [self.numberFormatter stringFromNumber:[NSNumber numberWithDouble:dbValue]];
}

- (NSString *)handleStringFromCurrencyString:(NSString *)currencyStr
{
    return [self handleStringFromCurrencyDouble:[currencyStr doubleValue]];
}

- (NSString *)handleStringWithoutSymbolFromCurrencyDouble:(double)dbValue
{
    NSString *str = [self handleStringFromCurrencyDouble:dbValue];
    return [str stringByReplacingOccurrencesOfString:@"￥" withString:@""];
}

- (NSString *)handleStringWithoutSymbolFromCurrencyString:(NSString *)currencyStr
{
    return [self handleStringWithoutSymbolFromCurrencyDouble:[currencyStr doubleValue]];
}

- (NSString *)handleChineseUpperCaseStringFromCurrencyDouble:(double)dbValue
{
    [self.numberFormatter setNumberStyle:NSNumberFormatterSpellOutStyle];
    NSString *fmtStr = [self.numberFormatter stringFromNumber:[NSNumber numberWithDouble:dbValue]];
    return [NSString stringWithFormat:@"%@圆",fmtStr];
}
#pragma mark - date formate

+ (NSString *)morningOrAfternoon
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now = [NSDate date];;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    comps = [calendar components:unitFlags fromDate:now];
    NSUInteger hour = [comps hour];
    if (hour > 0 && hour <= 12) {
        return @"上午好！";
    }else
    {
        return @"下午好！";
    }
}

//获取时间：2014-12-28
-(NSString *)getDateStr:(NSString *)timestampStr{
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:[timestampStr doubleValue] / 1000];
    [self.dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [self.dateFormatter stringFromDate:date];
}

//获取时间：17:05:45
-(NSString *)getTimeStr:(NSString *)timestampStr{
    NSDate *date  = [NSDate dateWithTimeIntervalSince1970:[timestampStr doubleValue] / 1000];
    [self.dateFormatter setDateFormat:@"HH:mm:ss"];
    return [self.dateFormatter stringFromDate:date];
}

@end
