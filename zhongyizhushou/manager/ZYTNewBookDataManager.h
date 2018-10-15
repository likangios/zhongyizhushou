//
//  ZYTNewBookDataManager.h
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
@interface ZYTNewBookDataManager : NSObject

+ (instancetype)sharedDataBaseManage;
- (NSArray <BookBaseModel *>*)newBookDataWithType:(newBookType)type;
/**
 金匮要略

 @return
 */
- (NSArray <BookBaseModel *>*)goldenchamberData;

/**
 温病条辩

 @return
 */
- (NSArray <BookBaseModel *>*)diseasedisorderData;
@end
