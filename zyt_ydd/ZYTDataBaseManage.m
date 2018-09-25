//
//  ZYTDataBaseManage.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "ZYTDataBaseManage.h"
@interface ZYTDataBaseManage()

@property(nonatomic,strong) JQFMDB *fmdb;

@end

static ZYTDataBaseManage *manager;
@implementation ZYTDataBaseManage


+ (instancetype)sharedDataBaseManage{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ZYTDataBaseManage alloc]init];
    });
    return manager;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        
        NSString *dbName = [NSString stringWithFormat:@"/%@",@"riddles.db"];
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSString *dbPath = [documentPath stringByAppendingString:dbName];
        BOOL file_Exist  = [[NSFileManager defaultManager] fileExistsAtPath:dbPath];
        NSString *localPath =  [[NSBundle mainBundle] pathForResource:@"riddles.db" ofType:nil];
        if (!file_Exist) {
            NSError *error = nil;
            [[NSFileManager defaultManager] copyItemAtPath:localPath toPath:dbPath error:&error];
            if (error) {
                NSLog(@"DB 移动错误\n%@",error);
            }
        }
        self.fmdb = [[JQFMDB alloc]initWithDBName:@"riddles.db"];
        [self.fmdb open];
        
    }
    return self;
}
- (NSArray *)getAllItemCountModel{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"itemcount" dicOrModel:[ZYTItemCountModel class] whereFormat:nil];
    }];
    return resultArray;
}
- (BOOL)updateItemCount:(ZYTItemCountModel *)model{
    __block BOOL success = NO;
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",model.parentid];
    [self.fmdb jq_inDatabase:^{
        success = [self.fmdb jq_updateTable:@"itemcount" dicOrModel:model whereFormat:splString];
    }];
    return success;
}
- (BOOL)updateItemList:(ZYTItemListModel *)model{
    __block BOOL success = NO;
    NSString *splString = [NSString stringWithFormat:@"where titleid = '%@'",model.titleid];
    [self.fmdb jq_inDatabase:^{
        success = [self.fmdb jq_updateTable:@"itemlist" dicOrModel:model whereFormat:splString];
    }];
    return success;
}

- (NSInteger)getNumberOfUnlockItemListModelWithParentid:(NSString *)parentid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'and isunlock = '1'",parentid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"itemlist" dicOrModel:[ZYTItemListModel class] whereFormat:splString];
    }];
    return resultArray.count;
}

- (NSArray *)getAllItemListModelWithParentid:(NSString *)parentid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",parentid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"itemlist" dicOrModel:[ZYTItemListModel class] whereFormat:splString];
    }];
    return resultArray;
}

@end
