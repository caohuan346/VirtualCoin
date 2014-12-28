//
//  DESede.h
//  VirtualCoin
//
//  Created by hc on 14/12/21.
//  Copyright (c) 2014年 happy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface DESede : NSObject

+(NSString *)TripleDES:(NSString *)plainText encryptOrDecrypt:(CCOperation)encryptOrDecrypt encryptOrDecryptKey:(NSString *)encryptOrDecryptKey;

@end
