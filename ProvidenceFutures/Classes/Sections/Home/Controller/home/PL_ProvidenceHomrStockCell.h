//
//  PL_ProvidenceHomrStockCell.h
//  ProvidenceFutures
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/12/3.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PL_ProvidenceHomeStockModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomrStockCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *symbol;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dyLabel;

@property (nonatomic, strong) PL_ProvidenceHomeStockModel *model;


@end

NS_ASSUME_NONNULL_END
