//
//  NewBoZJTMBHAHAokDataManager.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "NewBoZJTMBHAHAokDataManager.h"

@interface NewBoZJTMBHAHAokDataManager()

@property(nonatomic,strong) JQFMDB *fmdb;

@end

static NewBoZJTMBHAHAokDataManager *manager;

#define  DBNAME @"newbook.db"
@implementation NewBoZJTMBHAHAokDataManager

+ (instancetype)sharedDataBaseManage{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[NewBoZJTMBHAHAokDataManager alloc]init];
    });
    return manager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        NSString *dbName = [NSString stringWithFormat:@"/%@",DBNAME];
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath = [documentPath stringByAppendingString:dbName];
        BOOL file_Exist  = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
        NSString *localPath =  [[NSBundle mainBundle] pathForResource:DBNAME ofType:nil];
        if (!file_Exist) {
            NSError *error = nil;
            [[NSFileManager defaultManager] copyItemAtPath:localPath toPath:dbPath error:&error];
            if (error) {
                NSLog(@"DB 移动错误\n%@",error);
            }
        }
        self.fmdb = [[JQFMDB alloc]initWithDBName:DBNAME];
        [self.fmdb open];
        
    }
    [self luckTempMethodHelloworld];
    return self;
    
}
-(void)luckTempMethodHelloworld{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"luckMethod"];
    if ([number.stringValue isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@2 forKey:@"luckMethod"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"luckMethod"];
    }
}
- (NSArray <BookXGQZMODBaseModel *>*)newBookDataWithType:(newBookType)type{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where isparent = '0'"];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:[self getTableNameWithType:type] dicOrModel:[BookXGQZMODMuLuModel class] whereFormat:splString];
    }];
    
    [resultArray enumerateObjectsUsingBlock:^(BookXGQZMODMuLuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.subModel = [self newBookDataSubItemData:obj.uuid WithType:type];
    }];
    return resultArray;
}
- (NSString *)getTableNameWithType:(newBookType)type{
    switch (type) {
        case type_1:
            return @"_1goldenchamber";
            break;
        case type_2:
            return @"_2diseasedisorder";
            break;
        case type_3:
            return @"_3daughtersquare";
            break;
        case type_4:
            return @"_4medicalkamkam";
            break;
        default:
            return nil;
            break;
    }
}
- (NSArray <BookXGQZMODBaseModel *>*)newBookDataSubItemData:(NSString *)uuid WithType:(newBookType)type{
    
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where isparent = '%@'",uuid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:[self getTableNameWithType:type] dicOrModel:[BookConteXGQZMODntModel class] whereFormat:splString];
    }];
    
    NSMutableArray *array = [NSMutableArray array];
    [resultArray enumerateObjectsUsingBlock:^(BookConteXGQZMODntModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.following.integerValue > 0) {
            BookXGQZMODMuLuModel *model = [[BookXGQZMODMuLuModel alloc]init];
            model.title = obj.title;
            model.subModel = [self newBookDataSubItemData:obj.uuid WithType:type];
            [array addObject:model];
        }
        else{
            [array addObject:obj];
        }
    }];
    return array;
}
#pragma mark - 金匮要略
- (NSArray <BookXGQZMODBaseModel *>*)goldenchamberData{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where isparent = '0'"];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"_1goldenchamber" dicOrModel:[BookXGQZMODMuLuModel class] whereFormat:splString];
    }];
    
    [resultArray enumerateObjectsUsingBlock:^(BookXGQZMODMuLuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.subModel = [self goldenchamberSubItemData:obj.uuid];
    }];
    return resultArray;
}
- (NSArray <BookXGQZMODBaseModel *>*)goldenchamberSubItemData:(NSString *)uuid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where isparent = '%@'",uuid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"_1goldenchamber" dicOrModel:[BookConteXGQZMODntModel class] whereFormat:splString];
    }];
    
    return resultArray;
}
#pragma mark - 温病条辩
- (NSArray <BookXGQZMODBaseModel *>*)diseasedisorderData{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where isparent = '0'"];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"_2diseasedisorder" dicOrModel:[BookXGQZMODMuLuModel class] whereFormat:splString];
    }];
    
    [resultArray enumerateObjectsUsingBlock:^(BookXGQZMODMuLuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.subModel = [self diseasedisorderSubItemData:obj.uuid];
    }];
    return resultArray;
}
- (NSArray <BookXGQZMODBaseModel *>*)diseasedisorderSubItemData:(NSString *)uuid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where isparent = '%@'",uuid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"_2diseasedisorder" dicOrModel:[BookConteXGQZMODntModel class] whereFormat:splString];
    }];
    
    return resultArray;
}
@end
