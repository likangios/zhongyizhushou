//
//  ZYTItemListModel.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/20.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYTItemListModel : NSObject
@property(nonatomic,strong) NSString *titleid;
@property(nonatomic,strong) NSString *parentid;
@property(nonatomic,strong) NSString *subid;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *tips;
@property(nonatomic,strong) NSString *answer;
@property(nonatomic,strong) NSString *answertips;
@property(nonatomic,strong) NSString *isunlock;

@end
