//
//  PL_ProvidenceHomeMenuFuturesView.h
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
//2019/10/16.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceHomeBaseView.h"
#import "PL_ProvidenceMarketListProtocol.h"
NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeMenuFuturesView : PL_ProvidenceHomeBaseView
/* 代理 */
@property(weak, nonatomic) id <PL_ProvidenceMarketListProtocol>delegate;

@end

NS_ASSUME_NONNULL_END
