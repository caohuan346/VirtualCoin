//
//  ZSDBackgroundView.m
//  VirtualCoin
//
//  Created by Happy on 14-9-4.
//  Copyright (c) 2014年 Happy. All rights reserved.
//

#import "VCBackgroundView.h"

@implementation VCBackgroundView

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
    
    self.backgroundColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
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
