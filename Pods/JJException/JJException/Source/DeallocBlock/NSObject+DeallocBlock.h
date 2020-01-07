//
//  NSObject+DeallocBlock.h
//  JJException
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Jezz on 2018/9/15.
//  Copyright © 2018年 Jezz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DeallocBlock)

/**
 Observer current instance class dealloc action

 @param block dealloc callback
 */
- (void)jj_deallocBlock:(void(^)(void))block;

@end
