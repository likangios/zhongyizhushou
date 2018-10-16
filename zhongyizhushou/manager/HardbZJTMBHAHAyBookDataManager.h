//
//  HardbZJTMBHAHAyBookDataManager.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BookXGQZMODBaseModel;

@interface HardbZJTMBHAHAyBookDataManager : NSObject
+ (instancetype)sharedDataBaseManage;
- (NSArray <BookXGQZMODBaseModel *>*)binhumaixueData;
- (NSArray <BookXGQZMODBaseModel *>*)hardbyBookData;
- (NSArray <BookXGQZMODBaseModel *>*)shanghanlunData;
- (NSArray <BookXGQZMODBaseModel *>*)yixuesanzijingData;

@end
