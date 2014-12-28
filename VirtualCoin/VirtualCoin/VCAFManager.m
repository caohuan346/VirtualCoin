//
//  AFZSDManager.m
//  ZOSENDA_AFNetworking_Webservice
//
//  Created by Happy on 14-8-20.
//  Copyright (c) 2014年 ZOSENDA GROUP. All rights reserved.
//

#import "VCAFManager.h"

#define kAFUrl @"http://www.baidu.com"
#define kRequestTimeOut 15.0

@interface VCAFManager ()


@end

@implementation VCAFManager

+ (VCAFManager *)sharedInstance
{
    static VCAFManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (!self)
    {
        return nil;
    }
    return self;
}

#pragma mark - POST
-(void)postHttpMethod:(NSString *)methodName
          parameters:(id)parameters
             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    /*
    [self POST:[kHttpBaseURL stringByAppendingPathComponent:methodName] parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSDictionary *inDic = [responseObject objectFromJSONData];
        if (success) {
            success(operation, responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(operation,error);
        }
    }];
    */
    
    /*
    NSString *urlString = [kHttpBaseURL stringByAppendingPathComponent:methodName];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:urlString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    [self.requestSerializer setValue:methodName forHTTPHeaderField:@"methodName"];
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [self.operationQueue addOperation:operation];
     */
    [self postHttpMethod:methodName uniqueTag:nil parameters:parameters success:success failure:failure];
}

- (void)postHttpMethod:(NSString *)methodName
            uniqueTag:(NSString *)uniqueTag
           parameters:(id)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    NSString *urlString = [kHttpBaseURL stringByAppendingPathComponent:methodName];
   // NSString *urlString = [@"http://115.29.17.51/Mobile" stringByAppendingPathComponent:methodName];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:urlString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    [request setTimeoutInterval:kRequestTimeOut];
    
    if (uniqueTag && uniqueTag.length > 0)
    {
        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@_%@",methodName,uniqueTag] forHTTPHeaderField:@"methodName"];
    }
    else
    {
        [self.requestSerializer setValue:methodName forHTTPHeaderField:@"methodName"];
    }
    
//    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    [self.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    if (self.JSESSIONID) {
            [self.requestSerializer setValue:self.JSESSIONID forHTTPHeaderField:@"Cookie"];
    }
    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
}

#pragma mark - GET
- (void)getHttpMethod:(NSString *)methodName
           parameters:(id)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    [self getHttpMethod:methodName uniqueTag:nil parameters:parameters success:success failure:failure];
}

- (void)getHttpMethod:(NSString *)methodName
            uniqueTag:(NSString *)uniqueTag
           parameters:(id)parameters
              success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure{
    NSString *urlString = [kHttpBaseURL stringByAppendingPathComponent:methodName];
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:urlString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    [request setTimeoutInterval:kRequestTimeOut];
    
    if (uniqueTag && uniqueTag.length > 0)
    {
        [self.requestSerializer setValue:[NSString stringWithFormat:@"%@_%@",methodName,uniqueTag] forHTTPHeaderField:@"methodName"];
    }
    else
    {
        [self.requestSerializer setValue:methodName forHTTPHeaderField:@"methodName"];
    }

    
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    [self.operationQueue addOperation:operation];
}

#pragma mark - cancel

- (BOOL)cancelHttpMethod:(NSString*)methodName
{
    return [self cancelHttpMethod:methodName uniqueTag:nil];
}

- (BOOL)cancelHttpMethod:(NSString*)methodName uniqueTag:(NSString *)uniqueTag
{
    NSString *methodInfo = [self.requestSerializer HTTPRequestHeaders][@"methodName"];
    NSString *seekStr;
    if (uniqueTag && uniqueTag.length > 0)
    {
        seekStr = [NSString stringWithFormat:@"%@_%@", methodName, uniqueTag];
    }
    else
    {
        seekStr = methodName;
    }
    
    NSArray *array=[self.operationQueue operations];
    for (AFHTTPRequestOperation *operation in array)
    {
        if ([methodInfo rangeOfString:seekStr].location != NSNotFound)
        {
            [operation cancel];
            return YES;
        }
    }
    
    return NO;
}

@end
