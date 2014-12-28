//
//  ModifyFundPwdViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/23.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "ModifyFundPwdViewController.h"
#import "AppDelegate.h"

@interface ModifyFundPwdViewController ()

@end

@implementation ModifyFundPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - action

#pragma mark - action
- (IBAction)submit:(id)sender {
    
    if (![self validate]) {
        return;
    }
    
    NSDictionary *param = @{@"Mobile":SharedAppDelegate.globalUser.mobile,
                            @"code":@"",
                            @"type":@1,
                            @"oldPwd":self.oldPwd.text,
                            @"newPwd":self.myNewPwd.text};
    
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_modifyPwd parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:responseObject[@"rtMsg"] okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
            NSLog(@"1111");
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
}

#pragma mark - private
-(BOOL)validate{
    if ([self.oldPwd.text isEqualToString:@""]) {
        [self showAlertMsg:@"请输入旧密码"];
        return NO;
    }
    if ([self.myNewPwd.text isEqualToString:@""]) {
        [self showAlertMsg:@"请输入新密码"];
        return NO;
    }
    if ([self.confirmPwd.text isEqualToString:@""]) {
        [self showAlertMsg:@"请输入确认密码"];
        return NO;
    }
    
    if (![self.myNewPwd.text isEqualToString:self.confirmPwd.text]) {
        [self showAlertMsg:@"旧密码与新密码不一致"];
        return NO;
    }
    
    return YES;
}

-(void)showAlertMsg:(NSString *)msg{
    [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:msg okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
    }];
}

@end
