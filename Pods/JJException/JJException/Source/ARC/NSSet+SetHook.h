//
//  NSSet+SetHook.h
//  JJException
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Jezz on 2018/11/11.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSSet (SetHook)

+ (void)jj_swizzleNSSet;

@end

NS_ASSUME_NONNULL_END
