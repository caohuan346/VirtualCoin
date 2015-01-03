//
//  AnnounceDetailViewController.m
//  VirtualCoin
//
//  Created by hc on 15/1/2.
//  Copyright (c) 2015年 happy. All rights reserved.
//

#import "AnnounceDetailViewController.h"

@interface AnnounceDetailViewController ()

@end

@implementation AnnounceDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *htmlStr = [NSString stringWithFormat:@"<html> \n"
     "<head> \n"
     "<style type=\"text/css\"> \n"
     "body {font-family: \"%@\"; font-size: %f; color: %@;}\n"
     "</style> \n"
     "</head> \n"
     "<body>%@</body> \n"
     "</html>", @"宋体", 13.0f,@"black",self.announceDetailDic[@"pcontent"]];
    
    
    self.titleUL.text = self.announceDetailDic[@"ptitle"];
    self.dateUL.text = [[GlobalHandler sharedInstance] getFullDateStr:self.announceDetailDic[@"pdate"]];
    
    [self.detailWebView loadHTMLString:htmlStr baseURL:nil];
//    self.detailWebView.
    self.organizeUL.text = self.announceDetailDic[@"sendName"];
    
    // Do any additional setup after loading the view.
    /*
     @property (weak, nonatomic) IBOutlet UILabel *titleUL;
     @property (weak, nonatomic) IBOutlet UILabel *dateUL;
     @property (weak, nonatomic) IBOutlet UIWebView *detailWebView;
     @property (weak, nonatomic) IBOutlet UILabel *organizeUL;
     
     ptitle 公告标题
     pcontent 公告内容
     pdate  时间 （Long类型需转换成String展示）
     sendName 发送者（一般为官方发送）
     */

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
