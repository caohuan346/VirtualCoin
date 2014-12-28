//
//  ZSDButton.m
//  VirtualCoin
//
//  Created by Happy on 14-9-20.
//  Copyright (c) 2014年 Happy. All rights reserved.
//

#import "VCButton.h"

@implementation VCButton

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
    
    [self.layer setMasksToBounds:YES];
    self.layer.cornerRadius = 3.0;
    
//    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
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
