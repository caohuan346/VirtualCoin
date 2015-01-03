//
//  LoginViewController.h
//  Qian100
//
//  Created by Happy on 14-8-19.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, Qian100LoginType) {
    Qian100LoginType_Normal = 1,
    Qian100LoginType_ForgetGestureCode,
    Qian100LoginType_FirstLogin,
    Qian100LoginType_AfterRegister,
    Qian100LoginType_AfterRegisterCancelGestureLock,
    Qian100LoginType_ChagePwd
};

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

//账号
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

//注册
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

//登陆
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

//忘记密码
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;

@property (weak, nonatomic) IBOutlet UIButton *visibleButton;

@property (weak, nonatomic) IBOutlet UIImageView *usernameIcon;
@property (weak, nonatomic) IBOutlet UIImageView *passwordIcon;

@property (nonatomic) NSInteger selectIndex;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

- (IBAction)cancelClick:(id)sender;
- (IBAction)loginClick:(id)sender;

- (IBAction)pwdVisibleClick:(id)sender;


- (IBAction)toRegister:(id)sender;
- (IBAction)toResetPwd:(id)sender;
@end
