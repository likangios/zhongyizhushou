//
//  ZYTHardbyBookDataManager.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "ZYTHardbyBookDataManager.h"
@interface ZYTHardbyBookDataManager()

@property(nonatomic,strong) JQFMDB *fmdb;

@end

static ZYTHardbyBookDataManager *manager;
@implementation ZYTHardbyBookDataManager


+ (instancetype)sharedDataBaseManage{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZYTHardbyBookDataManager alloc]init];
    });
    return manager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        
        NSString *dbName = [NSString stringWithFormat:@"/%@",@"hardbybook.db"];
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath = [documentPath stringByAppendingString:dbName];
        BOOL file_Exist  = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
        NSString *localPath =  [[NSBundle mainBundle] pathForResource:@"hardbybook.db" ofType:nil];
        if (!file_Exist) {
            NSError *error = nil;
            [[NSFileManager defaultManager] copyItemAtPath:localPath toPath:dbPath error:&error];
            if (error) {
                NSLog(@"DB 移动错误\n%@",error);
            }
        }
        self.fmdb = [[JQFMDB alloc]initWithDBName:@"hardbybook.db"];
        [self.fmdb open];
        
    }
    return self;
}
#pragma mark - 濒湖脉学
- (NSArray <BookBaseModel *>*)binhumaixueData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"binhumaixue" dicOrModel:[BookContentModel class] whereFormat:nil];
    }];
    return resultArray;
}
#pragma mark - 难经
- (NSArray <BookBaseModel *>*)hardbyBookData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"hardbybookitem" dicOrModel:[BookMuLuModel class] whereFormat:nil];
    }];
    
    [resultArray enumerateObjectsUsingBlock:^(BookMuLuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.subModel = [self hardbyBookDetailDataWithParentId:obj.did];
    }];
    return resultArray;
}
- (NSArray <BookBaseModel *>*)hardbyBookDetailDataWithParentId:(NSString *)parentid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",parentid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"hardbybookdetail" dicOrModel:[BookContentModel class] whereFormat:splString];
    }];
    
    return resultArray;
}
#pragma mark - 伤寒论
- (NSArray <BookBaseModel *>*)shanghanlunData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"shanghanitem" dicOrModel:[BookMuLuModel class] whereFormat:nil];
    }];
    [resultArray enumerateObjectsUsingBlock:^(BookMuLuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.totalcount.integerValue > 0) {
            NSMutableArray *array = [NSMutableArray array];
            BookContentModel *model = [[BookContentModel alloc]init];
            model.parentid = @"6";
            model.content = obj.content;
            model.title = [NSString stringWithFormat:@"%@(论述)",obj.title];
            [array addObject:model];
            [array addObjectsFromArray:[self shanghanlunItemDataWithUid:obj.uid]];
            obj.subModel = array;
            obj.title = [NSString stringWithFormat:@"%@(%@方)",obj.title,obj.totalcount];

        }
    }];
    return resultArray;
}
- (NSArray <BookBaseModel *>*)shanghanlunItemDataWithUid:(NSString *)uid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",uid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"shanghansubitem" dicOrModel:[BookContentModel class] whereFormat:splString];
    }];
    return resultArray;
}


#pragma mark - 医学三字经
- (NSArray <BookBaseModel *>*)yixuesanzijingData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"threeclassic" dicOrModel:[BookContentModel class] whereFormat:nil];
    }];
    return resultArray;
}
@end
