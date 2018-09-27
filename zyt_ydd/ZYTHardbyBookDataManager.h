//
//  ZYTHardbyBookDataManager.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>
@class BookBaseModel;

@interface ZYTHardbyBookDataManager : NSObject
+ (instancetype)sharedDataBaseManage;
- (NSArray <BookBaseModel *>*)binhumaixueData;
- (NSArray <BookBaseModel *>*)hardbyBookData;
- (NSArray <BookBaseModel *>*)shanghanlunData;
- (NSArray <BookBaseModel *>*)yixuesanzijingData;

@end
