//
//  AcupointZJTMBHAHADataManager.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "AcupointZJTMBHAHADataManager.h"

@interface AcupointZJTMBHAHADataManager()

@property(nonatomic,strong) JQFMDB *fmdb;

@end

static AcupointZJTMBHAHADataManager *manager;

#define  DBNAME @"acupuncture.db"
@implementation AcupointZJTMBHAHADataManager

+ (instancetype)sharedDataBaseManage{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[AcupointZJTMBHAHADataManager alloc]init];
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
#pragma mark - 金匮要略
- (NSArray <AcZJTMBHAHAupointListModel *>*)acumainData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"acumain" dicOrModel:[AcZJTMBHAHAupointListModel class] whereFormat:nil];
    }];
    [resultArray enumerateObjectsUsingBlock:^(AcZJTMBHAHAupointListModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.subModel = [self acumainDataSubItemData:obj.recno];
    }];
    return resultArray;
}
- (NSArray <AcupoZJTMBHAHAintDetailModel *>*)acumainDataSubItemData:(NSString *)parentId{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",parentId];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"acudetail" dicOrModel:[AcupoZJTMBHAHAintDetailModel class] whereFormat:splString];
    }];
    
    return resultArray;
}
@end
