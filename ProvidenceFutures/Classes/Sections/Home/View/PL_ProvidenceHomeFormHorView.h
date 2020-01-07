//
//  PL_ProvidenceHomeFormHorView.h
//  kkcoin
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// walker on 2018/8/2.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@class PL_ProvidenceHomeFormHorView,PL_ProvidenceHomeOrderModel;
@protocol OrderBookViewProtocol <NSObject>
@optional

- (void)orderBookView:(PL_ProvidenceHomeFormHorView *)orderBook didSelectedPrice:(NSString *)price;

- (void)orderBookView:(PL_ProvidenceHomeFormHorView *)orderBook didSwitchDataType:(OrderBookDisPlayDataType)dataType;


@end

@interface PL_ProvidenceHomeFormHorView : UIView


@property (assign, nonatomic) CGFloat priceHeight;

@property (assign, nonatomic) NSInteger gears;

@property (assign, nonatomic) CGFloat gearGap;

@property (strong, nonatomic) NSString *buyTitle;

@property (strong, nonatomic) NSString *sellTitle;

- (void)updateTraderOrderBidListArray:(NSArray *)bidArray askListArray:(NSArray *)askArray unitAmount:(CGFloat)unitAmount;

- (void)switchDisplayDataType:(OrderBookDisPlayDataType)dataType withExchangeRate:(NSString *)rate;

@property (weak, nonatomic) id<OrderBookViewProtocol> delegate;

@property (strong, nonatomic) NSAttributedString *leftTipTitle;

@property (strong, nonatomic) NSAttributedString *rightTipTitle;

@property (assign, nonatomic) NSInteger volDecimalLimit;

@property (assign, nonatomic ,readonly) OrderBookDisPlayDataType showDataType;

- (void)clearAllData;



@end
NS_ASSUME_NONNULL_END
