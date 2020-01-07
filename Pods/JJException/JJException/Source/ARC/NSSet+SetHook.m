//
//  NSSet+SetHook.m
//  JJException
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Jezz on 2018/11/11.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import "NSSet+SetHook.h"
#import "NSObject+SwizzleHook.h"
#import "JJExceptionProxy.h"
#import "JJExceptionMacros.h"

JJSYNTH_DUMMY_CLASS(NSSet_SetHook)

@implementation NSSet (SetHook)

+ (void)jj_swizzleNSSet{
    [NSSet jj_swizzleClassMethod:@selector(setWithObject:) withSwizzleMethod:@selector(hookSetWithObject:)];
}

+ (instancetype)hookSetWithObject:(id)object{
    if (object){
        return [self hookSetWithObject:object];
    }
    handleCrashException(JJExceptionGuardArrayContainer,@"NSSet setWithObject nil object");
    return nil;
}

@end
