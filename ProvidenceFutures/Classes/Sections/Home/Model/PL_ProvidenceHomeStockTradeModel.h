//
//  PL_ProvidenceHomeStockTradeModel.h
//  QWEStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/5/5.
//  Copyright © 2019 ASO. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeStockTradeModel : NSObject<NSCoding>



@property (nonatomic,strong)NSString *tagCode;

@property (nonatomic,strong)NSString *tagTitle;

@property (nonatomic,strong)NSString *tagUrl;

/** 价格 */
@property (assign, nonatomic) CGFloat price;

/** 是否是卖 */
@property (assign, nonatomic) BOOL isSell;

/** 便利构造器  */
+ (instancetype)tradeModelWithHands:(NSUInteger)hands price:(CGFloat)price isSell:(BOOL)isSell;

/** 时间戳 */
@property (assign, nonatomic) NSTimeInterval stamp;

/** 成交数量 */
@property (assign, nonatomic) NSUInteger hands;



@end

NS_ASSUME_NONNULL_END
