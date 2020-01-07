//
//  PL_ProvidenceDealModel.h
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/25.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PL_ProvidenceHomeStockTradeModel.h"
#import "PL_ProvidenceHomeStockModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceDealModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *buySell;

@property (nonatomic, copy) NSString *dateString;

/** name */
@property (strong, nonatomic) NSString *name;

/** code */
@property (strong, nonatomic) NSString *code;

/** symbol */
@property (strong, nonatomic) NSString *symbol;

/** 成交记录 */
@property (strong, nonatomic) NSArray <PL_ProvidenceHomeStockTradeModel *>*tradeHis;

/** 买入成本价 */
@property (strong, nonatomic) NSString *avgPrice;

/** 现价 */
@property (strong, nonatomic) NSString *priceNow;
@property (strong, nonatomic) NSString *settlement;
/** 持仓量 */
@property (strong, nonatomic) NSString *postion;

/** 可用持仓量 */
@property (strong, nonatomic) NSString *availPosition;

/** 盈亏 */
@property (strong, nonatomic) NSString *profit;

/** 盈亏率 */
@property (strong, nonatomic) NSString *profitRate;

/** 总收益 */
@property (strong, nonatomic) NSString *totalProfit;

/** 总收益率  */
@property (strong, nonatomic) NSString *totalProfitRate;

/** 仓位率 */
@property (strong, nonatomic) NSString *positionRate;

/** 市值 */
@property (strong, nonatomic) NSString *marketValue;

@property (strong, nonatomic) NSString *identifier;

@property (strong, nonatomic) NSString *time;

//+ (instancetype)createTestModel;

/** 返回空说明当前股票或指数不符合模拟交易条件 */
+ (instancetype _Nullable)positionModelWithName:(NSString *)name code:(NSString *)code symbol:(NSString *)symbol;

/**
 添加一笔新的交易

 @param trade 交易模型
 */
- (instancetype)initWithconvertListModel:(PL_ProvidenceHomeStockModel *)model;
//
//- (instancetype)initWithconvertListModel:(PL_ProvidenceHomeStockModel *)model;

@end

NS_ASSUME_NONNULL_END
