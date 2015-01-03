//
//  MobilePhoneViewController.h
//  VirtualCoin
//
//  Created by hc on 14/12/30.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCRedButton.h"

typedef NS_ENUM(NSInteger, GetMobleCodeType) {
    GetMobleCodeType_Register = 0,
    GetMobleCodeType_FindLoginPwd = 1,
    GetMobleCodeType_FindPayPwd = 2,
    GetMobleCodeType_Draw = 3
};

@interface MobilePhoneViewController : UIViewController

//data
@property(nonatomic,assign)GetMobleCodeType getCodeType;

//ui
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

@property (weak, nonatomic) IBOutlet UITextField *authCodeTextField;

@property (weak, nonatomic) IBOutlet UIButton *resendButton;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

- (IBAction)reSend:(id)sender;

- (IBAction)toSubmit:(id)sender;
@end
