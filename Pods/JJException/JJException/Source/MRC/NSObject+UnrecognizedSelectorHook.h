//
//  NSObject+UnrecognizedSelectorHook.h
//  JJException
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Jezz on 2018/7/11.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (UnrecognizedSelectorHook)

+ (void)jj_swizzleUnrecognizedSelector;

@end
