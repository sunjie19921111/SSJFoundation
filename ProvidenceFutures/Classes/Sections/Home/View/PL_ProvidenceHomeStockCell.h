//
//  PL_ProvidenceHomeStockCell.h
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PL_ProvidenceHomeStockModel;
NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeStockCell : UITableViewCell

- (void)updateWithDataModel:(PL_ProvidenceHomeStockModel *)model indexPath:(NSIndexPath *)index;

@end

NS_ASSUME_NONNULL_END
