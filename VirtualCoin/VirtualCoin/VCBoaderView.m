//
//  ZSDBoaderView.m
//  VirtualCoin
//
//  Created by Happy on 14-9-1.
//  Copyright (c) 2014年 Happy. All rights reserved.
//

#import "VCBoaderView.h"

@implementation VCBoaderView

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
    
    self.layer.borderWidth = 1;
    self.layer.borderColor = kThemeBorderColor;
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
