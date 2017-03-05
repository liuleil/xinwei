//
//  RequestBase.h
//  ZYOriginalLife
//
//  Created by leileigege on 2016/11/23.
//  Copyright © 2016年 hehe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestBase.h"
@interface RequestBase : NSObject


+ (void)getReuqestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;

+ (void)postReuqestWithPath:(NSString *)path parameters:(NSDictionary *)parameters completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;




@end
