//
//  HardbZJTMBHAHAyBookDataManager.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "HardbZJTMBHAHAyBookDataManager.h"
@interface HardbZJTMBHAHAyBookDataManager()

@property(nonatomic,strong) JQFMDB *fmdb;

@end

static HardbZJTMBHAHAyBookDataManager *manager;
@implementation HardbZJTMBHAHAyBookDataManager


+ (instancetype)sharedDataBaseManage{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HardbZJTMBHAHAyBookDataManager alloc]init];
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
#pragma mark - 濒湖脉学
- (NSArray <BookXGQZMODBaseModel *>*)binhumaixueData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"binhumaixue" dicOrModel:[BookConteXGQZMODntModel class] whereFormat:nil];
    }];
    return resultArray;
}
#pragma mark - 难经
- (NSArray <BookXGQZMODBaseModel *>*)hardbyBookData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"hardbybookitem" dicOrModel:[BookXGQZMODMuLuModel class] whereFormat:nil];
    }];
    
    [resultArray enumerateObjectsUsingBlock:^(BookXGQZMODMuLuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.subModel = [self hardbyBookDetailDataWithParentId:obj.did];
    }];
    return resultArray;
}
- (NSArray <BookXGQZMODBaseModel *>*)hardbyBookDetailDataWithParentId:(NSString *)parentid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",parentid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"hardbybookdetail" dicOrModel:[BookConteXGQZMODntModel class] whereFormat:splString];
    }];
    
    return resultArray;
}
#pragma mark - 伤寒论
- (NSArray <BookXGQZMODBaseModel *>*)shanghanlunData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"shanghanitem" dicOrModel:[BookXGQZMODMuLuModel class] whereFormat:nil];
    }];
    [resultArray enumerateObjectsUsingBlock:^(BookXGQZMODMuLuModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.totalcount.integerValue > 0) {
            NSMutableArray *array = [NSMutableArray array];
            BookConteXGQZMODntModel *model = [[BookConteXGQZMODntModel alloc]init];
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
- (NSArray <BookXGQZMODBaseModel *>*)shanghanlunItemDataWithUid:(NSString *)uid{
    __block NSArray *resultArray = [NSArray array];
    NSString *splString = [NSString stringWithFormat:@"where parentid = '%@'",uid];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"shanghansubitem" dicOrModel:[BookConteXGQZMODntModel class] whereFormat:splString];
    }];
    return resultArray;
}


#pragma mark - 医学三字经
- (NSArray <BookXGQZMODBaseModel *>*)yixuesanzijingData{
    __block NSArray *resultArray = [NSArray array];
    [self.fmdb jq_inDatabase:^{
        resultArray = [self.fmdb jq_lookupTable:@"threeclassic" dicOrModel:[BookConteXGQZMODntModel class] whereFormat:nil];
    }];
    return resultArray;
}
@end
