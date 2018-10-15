//
//  AppUntil.m
//  zyt_ydd
//
//  Created by perfay on 2018/9/28.
//  Copyright © 2018年 perfay. All rights reserved.
//

#import "AppUntil.h"

@implementation AppUntil

static NSDateFormatter *dateFormatter = nil;

+ (NSDateFormatter *)cachedDateFormatter {
    
    
    if (!dateFormatter) {
        
        dateFormatter = [[NSDateFormatter alloc] init];
        
        [dateFormatter setLocale:[NSLocale currentLocale]];
        
        [dateFormatter setDateFormat: @"YYYY-MM-dd HH:mm:ss"];
        
    }
    
    return dateFormatter;
    
}

+ (BOOL)isToday:(NSDate *)date
{
    //now: 2015-09-05 11:23:00
    //self 调用这个方法的对象本身
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear ;
    
    //1.获得当前时间的 年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    //2.获得self
    NSDateComponents *selfCmps = [calendar components:unit fromDate:date];
    
    return (selfCmps.year == nowCmps.year) && (selfCmps.month == nowCmps.month) && (selfCmps.day == nowCmps.day);
}

@end
