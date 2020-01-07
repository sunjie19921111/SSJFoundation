//
//  PL_ProvidenceDealDataManager.h
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
//2019/11/11.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceDealDataManager : NSObject




- (BOOL)updateMyCachePriceNow:(PL_ProvidenceDealModel *)model;
- (BOOL)updateMyCachePostion:(PL_ProvidenceDealModel *)model;

- (void)deleteModelWithSymbol:(NSString *)symbol;
- (void)deleteModel:(PL_ProvidenceDealModel *)model;

+ (instancetype)manager;
- (void)update;

- (void)start;
- (BOOL)insertModel:(PL_ProvidenceDealModel *)model;

- (NSArray *)getAllModels;

- (NSMutableArray *)getMyCacheModelBuySell:(NSString *)BuySell;

@end

NS_ASSUME_NONNULL_END
