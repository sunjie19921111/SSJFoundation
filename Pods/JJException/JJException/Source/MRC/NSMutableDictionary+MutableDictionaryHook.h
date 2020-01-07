//
//  NSMutableDictionary+MutableDictionaryHook.h
//  JJException
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Jezz on 2018/7/15.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (MutableDictionaryHook)

+ (void)jj_swizzleNSMutableDictionary;

@end
