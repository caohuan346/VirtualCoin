//
//  LoginViewController.m
//  Qian100
//
//  Created by Happy on 14-8-19.
//  Copyright (c) 2014年 ZOSENDA. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "MobilePhoneViewController.h"
#import "NSString+Regex.h"
#import "LeftViewController.h"

@interface LoginViewController ()<UITextFieldDelegate,RegisterViewControllerDelegate>
{
    BOOL isPwdVisible;
    GlobalUser *_user;
    GetMobleCodeType _getCodeType;
}
@end

@implementation LoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}
#pragma mark - life circle
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //导航栏背景设置为不透明
    self.navigationController.navigationBar.translucent = NO;
    
    //添加tap手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] init];
    [tap addTarget:self action:@selector(tapView)];
    [self.view addGestureRecognizer:tap];
    
    //设置代理
    self.usernameTextField.delegate = self;
    self.passwordTextField.delegate = self;
  
#warning mark - mobile phone
    self.usernameTextField.text = @"18926575205";
    
    //输入框风格
    self.inputView.layer.cornerRadius = 3;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField == self.usernameTextField)
    {
 
        self.usernameIcon.image = [UIImage imageNamed:@"login_icon_username_tap"];
    } else
    {
     
        self.passwordIcon.image = [UIImage imageNamed:@"login_icon_pwd_tap"];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (textField == self.usernameTextField) {
    
        self.usernameIcon.image = [UIImage imageNamed:@"login_icon_username"];
    } else
    {

        self.passwordIcon.image = [UIImage imageNamed:@"login_icon_pwd"];
    }
}

#pragma mark - private

- (void)tapView
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}
/**
 *  更新数据
 */
- (void)updateGlobalUserWithDictionary:resultDic
{
    _user = [[GlobalUser alloc] init];
    NSDictionary *meminfo = resultDic[@"meminfo"];
}
/**
 *  返回钱一百
 */
- (void)backToMySite
{
//    
//    ZSDTabBarViewController *tabBarCtl = (ZSDTabBarViewController *)self.presentingViewController;
//    UINavigationController *nav = (UINavigationController *)tabBarCtl.viewControllers[2];
//    MySiteTableViewController *mysite = nav.childViewControllers[0];
//    [mysite initData];
    [self dismissViewControllerAnimated:YES completion:NULL];
}

//到主界面
-(void)toMainViewController {

    UIViewController *firstViewCtl = [[UIViewController alloc] init];
    firstViewCtl.view.backgroundColor = [UIColor purpleColor];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:firstViewCtl];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"LeftSlider" bundle:nil];
    LeftViewController *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftViewController"];
    MMDrawerController *sliderViewController = [[MMDrawerController alloc]initWithCenterViewController:nav leftDrawerViewController:leftVC];
    sliderViewController.maximumLeftDrawerWidth = 160.0f;
    sliderViewController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
    sliderViewController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
    SharedAppDelegate.sliderViewController = sliderViewController;
    
    SharedAppDelegate.window.rootViewController = sliderViewController;
}


#pragma mark - Action Methods

//登录
- (IBAction)loginClick:(id)sender {
    
    
    NSString *mobile = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    
    if (mobile == 0) {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"请输入手机号码"];
        
    } else if (![mobile isElevenDigitNum])
    {
        [[GlobalHandler sharedInstance] showAlertWithMsg:@"无效的手机号码"];
        
    } else if(password.length == 0)
    {
        [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:@"请输入密码" okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
            
        }];
        
    } else
    {
        [self displayActivityView];
        
        //18926575205  123456
        NSDictionary *loginDic = @{@"Mobile":mobile,
                                   @"PassWord":password,
                                   @"MAC":SharedAppDelegate.globalUser.openUDID};
        
        [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_login parameters:loginDic success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            [self dismissActivityView];
            
            if([responseObject[@"rtCode"] intValue] == 0){
                
                //设置cookie
                NSString *cookieString = [[operation.response allHeaderFields] valueForKey:@"Set-Cookie"];
                NSArray *array = [cookieString componentsSeparatedByString:@";"];
                [VCAFManager sharedInstance].JSESSIONID = array[0];
                
                [self toMainViewController];
            }

            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:responseObject[@"rtMsg"] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            
            NSLog(@"%@",responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self dismissActivityView];
            NSLog(@"%@",error.userInfo);
        }];
    }
}

//密码可见
- (IBAction)pwdVisibleClick:(id)sender
{
    if (!isPwdVisible) {
        isPwdVisible = !isPwdVisible;
        
        [self.visibleButton setBackgroundImage:[UIImage imageNamed:@"login_icon_visible_tap"] forState:UIControlStateNormal];
        
        self.passwordTextField.secureTextEntry = NO;
    } else
    {
        [self.visibleButton setBackgroundImage:[UIImage imageNamed:@"login_icon_visible"] forState:UIControlStateNormal];
        isPwdVisible = !isPwdVisible;
        self.passwordTextField.secureTextEntry = YES;
    }
}

//取消
- (IBAction)cancelClick:(id)sender
{
    [self dismissActivityView];
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)toRegister:(id)sender {
    _getCodeType = GetMobleCodeType_Register;
    [self performSegueWithIdentifier:@"toGetMobileCode" sender:self];
    
}

- (IBAction)toResetPwd:(id)sender{
    _getCodeType = GetMobleCodeType_FindLoginPwd;
    [self performSegueWithIdentifier:@"toGetMobileCode" sender:self];
    
}


#pragma mark -

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toGetMobileCode"]) {
        MobilePhoneViewController *getCodeCtl = segue.destinationViewController;
        getCodeCtl.getCodeType = _getCodeType;
    }
}

#pragma mark - RegisterViewControllerDelegate
- (void)updateWithUsername:(NSString *)username AndPassword:(NSString *)password WithType:(Qian100LoginType)type
{
    self.usernameTextField.text = username;
    self.passwordTextField.text = password;
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
