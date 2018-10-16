//
//  DatZJTMBHAHAaBaseManage.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemXGQZMODListModel.h"
#import "IXGQZMODtemCountModel.h"

@interface DatZJTMBHAHAaBaseManage : NSObject

+ (instancetype)sharedDataBaseManage;

- (BOOL)updateItemCount:(IXGQZMODtemCountModel *)model;
- (BOOL)updateItemList:(ItemXGQZMODListModel *)model;

- (NSArray *)getAllItemCountModel;
- (IXGQZMODtemCountModel *)getItemCountModelWithParentId:(NSString *)parentid;

- (ItemXGQZMODListModel *)getItemListModelWithTitleId:(NSString *)titleId;

- (NSArray *)getAllItemListModelWithParentid:(NSString *)parentid;
- (NSInteger)getNumberOfUnlockItemListModelWithParentid:(NSString *)parentid;
@end
