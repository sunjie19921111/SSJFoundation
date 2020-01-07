//
//  NSNumber+PL_Providence.m
//  EvianFutures-OC
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/9/27.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "NSNumber+PL_Providence.h"

@implementation NSNumber (PL_Providence)


/* 将字符串转换为小数对象 */
- (NSDecimalNumber *)PL_ProvidencedigitalValue {
    
    NSDecimalNumber *decimalNum = nil;
    
    if (self && [self isKindOfClass:[NSNumber class]]) {
        decimalNum = [[self stringValue] PL_ProvidencedigitalValue];
    }
    
    return decimalNum;
}

@end
