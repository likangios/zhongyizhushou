//
//  BookContentModel.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookBaseModel.h"
@interface BookContentModel : BookBaseModel
@property(nonatomic,strong) NSString *did;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *bid;
@property(nonatomic,strong) NSString *parentid;
@property(nonatomic,strong) NSString *isparent;
@property(nonatomic,strong) NSString *content;

@end
