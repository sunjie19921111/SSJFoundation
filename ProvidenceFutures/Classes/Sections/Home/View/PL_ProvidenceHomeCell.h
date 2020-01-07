//
//  PL_ProvidenceHomeCell.h
//  HuiSurplusFutures
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/11/5.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_ProvidenceHomeStockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeCell : UICollectionViewCell

- (void)refreshData:(PL_ProvidenceHomeStockModel *)model;

@end

NS_ASSUME_NONNULL_END
