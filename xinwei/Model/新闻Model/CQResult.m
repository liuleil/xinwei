//
//	CQResult.m
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport



#import "CQResult.h"

NSString *const kCQResultChannel = @"channel";
NSString *const kCQResultList = @"list";
NSString *const kCQResultNum = @"num";

@interface CQResult ()
@end
@implementation CQResult

// 返回容器类中的所需要存放的数据类型 (以 Class 或 Class Name 的形式)。
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{kCQResultList: [CQList class]
             };
}
@end
