//
//  RequestBase+News.m
//  xinwei
//
//  Created by leileigege on 2017/2/24.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "RequestBase+News.h"
#import "CQRootClass.h"
#import <YYModel.h>
NSString * const LLChannel = @"channel";
NSString * const LLNum = @"num";
NSString * const LLStart = @"start";
@implementation RequestBase (News)
+ (void)sendRequstWithChannel:(NSString *)channel num:(NSNumber * )num start:(NSNumber *)startNum completionHandler:(void(^)(id responseObj, NSError *error))completionHandler
{
    NSDictionary *params = @{
                             LLChannel :channel,
                             LLNum : num,
                             LLStart : startNum,
                             };
    
    [self getReuqestWithPath:@"http://jisunews.market.alicloudapi.com/news/get" parameters:params completionHandler:^(id responseObj, NSError *error) {

        if (!error)
        {
            
           NSLog(@"%@",[[NSString alloc]initWithData:responseObj
                                            encoding:NSUTF8StringEncoding]);
            CQRootClass *resultModel = [CQRootClass yy_modelWithJSON:responseObj];
         
                        completionHandler(resultModel, nil);
        }
        else
        {
            completionHandler(nil, error);
        }
    }];
}

@end
