//
//  AcupointZJTMBHAHADataManager.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AcZJTMBHAHAupointListModel;
@interface AcupointZJTMBHAHADataManager : NSObject
+ (instancetype)sharedDataBaseManage;
- (NSArray <AcZJTMBHAHAupointListModel *>*)acumainData;
@end
