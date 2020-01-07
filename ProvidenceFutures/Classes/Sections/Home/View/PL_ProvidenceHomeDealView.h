//
//  PL_ProvidenceHomeDealView.h
//  QWEStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/5/6.
//  Copyright © 2019 ASO. All rights reserved.
//



#import <UIKit/UIKit.h>

@class PL_ProvidenceHomeStockModel,PL_ProvidenceHomeDealView;

NS_ASSUME_NONNULL_BEGIN

/**
 点击交易按钮

 @param tradeView 交易视图
 @param price 交易价格
 @param hands 手数
 */

/* 交易视图类型 */
typedef enum : NSUInteger {
    PL_ProvidenceTradeTypeBuy,        // 买
    PL_ProvidenceTradeTypeSell,       // 卖
} PL_ProvidenceTradeType;


typedef void(^TradeActionBlock)(PL_ProvidenceHomeDealView *tradeView, PL_ProvidenceTradeType tradeType, NSString *price , NSString *hands);


/**
 收回交易视图

 @param tradeView 交易视图
 */
typedef void(^TradeViewQuitBlock)(PL_ProvidenceHomeDealView *tradeView);

@protocol PL_ProvidenceMainTradeViewDelegate <NSObject>

- (void)tradeView:(PL_ProvidenceHomeDealView *)tradeView price:(NSString *)price hands:(NSString *)hands;

- (void)tradeView:(PL_ProvidenceHomeDealView *)tradeView touchQuitBtn:(UIButton *)quitBtn;

@end

@interface PL_ProvidenceHomeDealView : UIView


- (void)showTradeView;

- (void)hideTradeView;

- (void)clearInputData;


- (instancetype)initWithFrame:(CGRect)frame symbol:(NSString *)symbol priceNow:(NSString *)priceNow name:(NSString *)name;



- (void)updateOpenPrice:(NSString *)openPrice;

- (void)updateAvailableHands:(NSUInteger)hands;

- (void)switchTradeViewWithType:(PL_ProvidenceTradeType)tradeType;



/**  代理 */
@property (weak, nonatomic) id <PL_ProvidenceMainTradeViewDelegate> delegate;

/** 交易的回调 */
@property (copy, nonatomic) TradeActionBlock tradeBlock;

/** 收回交易视图的回调 */
@property (copy, nonatomic) TradeViewQuitBlock quitBlock;

@end

NS_ASSUME_NONNULL_END
