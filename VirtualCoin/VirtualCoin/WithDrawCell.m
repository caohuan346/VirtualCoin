//
//  WithDrawCell.m
//  VirtualCoin
//
//  Created by hc on 14/12/28.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "WithDrawCell.h"

@implementation WithDrawCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)cancelDraw:(id)sender {
    NSDictionary *param = @{@"cid":self.wdId,
                            @"wdStatus":@4};
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_chanelWithDraw parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        //更新用户信息
        //[SharedAppDelegate.globalUser fillInfoWithInfoDic:responseObject];
        
        if([responseObject[@"rtCode"] intValue] == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationKey_CancelWithDraw object:nil];
        }
        [[GlobalHandler sharedInstance] showAlertWithTitle:@"提示" message:responseObject[@"rtMsg"]okButtonTitle:@"确定" clickedHandle:^(NSInteger selectedIndex) {
        }];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];

}
@end
