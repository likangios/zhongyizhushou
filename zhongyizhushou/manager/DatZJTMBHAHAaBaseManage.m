//
//  DatZJTMBHAHAaBaseManage.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "DatZJTMBHAHAaBaseManage.h"
@interface DatZJTMBHAHAaBaseManage()

@property(nonatomic,strong) JQFMDB *fmdb;

@end

static DatZJTMBHAHAaBaseManage *manager;
@implementation DatZJTMBHAHAaBaseManage


+ (instancetype)sharedDataBaseManage{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DatZJTMBHAHAaBaseManage alloc]init];
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
- (NSArray *)getAllItemCountModel{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"itemcount" dicOrModel:[IXGQZMODtemCountModel class] whereFormat:nil];
    }];
    return resultArray;
}
- (IXGQZMODtemCountModel *)getItemCountModelWithParentId:(NSString *)parentid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",parentid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"itemcount" dicOrModel:[IXGQZMODtemCountModel class] whereFormat:splString];
    }];
    if (resultArray.count) {
        return resultArray[0];
    }
    return nil;
}
- (ItemXGQZMODListModel *)getItemListModelWithTitleId:(NSString *)titleId{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where titleid = '%@'",titleId];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"itemlist" dicOrModel:[ItemXGQZMODListModel class] whereFormat:splString];
    }];
    if (resultArray.count) {
        return resultArray[0];
    }
    return nil;
}
- (BOOL)updateItemCount:(IXGQZMODtemCountModel *)model{
    __block BOOL success = NO;
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",model.parentid];
    [self.fmdb jq_inDatabase:^{
        success = [self.fmdb jq_updateTable:@"itemcount" dicOrModel:model whereFormat:splString];
    }];
    return success;
}
- (BOOL)updateItemList:(ItemXGQZMODListModel *)model{
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
        resultArray = [self.fmdb jq_lookupTable:@"itemlist" dicOrModel:[ItemXGQZMODListModel class] whereFormat:splString];
    }];
    return resultArray.count;
}

- (NSArray *)getAllItemListModelWithParentid:(NSString *)parentid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",parentid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"itemlist" dicOrModel:[ItemXGQZMODListModel class] whereFormat:splString];
    }];
    return resultArray;
}

@end
