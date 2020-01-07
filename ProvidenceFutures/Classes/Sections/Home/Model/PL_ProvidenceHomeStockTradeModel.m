//
//  PL_ProvidenceHomeStockTradeModel.m
//  QWEStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/5/5.
//  Copyright © 2019 ASO. All rights reserved.
//

#import "PL_ProvidenceHomeStockTradeModel.h"


/** 便利构造器  */

@implementation PL_ProvidenceHomeStockTradeModel

+ (instancetype)tradeModelWithHands:(NSUInteger)hands price:(CGFloat)price isSell:(BOOL)isSell {
    PL_ProvidenceHomeStockTradeModel *model = [[PL_ProvidenceHomeStockTradeModel alloc] init];
    
    model.hands = hands > 0 ? hands : 0;
    model.price = price > 0 ? price : 0.0f;
    model.isSell = isSell;
    model.stamp = [[NSDate date] timeIntervalSince1970];
    return model;
}

@end
