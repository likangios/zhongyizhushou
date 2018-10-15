//
//  ZYTAcupointDataManager.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "ZYTAcupointDataManager.h"

@interface ZYTAcupointDataManager()

@property(nonatomic,strong) JQFMDB *fmdb;

@end

static ZYTAcupointDataManager *manager;

#define  DBNAME @"acupuncture.db"
@implementation ZYTAcupointDataManager

+ (instancetype)sharedDataBaseManage{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZYTAcupointDataManager alloc]init];
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
    return self;
}
#pragma mark - 金匮要略
- (NSArray <AcupointListModel *>*)acumainData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"acumain" dicOrModel:[AcupointListModel class] whereFormat:nil];
    }];
    [resultArray enumerateObjectsUsingBlock:^(AcupointListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.subModel = [self acumainDataSubItemData:obj.recno];
    }];
    return resultArray;
}
- (NSArray <AcupointDetailModel *>*)acumainDataSubItemData:(NSString *)parentId{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",parentId];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"acudetail" dicOrModel:[AcupointDetailModel class] whereFormat:splString];
    }];
    
    return resultArray;
}
@end
