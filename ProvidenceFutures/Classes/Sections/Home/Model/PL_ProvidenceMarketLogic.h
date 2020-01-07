//
//  PL_ProvidenceMarketLogic.h
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PL_ProvidenceHomeStockModel,PL_ProvidenceHomeOrderModel,PL_ProvidenceKLineModel;
NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceMarketLogic : NSObject

/**
 获得市场下的股票列表

 @param code 市场代码
 @param page 页数
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getMarketListDateWithCode:(NSString *)code page:(NSInteger)page success:(void (^)(NSArray <PL_ProvidenceHomeStockModel *> * list))suc faild:(void (^)(NSError *error))faild;

/**
 获得股票挂单的详情
 
 @param market 股票市场
 @param symbol 股票代码
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getMarketOrderBookDateWithMarket:(NSString *)market symbol:(NSString *)symbol success:(void (^)(NSArray <PL_ProvidenceHomeOrderModel *> * buyList, NSArray <PL_ProvidenceHomeOrderModel *> *sellList))suc faild:(void (^)(NSError *error))faild;


+ (void)getMarketDetailhMarket:(NSString *)market symbol:(NSString *)symbol uccess:(void (^)(PL_ProvidenceHomeStockModel *model))suc faild:(void (^)(NSError *error))faild;

+ (void)getFutureDetailhMarket:(NSString *)market symbol:(NSString *)symbol uccess:(void (^)(PL_ProvidenceHomeStockModel *model))suc faild:(void (^)(NSError *error))faild;

+ (void)getFuturesListDateWithCode:(NSString *)code page:(NSInteger)page success:(void (^)(NSArray <PL_ProvidenceHomeStockModel *> * list))suc faild:(void (^)(NSError *error))faild;

/**
 根据周期获得所传参数的时间间隔

 @param timeType 时间周期(1日、1周)
 @return 时间间隔，1分=60，1日=86400
 */
+ (NSString *)getTimeInervalWithTimeType:(NSString *)timeType;

/**
 获得股票K线数据
 
 @param marketCode 股票市场代号
 @param market  股票市场
 @param symbol 股票代码
 @param timeInterval K线周期
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getKlineDateWithMarketCode:(NSString *)marketCode market:(NSString *)market symbol:(NSString *)symbol timeType:(NSString *)timeInterval success:(void (^)(NSArray <PL_ProvidenceKLineModel *> * klineArray))suc faild:(void (^)(NSError *error))faild;

/**
 搜索股票
 
 @param symbol 股票代码
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)searchStockDataWithSymbol:(NSString *)symbol success:(void (^)(NSArray <PL_ProvidenceHomeStockModel *> * searchList))suc faild:(void (^)(NSError *error))faild;


/* 市场列表及对应名称 */
+ (NSArray <NSDictionary *> *)getMarketList;
/* 市场名称 */
+ (NSArray <NSString *> *)getMarketNames;
//获取期货列表及名称
+ (NSArray <NSDictionary *> *)getFuturesList;
//获取期货名称
+ (NSArray <NSString *> *)getFuturesNames;

@end

NS_ASSUME_NONNULL_END
