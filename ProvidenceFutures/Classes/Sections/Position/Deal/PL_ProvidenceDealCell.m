//
//  PL_ProvidenceDealCell.m
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

#import "PL_ProvidenceDealCell.h"

@implementation PL_ProvidenceDealCell

- (void)setModel:(PL_ProvidenceDealModel *)model {
    _model = model;
    model.priceNow = [model.priceNow stringByReplacingOccurrencesOfString:@"," withString:@""];
    model.avgPrice = [model.avgPrice stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    self.nameLabel.text = model.name;
    self.timeLabel.text = model.dateString;
    
    self.currentValueLabel.text  = [NSString stringWithFormat:@"%.2f",[model.postion floatValue] * [model.priceNow floatValue]];
    
    NSString *postion = [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] - [model.avgPrice doubleValue]) * [model.postion doubleValue]];
    NSString *postionRate = [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] *  [model.postion doubleValue]) / ([model.postion doubleValue] * [model.avgPrice doubleValue]) - 1.00] ;
    
    self.dyYkLabel.text = [NSString stringWithFormat:@"%.2f%%",[postionRate doubleValue] * 100];
    
    self.nowPrice.text = [NSString stringWithFormat:@"%.2f",[model.priceNow doubleValue]];
    
    self.dyAvailableLabel.text = model.postion;
    
}

//- (void)refreshData:(PL_ProvidenceDealModel *)model indexRow:(NSInteger)row {
//    model.priceNow = [model.priceNow stringByReplacingOccurrencesOfString:@"," withString:@""];
//    model.avgPrice = [model.avgPrice stringByReplacingOccurrencesOfString:@"," withString:@""];
//    if (row == 0) {
//        self.mainTitleLabel.text = @"名称/市值";
//        self.subTitleLabel.text = model.name;
//        self.desTitleLabel.text = [NSString stringWithFormat:@"%.2f",[model.postion floatValue] * [model.priceNow floatValue]];
//    } else if (row == 1) {
//        self.mainTitleLabel.text = @"持仓盈亏";
//        NSString *postion = [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] - [model.avgPrice doubleValue]) * [model.postion doubleValue]];
//        NSString *postionRate = [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] *  [model.postion doubleValue]) / ([model.postion doubleValue] * [model.avgPrice doubleValue]) - 1.00] ;
//        self.subTitleLabel.text = postion;
//
//        self.desTitleLabel.text = [NSString stringWithFormat:@"%.2f%%",[postionRate doubleValue] * 100];
//    } else if (row == 2) {
//        self.mainTitleLabel.text = @"持仓可用";
//        self.subTitleLabel.text = model.postion;
//        self.desTitleLabel.text = model.postion;;
//    } else if (row == 3) {
//        self.mainTitleLabel.text = @"成本/现价";
//        self.subTitleLabel.text = model.avgPrice;
//        self.desTitleLabel.text = [NSString stringWithFormat:@"%.2f",[model.priceNow doubleValue]];
//    } else if (row == 4) {
//        self.mainTitleLabel.text = @"当日盈亏";
//        self.subTitleLabel.text = @"";
//        
//        NSInteger result = [NSString compareDate:model.time withDate:[NSString localStringFromUTCDate:[NSDate date]]];
//        if (result == 0) {
//            self.desTitleLabel.text = @"----";
//        } else {
//            self.desTitleLabel.text =  [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] - [model.settlement doubleValue]) * [model.postion doubleValue]];
//        }
//    }
//}

@end
