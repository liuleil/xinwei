//
//  RequestBase+News.h
//  xinwei
//
//  Created by leileigege on 2017/2/24.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "RequestBase.h"

@interface RequestBase (News)

+ (void)sendRequstWithChannel:(NSString *)channel num:(NSNumber *)num start:(NSNumber *)startNum completionHandler:(void(^)(id responseObj, NSError *error))completionHandler;
@end
