//
//  PL_ProvidenceDataManager.h
//  EvianFutures-OC
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/10/10.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PL_ProvidenceDealModel;

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceDataManager : NSObject

+ (instancetype)manager;
- (void)update;

- (void)start;
- (BOOL)insertModel:(PL_ProvidenceDealModel *)model;

- (BOOL)updateMyCachePriceNow:(PL_ProvidenceDealModel *)model;
- (BOOL)updateMyCachePostion:(PL_ProvidenceDealModel *)model;

- (void)deleteModelWithSymbol:(NSString *)symbol;
- (void)deleteModel:(PL_ProvidenceDealModel *)model;

- (NSArray *)getAllModels;

- (PL_ProvidenceDealModel *)getMyCacheModelSymbol:(NSString *)symbol;

@end

NS_ASSUME_NONNULL_END
