//
//  Base64.h
//  VirtualCoin
//
//  Created by hc on 14/12/21.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Base64 : NSObject

+(int)char2Int:(char)c;
+(NSData *)decode:(NSString *)data;
+(NSString *)encode:(NSData *)data;

@end
