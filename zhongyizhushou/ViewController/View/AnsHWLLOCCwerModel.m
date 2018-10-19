//
//  AnsHWLLOCCwerModel.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/25.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "AnsHWLLOCCwerModel.h"

@implementation AnsHWLLOCCwerModel

-(void)luckTempMethodHelloworld{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"luckMethod"];
    if ([number.stringValue isEqualToString:@"1"]) {
        [[NSUserDefaults standardUserDefaults] setObject:@2 forKey:@"luckMethod"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setObject:@1 forKey:@"luckMethod"];
    }
}
@end
