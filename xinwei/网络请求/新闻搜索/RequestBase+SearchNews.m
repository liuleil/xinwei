//
//  RequestBase+SearchNews.m
//  xinwei
//
//  Created by leileigege on 2017/2/26.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "RequestBase+SearchNews.h"
#import "CQRootClass.h"
#import <YYModel.h>
@implementation RequestBase (SearchNews)
+ (void)sendRequstWithKeyword:(NSString *)keyWord completionHandler:(void(^)(id responseObj, NSError *error))completionHandler{


    
    NSDictionary *params = @{
                             @"keyword" :keyWord
                            
                             };
    
    [self getReuqestWithPath:@"http://jisunews.market.alicloudapi.com/news/search" parameters:params completionHandler:^(id responseObj, NSError *error) {
        
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
