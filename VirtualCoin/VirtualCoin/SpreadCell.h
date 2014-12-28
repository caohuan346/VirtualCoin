//
//  SpreadCell.h
//  VirtualCoin
//
//  Created by hc on 14/12/28.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SpreadCell : UITableViewCell
/*

 pageCount 总页数
 currPage 当前页数
 refInfos推广记录集合
     byRefName 推广人用户名称
     doMsg处理信息
     Status处理状态 //1已处理2.未处理
     doDate推广时间 （Long类型 需转换成String展示）
*/

@property (weak, nonatomic) IBOutlet UILabel *doDateUL;
@property (weak, nonatomic) IBOutlet UILabel *doTimeUL;

@property (weak, nonatomic) IBOutlet UILabel *byRefNameUL;//

@property (weak, nonatomic) IBOutlet UILabel *StatusUL;//

@property (weak, nonatomic) IBOutlet UILabel *doMsgUL;//

@end
