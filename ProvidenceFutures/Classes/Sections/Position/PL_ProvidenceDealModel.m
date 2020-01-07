//
//  PL_ProvidenceDealModel.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/25.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceDealModel.h"

@implementation PL_ProvidenceDealModel


- (instancetype)initWithconvertListModel:(PL_ProvidenceHomeStockModel *)model {
    if (self = [super init]) {
        PL_ProvidenceDealModel *pmodel =  [[PL_ProvidenceDataManager manager] getMyCacheModelSymbol:model.symbol];
        
        self.symbol = model.symbol;
        self.name = model.name;
        self.code = model.code;
        self.postion = model.hands;
        self.availPosition = self.postion;
        self.time = [NSString localStringFromUTCDate:[NSDate date]];

        
        if (pmodel) {
            self.avgPrice = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[NSString stringWithFormat:@"%f",([model.trade doubleValue] + [pmodel.avgPrice doubleValue])/2] decimalsLimit:2 prefix:@"" suffix:@""];;
        } else {
            self.avgPrice = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[NSString stringWithFormat:@"%@",model.trade] decimalsLimit:2 prefix:@"" suffix:@""];;
        }
        

        self.priceNow = self.avgPrice;
        
        self.marketValue =  [NSString PL_ProvidencefixNumString:[@([self.priceNow doubleValue] * [self.postion doubleValue]) stringValue] minDecimalsLimit:2 maxDecimalsLimit:2];
        

//        double profitRate = ([self.priceNow doubleValue] - [self.avgPrice doubleValue]) / [self.avgPrice doubleValue];
//        self.profit = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[@(profit) stringValue] decimalsLimit:2 prefix:@"" suffix:@""];
        
        self.profit = @"0.00";
        self.profitRate = @"0.00%%";
        
        self.totalProfit = @"0.00";
        self.totalProfitRate = @"0.00%%";

    }
    return self;
}


+ (instancetype _Nullable)positionModelWithName:(NSString *)name code:(NSString *)code symbol:(NSString *)symbol {
    PL_ProvidenceDealModel *model = [[PL_ProvidenceDealModel alloc] init];
    model.name = name;
    model.code = code;
    
    if (!isStrEmpty(symbol) && [symbol containsString:@"."] && ([symbol containsString:@"SS"] || [symbol containsString:@"SZ"])) {
        model.symbol = symbol;
    }else {
        
        model = nil;
    }
    
    return model;
}


//- (NSString *)profit {
//    if (isStrEmpty(_profit)) {
//       _profit = [@(roundf(([self.priceNow floatValue] - [self.avgPrice floatValue]) * [self.postion integerValue])) stringValue];
//    }
//    return _profit;
//}
//
//- (NSString *)profitRate {
//    if (isStrEmpty(_profitRate)) {
//        _profitRate = [@(([self.priceNow floatValue] - [self.avgPrice floatValue]) / [self.avgPrice floatValue] * 100) stringValue];
//        _profitRate = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:_profitRate decimalsLimit:2 prefix:@"" suffix:@"%"];
//    }
//    return _profitRate;
//}

//- (void)setPriceNow:(NSString *)priceNow {
//    if ([priceNow doubleValue] > 0) {
//        
//        if (![priceNow isKindOfClass:[NSString class]]) {
//            
//            _priceNow = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[NSString stringWithFormat:@"%@",priceNow] decimalsLimit:2 prefix:@"" suffix:@""];
//        }else {
//            _priceNow = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:priceNow decimalsLimit:2 prefix:@"" suffix:@""];
//        }
//        
//        [self PL_ProvidencerefreshData];
//    }
//}
//
//- (NSString *)marketValue {
//    if (isStrEmpty(_marketValue)) {
//        _marketValue = [@([self.priceNow floatValue] * [self.postion integerValue]) stringValue];
//        _marketValue = [NSString PL_ProvidencefixNumString:_marketValue minDecimalsLimit:2 maxDecimalsLimit:2];
//    }
//    return _marketValue;
//}


#pragma mark - 扩展方法 --
//
//- (void)addNewTrade:(PL_ProvidenceHomeStockTradeModel *)trade {
//    if (trade) {
//        NSMutableArray *tempTradeHis = [self.tradeHis mutableCopy] ? : @[].mutableCopy;
//        [tempTradeHis addObject:trade];
//        self.tradeHis = [NSArray arrayWithArray:tempTradeHis];
//        self.priceNow = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[@(trade.price) stringValue] decimalsLimit:2 prefix:@"" suffix:@""];
//        [self PL_ProvidencerefreshData];
//    }
//}

//- (void)PL_ProvidencerefreshData {
//
//    // TODO: 更新数据
//    double buy = 0.0f;
//    double sell = 0.0f;
//
//    double recentBuy = 0.0f;
//
//
//    NSInteger buyPostionHands = 0;      // 买入的持仓
//    NSInteger positionHands = 0;        // 总的持仓
//    NSInteger unAvailPosition = 0;      // 不可用的持仓
//
//    NSEnumerator *enumrator = [self.tradeHis reverseObjectEnumerator];
//    NSArray *reverseList = [enumrator allObjects];
//
//    for (int i = 0;i < reverseList.count ; i ++) {
//        PL_ProvidenceHomeStockTradeModel *tradeModel = [reverseList objectAtIndex:i];
//
//        if (tradeModel.isSell) {
//            // 卖
//            positionHands -= tradeModel.hands;
//            sell += tradeModel.hands *tradeModel.price;
//
//        }else {
//            // 买
//            if (positionHands == 0) {
//                buyPostionHands = 0;
//                recentBuy = 0.0f;
//            }
//
//            NSDate *todayDate = [NSString PL_ProvidencegetTodayStartStamp];
//
//            if (tradeModel.stamp > [todayDate timeIntervalSince1970]) {
//                unAvailPosition += tradeModel.hands;
//            }
//
//            positionHands += tradeModel.hands;
//            buyPostionHands += tradeModel.hands;
//            buy += tradeModel.hands * tradeModel.price;
//            recentBuy += tradeModel.hands * tradeModel.price;
//        }
//    }
//
//    // 开仓均价
//    self.avgPrice = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[@(recentBuy / buyPostionHands) stringValue] decimalsLimit:2 prefix:@"" suffix:@""];
//    // 持仓量
//    self.postion = [@(positionHands) stringValue];
//
//    NSInteger availPosition = (positionHands - unAvailPosition) > 0 ? (positionHands - unAvailPosition) : 0;
//
//    // 可用持仓量
//    self.availPosition = [@(availPosition) stringValue];
//    // 总收益
//    double totalProfit = (sell - buy) + (positionHands * [self.priceNow doubleValue]);
//    self.totalProfit = [@(totalProfit) stringValue];
//    // 总收益率
//    double totalProfitRate = totalProfit / buy;
//    self.totalProfitRate = [@(totalProfitRate) stringValue];
//    // 最近收益
//    double profit = ([self.priceNow doubleValue] - [self.avgPrice doubleValue]) * positionHands;
//    double profitRate = ([self.priceNow doubleValue] - [self.avgPrice doubleValue]) / [self.avgPrice doubleValue];
//    self.profit = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[@(profit) stringValue] decimalsLimit:2 prefix:@"" suffix:@""];
//    self.profitRate = [NSString stringWithFormat:@"%.2f%%",profitRate * 100];
//    // 市值
//    self.marketValue = [NSString PL_ProvidencefixNumString:[@([self.avgPrice doubleValue] * [self.postion doubleValue]) stringValue] minDecimalsLimit:2 maxDecimalsLimit:2];
////    self.positionRate = [NSString stringWithFormat:@"%.2f%%",[self.marketValue doubleValue] / [[PL_ProvidenceSimulateManager manager] getTotalCapital]];
//
//}

@end
