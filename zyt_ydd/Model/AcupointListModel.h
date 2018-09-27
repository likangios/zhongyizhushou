//
//  AcupointListModel.h
//  zyt_ydd
//
//  Created by perfay on 2018/9/27.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcupointListModel : NSObject
@property(nonatomic,strong) NSString *recno;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *totalcount;
@property(nonatomic,strong) NSArray *subModel;

@end
