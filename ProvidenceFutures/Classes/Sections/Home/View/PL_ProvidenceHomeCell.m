//
//  PL_ProvidenceHomeCell.m
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

#import "PL_ProvidenceHomeCell.h"

@interface PL_ProvidenceHomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *percentageLabel;

@end

@implementation PL_ProvidenceHomeCell

- (void)refreshData:(PL_ProvidenceHomeStockModel *)model {
    self.priceLabel.text = model.trade;
    self.nameLabel.text = model.name;
    self.percentageLabel.text = model.changepercent;
}

@end
