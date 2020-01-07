//
//  UIActionSheet+PL_Providence.h
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
//2019/9/25.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^ActionSheetBlock)(NSInteger);

@interface UIActionSheet (PL_Providence)<UIActionSheetDelegate>
- (void)showInView: (UIView *)view completionHandler: (ActionSheetBlock)block;
- (void)clearActionBlock;

@end

NS_ASSUME_NONNULL_END
