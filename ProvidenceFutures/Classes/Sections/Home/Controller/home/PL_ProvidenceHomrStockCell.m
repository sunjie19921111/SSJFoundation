//
//  PL_ProvidenceHomrStockCell.m
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

#import "PL_ProvidenceHomrStockCell.h"

@implementation PL_ProvidenceHomrStockCell

-(void)setModel:(PL_ProvidenceHomeStockModel *)model {
    _model = model;
    
    self.nameLabel.text = model.name;
    self.symbol.text = model.code;
    self.priceLabel.text = model.trade;
    self.dyLabel.text = model.changepercent;
}

@end
