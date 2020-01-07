//
//  PL_ProvidenceHomeStockParticularsView.h
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

@interface PL_ProvidenceHomeStockParticularsView : UIView


- (void)updateDataWithModel:(PL_ProvidenceHomeStockModel *)model;

- (instancetype)initWithFrame:(CGRect)frame contractModel:(PL_ProvidenceHomeStockModel *)model;

@end

NS_ASSUME_NONNULL_END
