//
//  RewardViewController.m
//  VirtualCoin
//
//  Created by hc on 14/12/28.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "RewardViewController.h"

@interface RewardViewController ()    {
    float random;
    float startValue;
    float endValue;
    NSDictionary *awards;
    NSArray *miss;
    NSArray *data;
    NSString *result;
    
    int _pid;
}
@end

@implementation RewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSDictionary *param = @{@"u":@(5*60*1000)};
    [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_klineData parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [[GlobalHandler sharedInstance] showAlertWithMsg:responseObject[@"rtMsg"]];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error.userInfo);
    }];
    
//    data = @[@"一等奖",@"二等奖",@"三等奖",@"再接再厉"];
    
    data = @[@"key_1",@"key_2",@"key_3",@"key_4",@"key_5",@"key_6"];
    
    //中奖和没中奖之间的分隔线设有2个弧度的盲区，指针不会旋转到的，避免抽奖的时候起争议。
    miss = @[
             @{@"min": @47,
               @"max":@89
               },
             @{@"min": @90,
               @"max":@133
               },
             @{@"min": @182,
               @"max":@223
               },
             @{@"min": @272,
               @"max":@314
               },
             @{@"min": @315,
               @"max":@358
               }
             ];
    
    
    awards = @{
               @"key_1": @[
                       @{
                           @"min": @152,
                           @"max":@208
                           }
                       ],
               @"key_2": @[
                       @{
                           @"min": @212,
                           @"max":@268
                           }
                       ],
               @"key_3": @[
                       @{
                           @"min": @272,
                           @"max":@328
                           }
                       ],
               @"key_4": @[
                       @{
                           @"min": @0,
                           @"max":@28
                           },
                       @{
                           @"min": @332,
                           @"max":@360
                           }
                       ],
               @"key_5": @[
                       @{
                           @"min": @32,
                           @"max":@88
                           }
                       ],
               @"key_6": @[
                       @{
                           @"min": @92,
                           @"max":@148
                           }
                       ],
               };
    /*
    miss = @[
             @{@"min": @47,
               @"max":@89
               },
             @{@"min": @90,
               @"max":@133
               },
             @{@"min": @182,
               @"max":@223
               },
             @{@"min": @272,
               @"max":@314
               },
             @{@"min": @315,
               @"max":@358
               }
             ];
    
    
    awards = @{
               @"一等奖": @[
                       @{
                           @"min": @137,
                           @"max":@178
                           }
                       ],
               @"二等奖": @[
                       @{
                           @"min": @227,
                           @"max":@268
                           }
                       ],
               @"三等奖": @[
                       @{
                           @"min": @2,
                           @"max":@43
                           }
                       ],
               @"再接再厉":miss
               };
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)start:(id)sender {
    
    
    [[GlobalHandler sharedInstance] showAlertWithTitle:@"温馨提示" message:@"每次抽奖将耗费1XYB，确定抽奖吗？"oneButtonTitle:@"试一试" anotherButtonTitle:@"算了" clickedHandle:^(NSInteger selectedIndex) {
        if(selectedIndex == 0){
            
            //请求服务器抽奖信息
            [[VCAFManager sharedInstance] postHttpMethod:kHttpMethod_userLuckLy parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
                NSLog(@"%@",responseObject);
                
                if ([responseObject[@"rtCode"] intValue] == 0) {
                    _pid = [responseObject[@"pid"] intValue];
                    
                    //动画开始
                    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
                    endValue = [self fetchResult];
                    rotationAnimation.delegate = self;
                    rotationAnimation.fromValue = @(startValue);
                    rotationAnimation.toValue = @(endValue);
                    rotationAnimation.duration = 7.0f;
                    rotationAnimation.autoreverses = NO;
                    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
                    rotationAnimation.removedOnCompletion = NO;
                    rotationAnimation.fillMode = kCAFillModeBoth;
                    [_rotateStaticImageView.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
                    
                }
                else {
                    [[GlobalHandler sharedInstance] showAlertWithMsg:responseObject[@"rtMsg"]];
                }
                
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                NSLog(@"%@",error.userInfo);
            }];

        }
    }];
    
}

-(float)fetchResult{
    
    //todo: fetch result from remote service
    srand((unsigned)time(0));

    /*
     random = rand() %4;
     int i = random;
    result = data[i];  //TEST DATA ,shoud fetch result from remote service
    if (_labelTextField.text != nil && ![_labelTextField.text isEqualToString:@""]) {
        result = _labelTextField.text;
    }
     */
    result = [NSString stringWithFormat:@"key_%d",_pid];
    

    for (NSString *str in [awards allKeys]) {
        if ([str isEqualToString:result]) {
            NSDictionary *content = awards[str][0];
            int min = [content[@"min"] intValue];
            int max = [content[@"max"] intValue];
            
            
            srand((unsigned)time(0));
            random = rand() % (max - min) +min;
            
            return radians(random + 360*5);
        }
    }
    
    /*
    random = rand() %5;
    i = random;
    NSDictionary *content = miss[i];
    int min = [content[@"min"] intValue];
    int max = [content[@"max"] intValue];
    
    srand((unsigned)time(0));
    random = rand() % (max - min) +min;
     return radians(random + 360*5);
     */
    
    return 0.0f;
    
}

//角度转弧度
double radians(float degrees) {
    return degrees*M_PI/180;
}


-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    startValue = endValue;
    if (startValue >= endValue) {
        startValue = startValue - radians(360*10);
    }
    
    NSLog(@"startValue = %f",startValue);
    NSLog(@"result = %@",result);
    _label1.text = result;
    NSLog(@"endValue = %f\n",endValue);
    
#warning mark - 动画结束，提示结果
        switch (_pid) {
            case 1:
                [[GlobalHandler sharedInstance] showAlertWithMsg:@"恭喜你获得10XYB的奖励"];
                break;
            case 2:
                [[GlobalHandler sharedInstance] showAlertWithMsg:@"恭喜你获得3XYB的奖励"];
                break;
            case 3:
                [[GlobalHandler sharedInstance] showAlertWithMsg:@"恭喜你获得30G算力的奖励"];
                break;
            case 4:
                [[GlobalHandler sharedInstance] showAlertWithMsg:@"恭喜你获得20G算力的奖励"];
                break;
            case 5:
                [[GlobalHandler sharedInstance] showAlertWithMsg:@"恭喜你获得10G算力的奖励"];
                break;
            case 6:
                [[GlobalHandler sharedInstance] showAlertWithMsg:@"恭喜你获得5G算力的奖励"];
                break;
            default:
                break;
        }
}

@end
