//
//  PL_ProvidenceFavDBManager.h
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/18.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <Foundation/Foundation.h>


@class PL_ProvidenceHomeStockModel;



NS_ASSUME_NONNULL_BEGIN

typedef void(^FavCallBackBlock)(BOOL suc, PL_ProvidenceHomeStockModel *listModel);

@interface PL_ProvidenceFavDBManager : NSObject

/**
 获得收藏列表

 @param callBack 回调
 */
- (void)getFavArrayWithCallback:(void(^)(NSArray *favList))callBack;

- (void)getPositionArrayWithCallback:(void(^)(NSArray *favList))callBack;


/* 初始化单例类 */
+ (instancetype)manager;

/**
 移除自选

 @param listModel 自选模型
 @param callBack 回调
 */
- (void)removeFavWithListModel:(PL_ProvidenceHomeStockModel *)listModel callBack:(FavCallBackBlock)callBack;

- (void)removePostionWithListModel:(PL_ProvidenceHomeStockModel *)listModel callBack:(FavCallBackBlock)callBack;

/**
 查找是否收藏

 @param symbol 股票唯一标识符
 @return 收藏为YES
 */
- (BOOL)isFavWithSymbol:(NSString *)symbol;

- (BOOL)isPostionWithSymbol:(NSString *)symbol;





/**
 添加自选

 @param listModel 自选模型
 @param callBack 回调
 */
- (void)addFavWithMarketListModel:(PL_ProvidenceHomeStockModel *)listModel callBack:(FavCallBackBlock)callBack;


- (void)addPositionWithMarketListModel:(PL_ProvidenceHomeStockModel *)listModel callBack:(FavCallBackBlock)callBack;


@property (readonly, strong, nonatomic) NSMutableArray *favArray;

@end

NS_ASSUME_NONNULL_END
