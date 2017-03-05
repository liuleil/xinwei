//
//  RequestBase+SearchNews.h
//  xinwei
//
//  Created by leileigege on 2017/2/26.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "RequestBase.h"

@interface RequestBase (SearchNews)
+ (void)sendRequstWithKeyword:(NSString *)keyWord completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;
@end
