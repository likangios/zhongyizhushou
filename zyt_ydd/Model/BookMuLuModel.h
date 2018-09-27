//
//  BookMuLuModel.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookBaseModel.h"
@interface BookMuLuModel : BookBaseModel
@property(nonatomic,strong) NSString *grade;
@property(nonatomic,strong) NSString *uuid;
@property(nonatomic,strong) NSString *uid;
@property(nonatomic,strong) NSString *did;
@property(nonatomic,strong) NSString *totalcount;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSArray *subModel;
@property(nonatomic,strong) NSString *title;

@end
