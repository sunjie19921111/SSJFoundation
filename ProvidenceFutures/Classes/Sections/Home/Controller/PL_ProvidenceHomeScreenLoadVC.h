//
//  PL_ProvidenceHomeScreenLoadVC.h
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
@class PL_ProvidenceHomeStockModel;
NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeScreenLoadVC : UIViewController


- (instancetype)initWithModel:(PL_ProvidenceHomeStockModel *)listModel marketCode:(NSString *)marketCode;

@end

NS_ASSUME_NONNULL_END
