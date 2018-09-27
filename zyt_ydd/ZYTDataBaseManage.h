//
//  ZYTDataBaseManage.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/19.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYTItemListModel.h"
#import "ZYTItemCountModel.h"

@interface ZYTDataBaseManage : NSObject

+ (instancetype)sharedDataBaseManage;

- (BOOL)updateItemCount:(ZYTItemCountModel *)model;
- (BOOL)updateItemList:(ZYTItemListModel *)model;

- (NSArray *)getAllItemCountModel;
- (ZYTItemCountModel *)getItemCountModelWithParentId:(NSString *)parentid;

- (ZYTItemListModel *)getItemListModelWithTitleId:(NSString *)titleId;

- (NSArray *)getAllItemListModelWithParentid:(NSString *)parentid;
- (NSInteger)getNumberOfUnlockItemListModelWithParentid:(NSString *)parentid;
@end
