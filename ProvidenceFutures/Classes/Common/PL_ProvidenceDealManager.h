//
//  PL_ProvidenceDealManager.h
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
//2019/9/29.
//  Copyright © 2019 qhwr. All rights reserved.
//'





#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN



@interface PL_ProvidenceDealData : NSObject

@property (nonatomic, copy) NSString *totalValue;
@property (nonatomic, copy) NSString *onDayyk;
@property (nonatomic, copy) NSString *totalyk;
@property (nonatomic, copy) NSString *totalIntegral;
@property (nonatomic, copy) NSString *availableIntegral;


@end

@interface PL_ProvidenceDealManager : NSObject


@property (nonatomic, strong) PL_ProvidenceDealData *currentModel;
- (void)start;
+ (instancetype)sharedManager;




@end

NS_ASSUME_NONNULL_END
