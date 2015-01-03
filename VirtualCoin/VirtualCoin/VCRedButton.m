//
//  VCRedButton.m
//  VirtualCoin
//
//  Created by hc on 14/12/29.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import "VCRedButton.h"

#import "UIImage+ImageWithColor.h"

@implementation VCRedButton

-(instancetype)init {
    self = [super init];
    if (self) {
        [self setBackgroundImage:[UIImage imageWithColor:kRedButtonNormalColor] forState:UIControlStateNormal];
        [self setBackgroundImage:[UIImage imageWithColor:kRedButtonClickedColor] forState:UIControlStateHighlighted];
        [self setBackgroundImage:[UIImage imageWithColor:kButtonDisabledGrayColor] forState:UIControlStateDisabled];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


-(void)awakeFromNib{
    [super awakeFromNib];
    //self.backgroundColor = [UIColor colorWithRed:0.84 green:0.23 blue:0.29 alpha:1];
    
    [self setBackgroundImage:[UIImage imageWithColor:kRedButtonNormalColor] forState:UIControlStateNormal];
    [self setBackgroundImage:[UIImage imageWithColor:kRedButtonClickedColor] forState:UIControlStateHighlighted];
    [self setBackgroundImage:[UIImage imageWithColor:kButtonDisabledGrayColor] forState:UIControlStateDisabled];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
