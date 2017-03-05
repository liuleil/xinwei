//
//  RequestBase.m
//  ZYOriginalLife
//
//  Created by leileigege on 2016/11/23.
//  Copyright © 2016年 hehe. All rights reserved.
//

#import "RequestBase.h"
#import <AFNetworking.h>
@implementation RequestBase



+ (void)getReuqestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))completionHandler
{
    
    [self sendRequestWithRequestType:@"GET" path:path parameters:parameters completionHandler:completionHandler];
}

+ (void)postReuqestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))completionHandler
{
    [self sendRequestWithRequestType:@"POST" path:path parameters:parameters completionHandler:completionHandler];
}

+ (void)sendRequestWithRequestType:(NSString *)type path:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))completionHandler
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setValue:@"APPCODE 38f5cdac20fb40d5818e16ff77bd40ae" forHTTPHeaderField:@"Authorization"];
    if ([type isEqualToString:@"GET"])
    {
        [manager GET:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"%@",[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding]);
            completionHandler(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"%@",error.userInfo);
            completionHandler(nil, error);
        }];
    }

    else if([type isEqualToString:@"POST"])
    {
        [manager POST:path parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            completionHandler(responseObject, nil);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            completionHandler(nil, error);
        }];
      
    }
}


@end
