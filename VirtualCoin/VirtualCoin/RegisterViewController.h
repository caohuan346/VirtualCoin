//
//  RegisterViewController.h
//  Qian100
//
//  Created by Happy on 14-8-19.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "VCButton.h"

@protocol RegisterViewControllerDelegate <NSObject>

- (void)updateWithUsername:(NSString *)username
               AndPassword:(NSString *)password
                  WithType:(Qian100LoginType)type;

@end

@interface RegisterViewController : UIViewController

@property id<RegisterViewControllerDelegate>delegate;

//data
@property(nonatomic,copy)NSString *mobile;
@property(nonatomic,copy)NSString *shortMsgCode;

//UI

//views
@property (weak, nonatomic) IBOutlet UIView *usernameView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIView *cofirmPwdView;
@property (weak, nonatomic) IBOutlet UIView *phoneNumberView;

//left icon
@property (weak, nonatomic) IBOutlet UIImageView *usernameIcon;
@property (weak, nonatomic) IBOutlet UIImageView *pwdIcon;
@property (weak, nonatomic) IBOutlet UIImageView *confirmPwdIcon;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumIcon;

//pwd visible button
@property (weak, nonatomic) IBOutlet UIButton *pwdVisibleButton;
@property (weak, nonatomic) IBOutlet UIButton *comfirmPwdVisibleBtn;

//tip icon
@property (weak, nonatomic) IBOutlet UIImageView *confirmPwdTipIcon;
@property (weak, nonatomic) IBOutlet UIImageView *usernameTipIcon;
@property (weak, nonatomic) IBOutlet UIImageView *pwdTipIcon;
@property (weak, nonatomic) IBOutlet UIImageView *phoneNumTipIcon;

//用户名
@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;

//手机号码
@property (weak, nonatomic) IBOutlet UITextField *phoneNumTextField;

//密码
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

//确认密码
@property (weak, nonatomic) IBOutlet UITextField *cofirmTextField;

//资金密码
@property (weak, nonatomic) IBOutlet UITextField *payPasswordTextField;

//资金确认密码
@property (weak, nonatomic) IBOutlet UITextField *payCofirmTextField;

@property (weak, nonatomic) IBOutlet UITextField *refereeField;

//同意钱一百用户协议
@property (weak, nonatomic) IBOutlet UIButton *checkBox;

- (IBAction)checkBoxClick:(id)sender;

//确认注册
@property (weak, nonatomic) IBOutlet VCButton *submitButton;

- (IBAction)toSubmit:(id)sender;

//密码可见
- (IBAction)pwdVisible:(id)sender;
- (IBAction)comfirmPwdVisible:(id)sender;

@end


