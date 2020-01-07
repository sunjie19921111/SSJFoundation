//
//  PL_ProvidenceMarketLogic.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceHomeStockModel.h"
#import "PL_ProvidenceHomeOrderModel.h"
#import "PL_ProvidenceKLineModel.h"
#import "PL_ProvidenceMarketLogic.h"
#import <MFNetworkManager/MFNetworkManager.h>


@implementation PL_ProvidenceMarketLogic

/**
 根据周期获得所传参数的时间间隔
 
 @param timeType 时间周期(1日、1周)
 @return 时间间隔，1分=60，1日=86400
 */
+ (NSString *)getTimeInervalWithTimeType:(NSString *)timeType {
    
    NSDictionary *timeInfo = @{
                               @"分时":@"60",
                               @"1分":@"60",
                               @"5分":@"300",
                               @"15分":@"900",
                               @"30分":@"1800",
                               @"1时":@"3600",
                               @"1日":@"86400",
                               @"1周":@"604800",
                               @"1月":@"2592000"
                               };
    
    NSString *ret = [timeInfo objectForKey:timeType];
    
    if (isStrEmpty(ret) || [ret integerValue] < 60) {
        ret = @"60";
    }
    
    return ret;
}


/**
 获得股票K线数据
 
 @param marketCode 股票市场代号
 @param market  股票市场
 @param symbol 股票代码
 @param timeInterval K线周期
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getKlineDateWithMarketCode:(NSString *)marketCode market:(NSString *)market symbol:(NSString *)symbol timeType:(NSString *)timeInterval success:(void (^)(NSArray <PL_ProvidenceKLineModel *> * klineArray))suc faild:(void (^)(NSError *error))faild {
    
    NSString *suffix = @"";
    
    if ([marketCode isEqualToString:@"sz"]) {
        suffix = @"SZ";
    }else if([marketCode isEqualToString:@"sh"]){
        suffix = @"SS";
    }else if([marketCode isEqualToString:@"hk"]) {
        suffix = @"HKEX";
    }else if([marketCode isEqualToString:@"usa"]) {
        suffix = [market substringToIndex:4];
    }
    
    NSString *prod_code = symbol;
    if (![prod_code containsString:@"."]) {
        prod_code = [NSString stringWithFormat:@"%@.%@",symbol,suffix];
    }
    
    NSDictionary *params = @{@"token":@"3f39051e89e1cea0a84da126601763d8",@"prod_code":prod_code,@"period_type":timeInterval,@"tick_count":@"600",@"fields":@"tick_at,open_px,close_px,high_px,low_px,turnover_volume"};
     NSString *url = [NSString stringWithFormat:@"%@%@",@"http://data.api51.cn/apis/integration/",@"kline"];
    [PL_ProvidenceHttpRequest getWithURL:url params:params completion:^(NSError *error, id responseObject) {
        if (!error) {
            NSMutableArray *klineArray = @[].mutableCopy;
            if (responseObject) {
                NSDictionary *data = [responseObject objectForKey:@"data"];
                if (data && data.count > 0) {
                    NSDictionary *candle = [data objectForKey:@"candle"];
                    NSDictionary *stockData = [candle objectForKey:prod_code];
                    NSArray *tempArray = [stockData objectForKey:@"lines"];
                    
                    for(int i = 0; i < tempArray.count ;i ++) {
                        
                        NSArray *tempLineArray = [tempArray objectAtIndex:i];
                        PL_ProvidenceKLineModel *model = [PL_ProvidenceKLineModel createWithArray:tempLineArray];
                        [klineArray addObject:model];
                    }
                }
            }
            
            !suc ? : suc(klineArray);
        } else {
            !faild ? : faild(error);
        }
    }];
    
//
//        [[HttpRequest sharedInstance]oneGet:APIBaseURL_51 path:@"kline" parameters:params success:^(id responsData) {
//
//        NSMutableArray *klineArray = @[].mutableCopy;
//        if (responsData) {
//            NSDictionary *data = [responsData objectForKey:@"data"];
//            if (data && data.count > 0) {
//                NSDictionary *candle = [data objectForKey:@"candle"];
//                NSDictionary *stockData = [candle objectForKey:prod_code];
//                NSArray *tempArray = [stockData objectForKey:@"lines"];
//
//                for(int i = 0; i < tempArray.count ;i ++) {
//
//                    NSArray *tempLineArray = [tempArray objectAtIndex:i];
//                    PL_ProvidenceKLineModel *model = [PL_ProvidenceKLineModel createWithArray:tempLineArray];
//                    [klineArray addObject:model];
//                }
//            }
//        }
//
//        !suc ? : suc(klineArray);
//    } faile:^(NSError *error) {
//        !faild ? : faild(error);
//    }];
}


/**
 获得市场下的股票列表
 
 @param code 市场代码
 @param page 页数
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getMarketListDateWithCode:(NSString *)code page:(NSInteger)page success:(void (^)(NSArray <PL_ProvidenceHomeStockModel *> * list))suc faild:(void (^)(NSError *error))faild {
    
    NSString *path = [NSString stringWithFormat:@"%@list",code];
    NSString *pageString = [NSString stringWithFormat:@"%ld",page <= 1 ? 1 : page];
    NSString *url = [NSString stringWithFormat:@"%@%@",@"http://47.110.124.138:8081/stock/api/",STRINGNOTNIL(path)];
     NSDictionary *dict = @{@"page":pageString};
    [PL_ProvidenceHttpRequest getWithURL:url params:dict completion:^(NSError *error, id responseObject) {
         [SVProgressHUD dismiss];
        if (!error) {
            NSArray *models = [PL_ProvidenceHomeStockModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
              !suc ? : suc(models);
        } else {
             !faild ? : faild(error);
        }
    }];
}

/**
 获得市场下的股票列表
 
 @param code 市场代码
 @param page 页数
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getFuturesListDateWithCode:(NSString *)code page:(NSInteger)page success:(void (^)(NSArray <PL_ProvidenceHomeStockModel *> * list))suc faild:(void (^)(NSError *error))faild {
    
    NSString *path = [NSString stringWithFormat:@"%@list",code];
    NSString *pageString = [NSString stringWithFormat:@"%ld",page <= 1 ? 1 : page];
    NSString *url = [NSString stringWithFormat:@"%@%@",@"http://47.110.124.138:8081/future/api/",STRINGNOTNIL(path)];
    NSDictionary *dict = @{@"page":pageString};
    [MFNETWROK get:url params:dict success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        if (statusCode == 200) {
            NSArray *models = [PL_ProvidenceHomeStockModel mj_objectArrayWithKeyValuesArray:result[@"data"]];
            !suc ? : suc(models);
        }
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
         !faild ? : faild(error);
    }];
    
    
//    [PL_ProvidenceHttpRequest getWithURL:url params:dict completion:^(NSError *error, id responseObject) {
//        [SVProgressHUD dismiss];
//        if (!error) {
//            NSArray *models = [PL_ProvidenceHomeStockModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
//            !suc ? : suc(models);
//        } else {
//            !faild ? : faild(error);
//        }
//    }];
}


+ (void)getMarketDetailhMarket:(NSString *)market symbol:(NSString *)symbol uccess:(void (^)(PL_ProvidenceHomeStockModel *model))suc faild:(void (^)(NSError *error))faild {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",@"http://47.110.124.138:8081/stock/api/",market,@"detail"];
    NSDictionary *params = @{@"symbol":symbol};
    [PL_ProvidenceHttpRequest getWithURL:url params:params completion:^(NSError *error, id responseObject) {
        if (!error) {
            PL_ProvidenceHomeStockModel *model = [PL_ProvidenceHomeStockModel mj_objectWithKeyValues:responseObject[@"data"]];
            !suc ? : suc(model);
        } else {
            !faild ? : faild(error);
        }
    }];
}

+ (void)getFutureDetailhMarket:(NSString *)market symbol:(NSString *)symbol uccess:(void (^)(PL_ProvidenceHomeStockModel *model))suc faild:(void (^)(NSError *error))faild {
    
    NSString *url = [NSString stringWithFormat:@"%@%@%@",@"http://47.110.124.138:8081/future/api/",market,@"detail"];
    NSDictionary *params = @{@"id":symbol};
    [MFNETWROK get:url params:params success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        if (statusCode == 200) {
            PL_ProvidenceHomeStockModel *model = [PL_ProvidenceHomeStockModel mj_objectWithKeyValues:result[@"data"]];
              !suc ? : suc(model);
        }
        
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        !faild ? : faild(error);
    }];
    
//    [PL_ProvidenceHttpRequest getWithURL:url params:params completion:^(NSError *error, id responseObject) {
//        if (!error) {
//            PL_ProvidenceHomeStockModel *model = [PL_ProvidenceHomeStockModel mj_objectWithKeyValues:responseObject[@"data"]];
//            !suc ? : suc(model);
//        } else {
//            !faild ? : faild(error);
//        }
//    }];
}
/**
 获得股票的详情
 
 @param market 股票市场
 @param symbol 股票代码
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)getMarketOrderBookDateWithMarket:(NSString *)market symbol:(NSString *)symbol success:(void (^)(NSArray <PL_ProvidenceHomeOrderModel *> * buyList, NSArray <PL_ProvidenceHomeOrderModel *> *sellList))suc faild:(void (^)(NSError *error))faild {
    
//    NSString *path = [NSString stringWithFormat:@"%@",market];
    
//    if ([path isEqualToString:@"sh"] || [path isEqualToString:@"sz"]) {
//        path = @"hs";
//    }
//    //http://192.168.0.123/stock/api/usadetail/id/1
    NSString *url = [NSString stringWithFormat:@"%@%@%@",@"http://47.110.124.138:8081/stock/api/",market,@"detail"];
    NSDictionary *params = @{@"symbol":symbol};
    [PL_ProvidenceHttpRequest getWithURL:url params:params completion:^(NSError *error, id responseObject) {
        if (!error) {
            NSArray *buyList = @[];
            NSArray *sellList = @[];
            if (responseObject) {
                
                NSDictionary *result = [responseObject objectForKey:@"data"];
                
                NSDictionary *lists = [self PL_ProvidencecreateHSFOrderBookModelFromData:result ];
                
                if (lists && lists.count > 0) {
                    buyList = [[lists objectForKey:@"buy"] copy];
                    sellList = [[lists objectForKey:@"sell"] copy];
                }
            }
            
            
            !suc ? : suc(buyList,sellList);
        } else {
             !faild ? : faild(error);
        }
    }];

}



/**
 搜索股票
 
 @param symbol 股票代码
 @param suc 成功回调
 @param faild 失败回调
 */
+ (void)searchStockDataWithSymbol:(NSString *)symbol success:(void (^)(NSArray <PL_ProvidenceHomeStockModel *> * searchList))suc faild:(void (^)(NSError *error))faild {
    
    NSString *path = @"real";
    
    NSString *prod_code = symbol;
    if (![prod_code containsString:@"."]) {
        prod_code = [NSString stringWithFormat:@"%@.SS,%@.SZ",symbol,symbol];
    }
    
//    NSDictionary *params = @{@"token":APIKey_51,@"prod_code":prod_code,@"fields":@"prod_code,prod_name,last_px,px_change_rate,high_px,low_px,preclose_px,turnover_volume,turnover_value"};
//    
//        
//        [[HttpRequest sharedInstance]oneGet:APIBaseURL_51 path:path parameters:params success:^(id responsData) {
//            
//        NSArray *list = @[];
//        
//        if (responsData) {
//            NSDictionary *data = [responsData objectForKey:@"data"];
//            if (data && data.count > 0 && [data isKindOfClass:[NSDictionary class]]) {
//                NSDictionary *snapShot = [data objectForKey:@"snapshot"];
//                
//                list = [PL_ProvidenceHomeDataLogic processMarketModelWithSnapShot:snapShot];
//            }
//        }
//        
//        !suc ? : suc(list);
//    } faile:^(NSError *error) {
//        !faild ? : faild(error);
//    }];
}

/* 市场列表及对应名称 */
+ (NSArray <NSDictionary *> *)getMarketList {
    
    NSArray *markets = @[
                         @{@"code":@"sh",@"name":@"沪股"},
                         @{@"code":@"sz",@"name":@"深股"},
                         @{@"code":@"usa",@"name":@"美股"},
                         @{@"code":@"hk",@"name":@"港股"},
                         @{@"code":@"fav",@"name":@"自选"}
                         ];
    return markets;
}

/* 市场名称 */
+ (NSArray <NSString *> *)getMarketNames {
    
    return @[@"沪股",@"深股",@"美股",@"港股",@"自选"];
}

+ (NSArray <NSDictionary *> *)getFuturesList {
    NSArray *markets = @[
                         @{@"code":@"dl",@"name":@"大连"},
                         @{@"code":@"sh",@"name":@"上海"},
                         @{@"code":@"zz",@"name":@"郑州"},
                         ];
    return markets;
}

/* 市场名称 */
+ (NSArray <NSString *> *)getFuturesNames {
    return @[@"大连",@"上海",@"郑州"];
}

#pragma mark - 私有方法 --

+ (NSDictionary *)PL_ProvidencecreateHSFOrderBookModelFromData:(NSDictionary *)data {
    NSDictionary *lists = @{@"buy":@[],@"sell":@[]};
    if (data && [data isKindOfClass:[NSDictionary class]] && data.count > 0) {
        NSMutableArray *buyList = @[].mutableCopy;
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"buy_one_pri"] amount:[data objectForKey:@"buy_one"] isAsk:NO]];
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"buy_two_pri"] amount:[data objectForKey:@"buy_two"] isAsk:NO]];
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"buy_three_pri"] amount:[data objectForKey:@"buy_three"] isAsk:NO]];
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"buy_four_pri"] amount:[data objectForKey:@"buy_four"] isAsk:NO]];
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"buy_five_pri"] amount:[data objectForKey:@"buy_five"] isAsk:NO]];
        
        NSMutableArray *sellList = @[].mutableCopy;
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"sell_one_pri"] amount:[data objectForKey:@"sell_one"] isAsk:YES]];
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"sell_two_pri"] amount:[data objectForKey:@"sell_two"] isAsk:YES]];
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"sell_three_pri"] amount:[data objectForKey:@"sell_three"] isAsk:YES]];
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"sell_four_pri"] amount:[data objectForKey:@"sell_four_pri"] isAsk:YES]];
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:[data objectForKey:@"sell_five_pri"] amount:[data objectForKey:@"sell_five"] isAsk:YES]];
        
        lists = @{@"buy":buyList,@"sell":sellList};
    }else {
        
        NSMutableArray *buyList = @[].mutableCopy;
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:NO]];
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:NO]];
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:NO]];
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:NO]];
        [buyList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:NO]];
        
        NSMutableArray *sellList = @[].mutableCopy;
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:YES]];
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:YES]];
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:YES]];
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:YES]];
        [sellList addObject:[PL_ProvidenceHomeOrderModel createModelWithPrice:nil amount:nil isAsk:YES]];
        
        lists = @{@"buy":buyList,@"sell":sellList};
    }
    
    return lists;
}

@end
