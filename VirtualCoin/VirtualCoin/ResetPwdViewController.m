//
//  ResetPwdViewController.m
//  VirtlCoin
//
//  Created by hc on 15/1/2.
//  Copyright (c) 2015年 happy. All rights reserved.
//

#import "ResetPwdViewController.h"
#import "NSString+Regex.h"

@interface ResetPwdViewController ()

@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action
- (IBAction)submit:(id)sender {

    NSString *password = self.myNewPwdTF.text;
    NSString *confirmPassword = self.confermPwdTF.text;
    
   if (![password isValidatePassword])
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"请输入正确的密码:6—16位，只能包含字符、数字和 下划线"];
        
    } else if (![confirmPassword isEqualToString:password])
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"两次密码不一致"];
        
    }
    else
    {
        /*
         参数1 Mobile【手机号】
         参数2 code【验证码】
         参数3 type【类型】（0登录密码，1资金密码）
         参数4 newPwd【密码】
         
         */
        //提交注册
        NSDictionary *paras = @{
                                @"Mobile":self.mobile,
                                @"code":self.code   ,
                                @"type":@0,
                                @"newPwd":password
                                };
        [GlobalHandler showActivityViewForView:self.view];
        [[VCAFManager sharedInstance ] postHttpMethod:kHttpMethod_resetPwd parameters:paras success:^(AFHTTPRequestOperation *operation, id responseObject) {
            [GlobalHandler dismissActivityViewAnimated:YES];
            
            if ([responseObject[@"rtCode"] integerValue] == 0) {
                NSLog(@"%@",responseObject);
                
                [[GlobalHandler sharedInstance] showAlertWithMsg:@"重置密码成功!"];
                
                //to loginViewController
                [self.navigationController popToRootViewControllerAnimated:YES];
            }
            
            [[GlobalHandler sharedInstance] showAlertWithMsg:responseObject[@"rtMsg"]];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [GlobalHandler dismissActivityViewAnimated:YES];
            NSLog(@"%@",error.description);
        }];
    }
}
@end
