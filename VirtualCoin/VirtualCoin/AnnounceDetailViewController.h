//
//  AnnounceDetailViewController.h
//  VirtualCoin
//
//  Created by hc on 15/1/2.
//  Copyright (c) 2015年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnounceDetailViewController : UIViewController

@property(nonatomic,strong)NSDictionary *announceDetailDic;

@property (weak, nonatomic) IBOutlet UILabel *titleUL;
@property (weak, nonatomic) IBOutlet UILabel *dateUL;
@property (weak, nonatomic) IBOutlet UIWebView *detailWebView;

@property (weak, nonatomic) IBOutlet UILabel *organizeUL;

@end
