//
//  MobilePhoneViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/30.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "MobilePhoneViewController.h"
#import "RegisterViewController.h"
#import "NSString+Regex.h"
#import "ResetPwdViewController.h"

@interface MobilePhoneViewController ()
{
    NSTimer *timer;
    BOOL isResended;
    int count;
}
@end

@implementation MobilePhoneViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.resendButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    count = 61;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)reSend:(id)sender {
    if (self.phoneNumTextField.text.length == 0) {
        
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"请输入手机号码"];
        
    }else
    {
        if (!isResended) {
            isResended = !isResended;
            [self getAuthCodeFromSever];
            self.resendButton.enabled = NO;
            timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countOneMinute) userInfo:nil repeats:YES];
        } else
        {
            [self getAuthCodeFromSever];
        }
    }
    
}

- (void)countOneMinute
{
    count --;
    [self.resendButton setEnabled:NO];
    NSMutableAttributedString *atributeTitle = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"重新发送%d秒",count]];
    NSRange range;
    if (count < 10) {
        range = NSMakeRange(4, 1);
    }else
    {
        range = NSMakeRange(4, 2);
    }
    [atributeTitle addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    [self.resendButton setAttributedTitle:atributeTitle forState:UIControlStateDisabled];
    if (count == 0) {
        
        self.resendButton.enabled = YES;
        [self.resendButton setTitle:@"重新发送" forState:UIControlStateNormal];
        isResended = !isResended;
        count = 61;
        [timer invalidate];
        
    }
    
}

#pragma mark - request

- (void)getAuthCodeFromSever
{
    NSString *mobileNumber = self.phoneNumTextField.text;
    
    NSDictionary *paras = @{@"type":@(self.getCodeType),
                            @"Mobile":mobileNumber};
    
    [self displayActivityView];
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_SendphoneCode parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self dismissActivityView];
        if ([responseObject[@"rtCode"] intValue] == 0) {
            
        }else{
            self.resendButton.enabled = YES;
            [self.resendButton setTitle:@"重新发送" forState:UIControlStateNormal];
            isResended = !isResended;
            count = 61;
            [timer invalidate];
        }
        
        [[GlobalHandler sharedInstance] showAlertWithMsg:responseObject[@"rtMsg"]];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self dismissActivityView];
        
    }];
}



- (IBAction)toSubmit:(id)sender {
    if (self.phoneNumTextField.text.length == 0) {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"请输入手机号码"];
        
    } else if (![self.phoneNumTextField.text isElevenDigitNum])
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"无效的手机号码"];
        
    } else if (self.authCodeTextField.text.length == 0)
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"请输入验证码"];
        
    } else
    {
        NSString *mobile = self.phoneNumTextField.text;
        NSString *authCode = self.authCodeTextField.text;
        
        NSDictionary *paras = @{@"type":@(self.getCodeType),
                                @"Mobile":mobile,
                                @"code":authCode
                                };
        [self displayActivityView];
        
        [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_validatePhoneCode parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [self dismissActivityView];
            if ([responseObject[@"rtCode"] intValue] == 0) {
                //注册
                if (self.getCodeType == GetMobleCodeType_Register) {
                    [self performSegueWithIdentifier:@"register" sender:self];
                }
                //忘记密码
                else if(self.getCodeType == GetMobleCodeType_FindLoginPwd){
                    [self performSegueWithIdentifier:@"resetLoginPwd" sender:self];
                }
                
            }
             [[GlobalHandler sharedInstance] showAlertWithMsg:responseObject[@"rtMsg"]];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self dismissActivityView];
            
        }];
    }
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //注册
    if ([segue.identifier isEqualToString:@"register"]) {
        RegisterViewController *registerVC = segue.destinationViewController;
        registerVC.mobile = self.phoneNumTextField.text;
        registerVC.shortMsgCode = self.authCodeTextField.text;
    }
    //重置密码
    else if ([segue.identifier isEqualToString:@"resetLoginPwd"]) {
        ResetPwdViewController *resetPwd = segue.destinationViewController;
        resetPwd.mobile = self.phoneNumTextField.text;
        resetPwd.code = self.authCodeTextField.text;
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

@end
