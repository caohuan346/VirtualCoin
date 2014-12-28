//
//  SettingViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/10.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "SettingViewController.h"

#define kRememberPwd @"kRememberPwd"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.switchBtn.on = [StandardUserDefaults objectForKey:kRememberPwd];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - tableView delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //在线签到
    if (indexPath.section == 0 && indexPath.row ==0) {
        [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_signIn parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:responseObject[@"rtMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error.userInfo);
        }];
    }
    //一键分享
    else if (indexPath.section ==2 && indexPath.row == 0){
        
    }
    //检查更新
    else if (indexPath.section ==2 && indexPath.row == 2){
        
    }
}

#pragma mark action
- (IBAction)rememberPwd:(id)sender {
    UISwitch *switchBtn = (UISwitch *)sender;
    BOOL swichState =  switchBtn.on;
    NSLog(@"%d",swichState);
    
    [StandardUserDefaults setObject:[NSString stringWithFormat:@"%d",swichState] forKey:kRememberPwd];
}
@end
