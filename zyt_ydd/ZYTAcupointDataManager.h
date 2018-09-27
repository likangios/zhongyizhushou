//
//  ZYTAcupointDataManager.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AcupointListModel;
@interface ZYTAcupointDataManager : NSObject
+ (instancetype)sharedDataBaseManage;
- (NSArray <AcupointListModel *>*)acumainData;
@end
