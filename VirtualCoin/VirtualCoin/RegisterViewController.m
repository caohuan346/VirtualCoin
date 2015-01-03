//
//  RegisterViewController.m
//  Qian100
//
//  Created by Happy on 14-8-19.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import "RegisterViewController.h"
#import "AppDelegate.h"
#import "VCAFManager.h"
#import "NSString+Regex.h"


@interface RegisterViewController () <UITextFieldDelegate>
{
    BOOL isObeyProtocol;        //是否服从钱一百用户协议
    BOOL isPwdVisible;         //密码可见
    BOOL isComfirmPwdVisible;  //确认密码可见
    BOOL isUsernameExist;      //用户名是否存在
    BOOL isMobileExist;        //手机是否存在
    BOOL isMobilePhoneChecked;  //推荐人选择手机号
    BOOL isMemberNameChecked;   //推荐人选会员名
    NSTimer *timer;
    BOOL isResended;
    int _count;

}
@end

@implementation RegisterViewController

#pragma mark - life circle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加点击手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tap];
    
    //默认服从协议
    isObeyProtocol = YES;
    
    //代理
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.cofirmTextField.delegate = self;
    self.phoneNumTextField.delegate = self;
    
    isMemberNameChecked = YES;
    isMobilePhoneChecked = NO;

}


#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.usernameTextField)
    {
        [self.view bringSubviewToFront:self.usernameView];
        self.usernameIcon.image = [UIImage imageNamed:@"reg_icon_username_tap"];
        self.usernameTipIcon.hidden = YES;
        
    } else if (textField == self.passwordTextField)
    {
        [self.view bringSubviewToFront:self.pwdView];
        self.pwdIcon.image = [UIImage imageNamed:@"reg_icon_pwd_tap"];
        self.pwdTipIcon.hidden = YES;
    } else if (textField == self.cofirmTextField)
    {
        [self.view bringSubviewToFront:self.cofirmPwdView];
        self.confirmPwdIcon.image = [UIImage imageNamed:@"reg_icon_pwd_tap"];
        self.confirmPwdTipIcon.hidden = YES;
    } else if (textField == self.phoneNumTextField)
    {
        [self.view bringSubviewToFront:self.phoneNumberView];
        self.phoneNumIcon.image = [UIImage imageNamed:@"reg_icon_phone_tap"];
        self.phoneNumTipIcon.hidden = YES;
    }

}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.usernameTextField)
    {
        self.usernameIcon.image = [UIImage imageNamed:@"reg_icon_username"];
    } else if (textField == self.passwordTextField)
    {
        self.pwdIcon.image = [UIImage imageNamed:@"reg_icon_pwd"];
        //检测是否是有效的密码
        if (textField.text.length != 0 && [textField.text isValidatePassword]) {
            self.pwdTipIcon.image = [UIImage imageNamed:@"common_icon_ok"];
            self.pwdTipIcon.hidden = NO;
        }else if (textField.text.length != 0 && ![textField.text isValidatePassword])
        {
            
            [[GlobalHandler sharedInstance] showAlertWithMsg:@"密码必须为6—16位，而且只能包含字符、数字和 下划线"];
        }
    } else if (textField == self.cofirmTextField)
    {
        self.confirmPwdIcon.image = [UIImage imageNamed:@"reg_icon_pwd"];
        //检测两次密码是否一致
        if (textField.text.length != 0 && [textField.text isEqualToString:self.passwordTextField.text]) {
            self.confirmPwdTipIcon.image = [UIImage imageNamed:@"common_icon_ok"];
            self.confirmPwdTipIcon.hidden = NO;
        }else if (textField.text.length != 0)
        {
            
            [[GlobalHandler sharedInstance] showAlertWithMsg:@"两次密码不一致"];
        }
    } else if (textField == self.phoneNumTextField)
    {
        self.phoneNumIcon.image = [UIImage imageNamed:@"reg_icon_phone"];
    }

}


#pragma mark - private Methods

- (void)tapView
{
    [self.usernameTextField resignFirstResponder];
    [self.phoneNumTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.cofirmTextField resignFirstResponder];
}


- (void)updateUsernameTextField
{
    if (isUsernameExist == NO && self.usernameTextField.text.length != 0) {
        self.usernameTipIcon.image = [UIImage imageNamed:@"common_icon_ok"];
        self.usernameTipIcon.hidden = NO;
    } else if (isUsernameExist == YES && self.usernameTextField.text.length != 0)
    {
        
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"该用户名已存在"];
    }
}

- (void)updateMobilePhoneTextField
{
    if (self.phoneNumTextField.text.length != 0 && isMobileExist == NO && [self.phoneNumTextField.text isElevenDigitNum]) {
        self.phoneNumTipIcon.image = [UIImage imageNamed:@"common_icon_ok"];
        self.phoneNumTipIcon.hidden = NO;
    } else if (self.phoneNumTextField.text.length != 0 && ![self.phoneNumTextField.text isElevenDigitNum] )
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"无效的手机号码"];
    } else if(self.phoneNumTextField.text.length != 0 && isMobileExist == YES)
    {
         [[GlobalHandler sharedInstance] showAlertWithMsg:@"该手机已存在"];
    }

}

#pragma mark - Navigation


- (IBAction)checkBoxClick:(id)sender {
    if (isObeyProtocol) {
        isObeyProtocol = !isObeyProtocol;
        [self.checkBox setBackgroundImage:[UIImage imageNamed:@"checkbox"] forState:UIControlStateNormal];
        [self.submitButton setEnabled:NO];
        [self.submitButton setBackgroundColor:[UIColor lightGrayColor]];
    } else
    {
        isObeyProtocol = !isObeyProtocol;
        [self.checkBox setBackgroundImage:[UIImage imageNamed:@"checkbox_tap"] forState:UIControlStateNormal];
        [self.submitButton setEnabled:YES];
        self.submitButton.backgroundColor = kThemeRedColor;
    }
}

- (IBAction)pwdVisible:(id)sender {
    if (!isPwdVisible) {
        isPwdVisible = !isPwdVisible;
        
        [self.pwdVisibleButton setBackgroundImage:[UIImage imageNamed:@"login_icon_visible_tap"] forState:UIControlStateNormal];
        
        self.passwordTextField.secureTextEntry = NO;
    } else
    {
        [self.pwdVisibleButton setBackgroundImage:[UIImage imageNamed:@"login_icon_visible"] forState:UIControlStateNormal];
        isPwdVisible = !isPwdVisible;
        self.passwordTextField.secureTextEntry = YES;
    }

}

- (IBAction)comfirmPwdVisible:(id)sender {
    if (!isComfirmPwdVisible) {
        isComfirmPwdVisible = !isComfirmPwdVisible;
        
        [self.comfirmPwdVisibleBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_visible_tap"] forState:UIControlStateNormal];
        
        self.cofirmTextField.secureTextEntry = NO;
    } else
    {
        [self.comfirmPwdVisibleBtn setBackgroundImage:[UIImage imageNamed:@"login_icon_visible"] forState:UIControlStateNormal];
        isComfirmPwdVisible = !isComfirmPwdVisible;
        self.cofirmTextField.secureTextEntry = YES;
    }
}


//请求开始：显示
- (void)displayActivityView
{
    [GlobalHandler showActivityViewForView:self.view];
}

//成功或失败，消失
- (void)dismissActivityView
{
    [GlobalHandler dismissActivityViewAnimated:YES];
}
#pragma mark - action
- (IBAction)toSubmit:(id)sender {
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *confirmPassword = self.cofirmTextField.text;
    
    NSString *payPassword = self.payPasswordTextField.text;
    NSString *payConfirmPassword = self.payCofirmTextField.text;
    NSString *referee = self.refereeField.text;
    
    if (username.length == 0) {
        
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"请输入用户名"];
        
    }else if (![password isValidatePassword])
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"请输入正确的密码:6—16位，只能包含字符、数字和 下划线"];
        
    } else if (![confirmPassword isEqualToString:password])
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"两次密码不一致"];
        
    }else if (![payPassword isValidatePassword])
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"请输入正确的资金密码:6—16位，只能包含字符、数字和 下划线"];
        
    } else if (![payConfirmPassword isEqualToString:payPassword])
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"两次密码不一致"];
        
    }
    else
    {
        //提交注册
        NSDictionary *paras = @{
                                @"UserName":username,
                                @"Mobile":self.mobile,
                                @"PassWord":password,
                                @"PassWord2":payPassword,
                                @"RegisterId":referee,
                                @"code":self.shortMsgCode,
                                @"MAC":SharedAppDelegate.globalUser.openUDID,
                                };
        [self displayActivityView];
        [[VCAFManager sharedInstance ] postHttpMethod:kHttpMethod_register parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self dismissActivityView];
            if ([responseObject[@"rtCode"] integerValue] == 0) {
                NSLog(@"%@",responseObject);
                
                if ([self.delegate respondsToSelector:@selector(updateWithUsername:AndPassword:WithType:)]) {
                    [self.delegate updateWithUsername:username AndPassword:password WithType:Qian100LoginType_AfterRegister];
                }
                
                [[GlobalHandler sharedInstance] showAlertWithMsg:@"注册成功!"];
                
                
            } else
            {
                
            }
            [[GlobalHandler sharedInstance] showAlertWithMsg:responseObject[@"rtMsg"]];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self dismissActivityView];
            NSLog(@"%@",error.description);
        }];
    }
}
@end
