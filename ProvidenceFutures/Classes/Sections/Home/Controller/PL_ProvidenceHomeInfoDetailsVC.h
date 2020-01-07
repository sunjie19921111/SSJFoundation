//
//  PL_ProvidenceHomeInfoDetailsVC.h
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/17.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_ProvidenceHomeStockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeInfoDetailsVC : UIViewController


- (instancetype)initWithMarketListModel:(PL_ProvidenceHomeStockModel * _Nonnull)marketListModel marketCode:(NSString *)marketCode;


@property (nonatomic, assign) BOOL isMarket;


@end

NS_ASSUME_NONNULL_END
