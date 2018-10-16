//
//  NewBoZJTMBHAHAokDataManager.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    type_1 = 1,
    type_2,
    type_3,
    type_4,
} newBookType;
@interface NewBoZJTMBHAHAokDataManager : NSObject

+ (instancetype)sharedDataBaseManage;
- (NSArray <BookXGQZMODBaseModel *>*)newBookDataWithType:(newBookType)type;
/**
 金匮要略

 @return
 */
- (NSArray <BookXGQZMODBaseModel *>*)goldenchamberData;

/**
 温病条辩

 @return
 */
- (NSArray <BookXGQZMODBaseModel *>*)diseasedisorderData;
@end
