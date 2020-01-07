//
//  PL_ProvidenceHomeStockView.h
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceHomeBaseView.h"
#import "PL_ProvidenceMarketListProtocol.h"
@class PL_ProvidenceHomeStockView,PL_ProvidenceHomeStockModel;
NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeStockView : PL_ProvidenceHomeBaseView
/* 代理 */
@property(weak, nonatomic) id <PL_ProvidenceMarketListProtocol>delegate;

@end

NS_ASSUME_NONNULL_END
