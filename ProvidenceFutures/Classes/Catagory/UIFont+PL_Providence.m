//
//  UIFont+PL_Providence.m
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
//2019/9/26.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "UIFont+PL_Providence.h"

@implementation UIFont (PL_Providence)

/**
 根据设备尺寸适配字体大小
 
 @param size 字体大小
 @return 字体对象
 */
+ (instancetype)PL_ProvidencesystemFontOfSize:(CGFloat)size {
    return [UIFont systemFontOfSize:[self PL_ProvidencescaleFontSize:size]];
}

/**
 根据设备计算字体大小
 
 @param size 原始尺寸大小
 @return 适配后的尺寸大小
 */
+ (CGFloat)PL_ProvidencescaleFontSize:(CGFloat)size {
    
    if (PL_ProvidenceiPhone_4x) {
        size *= 0.84;
    }
    if (PL_ProvidenceiPhone_5x) {
        size *= 0.84;
    }
    if (PL_ProvidenceiPhone_6x || PL_ProvidenceiPhone_X) {
        size *= 1;
    }
    if (PL_ProvidenceiPhone_plus || PL_ProvidenceiPhone_X_Max) {
        size *= 1.1;
    }
    
    return size;
}

@end
