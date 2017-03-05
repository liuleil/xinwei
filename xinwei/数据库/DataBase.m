//
//  DataBase.m
//  xinwei
//
//  Created by leileigege on 2017/2/28.
//  Copyright © 2017年 liulei. All rights reserved.
//

#import "DataBase.h"

#import "CQList.h"
@implementation DataBase
+ (NSString *)loadPath {
    return  [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/db.sqlite"];
}
static FMDatabase *db;
+ (BOOL)openDataBase {
    if (!db) {
        db = [[FMDatabase alloc] initWithPath:[self loadPath]];
    }
    if (![db open]) {
        [db close];
        return NO;
    }
    //提高效率设置缓存
    [db shouldCacheStatements];
    return YES;
}

+ (void)excuteSQL:(NSString *)sql {
    if ([self openDataBase]) {
        [db executeUpdate:sql];
        [db close];
    }
}

+ (void)createTable {
    if ([self openDataBase]) {
        
//        
//        @property (nonatomic, copy) NSString * category;
//        @property (nonatomic, copy) NSString * content;
//        @property (nonatomic, copy) NSString * pic;
//        @property (nonatomic, copy) NSString * src;
//        @property (nonatomic, copy) NSString * time;
//        @property (nonatomic, copy) NSString * title;
//        @property (nonatomic, copy) NSString * url;
//        @property (nonatomic, copy) NSString * weburl;
        if (![db tableExists:@"news"]) {
            [db executeUpdate:@"create table news (title text primary key , category text , content text, pic text, src text, time text, url text, weburl text)"];
        }
        [db close];
    }
}
+ (void)insertNews:(CQList *)newsModel;
 {
    NSString *sql = @"insert into news (title,category,content,pic,src,time,url,weburl)values (?,?,?,?,?,?,?,?)";
    if ([self openDataBase]) {
        //name变量绑定第一个?
        //age变量绑定第二个?
        //无论数据库中的字段是否是基本类型,此时都必须使用对象类型
        [db executeUpdate:sql,newsModel.title,newsModel.category,newsModel.content,newsModel.pic,newsModel.src,newsModel.time,newsModel.url,newsModel.weburl];
        [db close];
    }
}

+ (NSMutableArray *)queryTable {
    NSString *sql = @"select * from news";
    NSMutableArray *arr;
    if ([self openDataBase]) {
        FMResultSet *result = [db executeQuery:sql];
        arr = [NSMutableArray new];
        while ([result next]) {
            //获取某一列,可以指定字段的名称,也可以指定字段的索引
            CQList *news = [CQList new];
//            pe.ID = [result intForColumn:@"id"];
//            pe.name = [result stringForColumnIndex:1];
//            pe.age = [result intForColumn:@"age"];
            news.title = [result stringForColumn:@"title"];
              news.category = [result stringForColumn:@"category"];
              news.content = [result stringForColumn:@"content"];
              news.pic = [result stringForColumn:@"pic"];
              news.src = [result stringForColumn:@"src"];
              news.time = [result stringForColumn:@"time"];
              news.url = [result stringForColumn:@"url"];
              news.weburl = [result stringForColumn:@"weburl"];
            [arr addObject:news];
         
        }
        [result close];
        [db close];
    }
    return arr ;
}
+ (void)deleteNews:(NSString *)title{
    NSString *sql =[NSString stringWithFormat:@"delete from news where title  = '%@'",title];
    if ([self openDataBase]) {
        [db executeUpdate:sql,title];
        [db close];
    }
}


@end
