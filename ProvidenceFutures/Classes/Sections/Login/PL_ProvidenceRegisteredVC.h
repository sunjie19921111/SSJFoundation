//
//  RMS_RegisteredViewController.h
//  ThinkThink_oc
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// apple  on 2019/8/8.
//  Copyright © 2019 apple . All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,PL_ProvidenceLoginType) {
    PL_ProvidenceLoginTypeRegistered = 1,
    PL_ProvidenceLoginTypeForgetPassword,
};

@interface PL_ProvidenceRegisteredVC : UIViewController


@property (nonatomic, assign) PL_ProvidenceLoginType type;


@end

NS_ASSUME_NONNULL_END
