//
//  UIAlertView+PL_Providence.h
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


#import <UIKit/UIKit.h>
typedef void (^AlertBlock)(NSInteger);
NS_ASSUME_NONNULL_BEGIN

@interface UIAlertView (PL_Providence)

- (void)PL_ProvidenceshowAlertWithCompletionHandler: (__nullable AlertBlock)block;
- (void)PL_ProvidenceclearActionBlock;

@end

NS_ASSUME_NONNULL_END
