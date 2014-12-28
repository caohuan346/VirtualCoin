//
//  DESUtils.h
//  VirtualCoin
//
//  Created by hc on 14/12/21.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "Base64.h"
@interface DESUtils : NSObject
+(NSString *)decryptUseDES:(NSString *)cipherText key:(NSString *)key;
+(NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key;
@end