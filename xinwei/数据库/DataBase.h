//
//  DataBase.h
//  xinwei
//
//  Created by leileigege on 2017/2/28.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "CQList.h"
@interface DataBase : NSObject
+ (void)excuteSQL:(NSString *)sql;
+ (void)createTable;
+ (void)insertNews:(CQList *)newsModel;
+ (NSMutableArray *)queryTable;
+ (void)deleteNews:(NSString *)title;
@end
