//
//  BookConteXGQZMODntModel.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BookXGQZMODBaseModel.h"
@interface BookConteXGQZMODntModel : BookXGQZMODBaseModel

@property(nonatomic,strong) NSString *uuid;

@property(nonatomic,strong) NSString *did;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *bid;
@property(nonatomic,strong) NSString *parentid;
@property(nonatomic,strong) NSString *isparent;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSString *following;

@end
