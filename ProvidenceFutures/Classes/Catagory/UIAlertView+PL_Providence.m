//
//  UIAlertView+PL_Providence.m
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

#import "UIAlertView+PL_Providence.h"
#import <objc/runtime.h>

static char kUIAlertViewBlockAddress;

@implementation UIAlertView (PL_Providence)

- (void)PL_ProvidenceshowAlertWithCompletionHandler: (void (^)(NSInteger))block
{
    self.delegate = self;
    objc_setAssociatedObject(self,&kUIAlertViewBlockAddress,block,OBJC_ASSOCIATION_COPY);
    [self show];
}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    AlertBlock block = objc_getAssociatedObject(self, &kUIAlertViewBlockAddress);
    if (block)
    {
        block(buttonIndex);
        objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, nil, OBJC_ASSOCIATION_COPY);
    }
}

- (void)PL_ProvidenceclearActionBlock
{
    self.delegate = nil;
    objc_setAssociatedObject(self, &kUIAlertViewBlockAddress, nil, OBJC_ASSOCIATION_COPY);
}

@end
