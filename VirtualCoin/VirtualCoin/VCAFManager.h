//
//  AFZSDManager.h
//  ZOSENDA_AFNetworking_Webservice
//
//  Created by Happy on 14-8-20.
//  Copyright (c) 2014年 ZOSENDA GROUP. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface VCAFManager : AFHTTPRequestOperationManager

@property(nonatomic,copy) NSString *JSESSIONID;

/**
 *  singleton
 *
 *  @return AFZSDManager singleton
 */
+ (VCAFManager *)sharedInstance;

/**
 *  钱一百接口访问
 *
 *  @param methodName methodName
 *  @param parameters parameters
 *  @param success    success callback
 *  @param failure    failure callback
 */
- (void)postHttpMethod:(NSString *)methodName
           parameters:(id)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  钱一百接口访问
 *
 *  @param methodName methodName
 *  @param uniqueTag  同类methodName请求，标记唯一
 *  @param parameters parameters
 *  @param success    success callback
 *  @param failure    failure callback
 */
- (void)postHttpMethod:(NSString *)methodName
            uniqueTag:(NSString *)uniqueTag
           parameters:(id)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  钱一百接口访问
 *
 *  @param methodName methodName
 *  @param parameters parameters
 *  @param success    success callback
 *  @param failure    failure callback
 */
- (void)getHttpMethod:(NSString *)methodName
            parameters:(id)parameters
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  钱一百接口访问
 *
 *  @param methodName methodName
 *  @param uniqueTag  同类methodName请求，标记唯一
 *  @param parameters parameters
 *  @param success    success callback
 *  @param failure    failure callback
 */
- (void)getHttpMethod:(NSString *)methodName
             uniqueTag:(NSString *)uniqueTag
            parameters:(id)parameters
               success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
               failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

/**
 *  取消请求：针对列表异步重复请求
 *
 *  @param methodName 接口名称
 *
 *  @return 取消结果
 */
- (BOOL)cancelHttpMethod:(NSString*)methodName;

/**
 *  取消请求：针对列表同类接口异步重复请求
 *
 *  @param methodName 接口名称
 *  @param uniqueTag  同类methodName请求，标记唯一
 *  @return 取消结果
 */
- (BOOL)cancelHttpMethod:(NSString*)methodName uniqueTag:(NSString *)uniqueTag;

@end
