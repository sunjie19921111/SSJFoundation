//
//  PL_ProvidenceHomeFormHorView.m
//  kkcoin
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// walker on 2018/8/2.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "PL_ProvidenceHomeFormHorView.h"
#import "PL_ProvidenceHomeOrderModel.h"


@interface PL_ProvidenceHomeFormHorView()

@property(nonatomic,strong) NSString *subContent;

@property(nonatomic,strong) NSString *subTime;

@property(nonatomic,strong) NSString *answerMesg;

@property(nonatomic,strong) NSString *answerTime;

@property(nonatomic,assign) NSInteger status;

@property (strong, nonatomic) UILabel *leftTipLabel;

@property (strong, nonatomic) UILabel *rightTipLabel;

@property (strong, nonatomic) NSString *rate;

@property (strong, nonatomic) NSMutableArray *buyOrderList;

@property (strong, nonatomic) NSMutableArray *sellOrderList;

@property (strong, nonatomic) NSDecimalNumber *askMaxAmount;

@property (strong, nonatomic) NSDecimalNumber *bidMaxAmount;

@property (assign, nonatomic) CGFloat gearHeight;

@property (assign, nonatomic)  CGFloat unitAmount;

@property (assign, nonatomic ,readwrite) OrderBookDisPlayDataType showDataType;



@end

@implementation PL_ProvidenceHomeFormHorView

#pragma mark - 私有方法 ----
/**
 绘制买一价
 
 @param ctx 绘图上下文
 @param rect 区域
 */
- (void)PL_ProvidencedrawBuyTitleWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
   
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentRight;
    [NSObject PL_ProvidencedrawVerticalCenterTextInRect:CGRectMake(0, 0, rect.size.width/2 - SCALE_Length(5.0f), SCALE_Length(30.f)) text:self.buyTitle attributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"],NSParagraphStyleAttributeName:paragraphStyle}];
}

#pragma mark - 懒加载 --

- (NSMutableArray *)buyOrderList {
    if (!_buyOrderList) {
        _buyOrderList = @[].mutableCopy;
    }
    return _buyOrderList;
}

- (NSMutableArray *)sellOrderList {
    if (!_sellOrderList) {
        
        _sellOrderList = @[].mutableCopy;
    }
    return _sellOrderList;
}

- (void)PL_Providenceinitialize {

    self.priceHeight = 0.0f;
    self.gears = 5;
    self.askMaxAmount = [@"0" PL_ProvidencedigitalValue];
    self.bidMaxAmount = [@"0" PL_ProvidencedigitalValue];
    self.buyTitle = @"买一价";
    self.sellTitle  = @"卖一价";
    self.showDataType = OrderBookDisPlayDataTypeCount;
    self.volDecimalLimit = 0;
    self.leftTipTitle = [[NSAttributedString alloc] initWithString:@""];
    self.rightTipTitle = [[NSAttributedString alloc] initWithString:@""];
    self.rate = @"1";
    
    [self PL_ProvidencesetTipLabel];
}

- (void)PL_ProvidencesetTipLabel {
    
    [self addSubview:self.leftTipLabel];
    [self addSubview:self.rightTipLabel];
    
    self.leftTipLabel.frame = CGRectMake(SCALE_Length(10), 0, (self.frame.size.width - SCALE_Length(30.0f)) / 2.0f, SCALE_Length(30.0f));
    self.rightTipLabel.frame = CGRectMake(SCALE_Length(20) + self.leftTipLabel.width, 0, self.leftTipLabel.width, SCALE_Length(30.0f));
}


/** 绘图方法 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    if (self.gearHeight <= 0) {
        self.gearHeight = ((rect.size.height - self.priceHeight - SCALE_Length(30.0f)) / (self.gears)) - self.gearGap;
    }
    // 买盘
    [self PL_ProvidencedrawBidOrderWithCtx:ctx rect:CGRectMake(SCALE_Length(10.0f), rect.origin.y, (rect.size.width - SCALE_Length(30.0f)) / 2.0f, rect.size.height)]; // 买盘

    // 卖盘
    [self PL_ProvidencedrawAskOrderWithCtx:ctx rect:CGRectMake((rect.size.width + SCALE_Length(10.0f)) / 2.0f, rect.origin.y, (rect.size.width - SCALE_Length(30.0f)) / 2.0f, rect.size.height)]; // 卖盘
    
    //绘制买一价，卖一价
    [self PL_ProvidencedrawBuyTitleWithCtx:ctx rect:rect];
    [self PL_ProvidencedrawSellTitleWithCtx:ctx rect:rect];
}



/**
 绘制卖一价
 
 @param ctx 绘图上下文
 @param rect 区域
 */
- (void)PL_ProvidencedrawSellTitleWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.alignment = NSTextAlignmentLeft;
    [NSObject PL_ProvidencedrawVerticalCenterTextInRect:CGRectMake(rect.size.width/2 + SCALE_Length(5.0f), 0, rect.size.width/2 - SCALE_Length(10.0f), SCALE_Length(30.f)) text:self.sellTitle attributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"],NSParagraphStyleAttributeName:paragraphStyle}];
}

/**
 绘制卖盘
 
 @param ctx 绘图上下文
 @param rect 区域
 */
- (void)PL_ProvidencedrawAskOrderWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
    
    for (int a = 0; a < self.sellOrderList.count; a ++) {
        PL_ProvidenceHomeOrderModel *tempBookModel = self.sellOrderList[a];
        CGFloat gearOriginY = (self.gearHeight + self.gearGap) * (a);
        
        [self PL_ProvidencedrawOrderWithOrderModel:tempBookModel ctx:ctx rect:CGRectMake(rect.origin.x, gearOriginY+SCALE_Length(30.0f), rect.size.width, self.gearHeight) bgFromRight:NO];
        
        if (a >= (self.gears - 1)) {
            break;
        }
    }
}

/**
 买盘
 
 @param ctx 绘图上下文
 @param rect 区域
 */
- (void)PL_ProvidencedrawBidOrderWithCtx:(CGContextRef)ctx rect:(CGRect)rect {
    
    for (int a = 0; a < self.buyOrderList.count; a ++) {
        PL_ProvidenceHomeOrderModel *tempBookModel = self.buyOrderList[a];
        CGFloat gearOriginY = (self.gearHeight + self.gearGap) * (a);
        
        [self PL_ProvidencedrawOrderWithOrderModel:tempBookModel ctx:ctx rect:CGRectMake(rect.origin.x, gearOriginY+SCALE_Length(30.0f), rect.size.width, self.gearHeight) bgFromRight:YES];
        
        if (a >= (self.gears - 1)) {
            break;
        }
    }
}

/**
 绘制挂单
 
 @param model 挂单模型
 @param rect 区域
 */
- (void)PL_ProvidencedrawOrderWithOrderModel:(PL_ProvidenceHomeOrderModel *)model ctx:(CGContextRef)ctx rect:(CGRect)rect bgFromRight:(BOOL)isFromRight {
    
    if(!model) {
        return;
    }
    
    UIColor *backColor = model.isAsk ? [UIColor colorWithHexString:@"0xFDE7EE"] : [UIColor colorWithHexString:@"0xEDF7EB"];
    UIColor *textColor = model.isAsk ? [UIColor colorWithHexString:@"0xE04A59"] : [UIColor colorWithHexString:@"0x50B383"];
    
    NSDecimalNumber *maxAmount = model.isAsk ? self.askMaxAmount : self.bidMaxAmount;
    CGFloat scaleRate = 0.0f;
    if ([maxAmount compare:[@(0) PL_ProvidencedigitalValue]] == NSOrderedDescending) {
        scaleRate = [[[model.amount PL_ProvidencedigitalValue] decimalNumberByDividingBy:maxAmount] doubleValue];
    }
    CGFloat backColorWidth = scaleRate * rect.size.width;

    if (isFromRight) {
        CGRect backRect = CGRectMake(rect.origin.x + (rect.size.width - backColorWidth), rect.origin.y, backColorWidth, rect.size.height);
        // 背景颜色
        [NSObject PL_ProvidencedrawBackGroundColorWithCtx:ctx rect:backRect color:backColor];
        
        switch (self.showDataType) {
            case OrderBookDisPlayDataTypeCount:
            {
                // 数量
                NSDecimalNumber *volDec = [model PL_ProvidencegetCountWithDecimal:self.volDecimalLimit unitAmount:self.unitAmount];
                
                [NSObject PL_ProvidencedrawVerticalCenterTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - SCALE_Length(10.0f), rect.size.height) text:[volDec stringValue] attributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"]}];

            }
                break;
                
            case OrderBookDisPlayDataTypeAmount:
            {
                // 金额
                NSDecimalNumberHandler *amountHandle = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:self.volDecimalLimit raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
                
                NSDecimalNumber *amountDec = [[model PL_ProvidencegetAmountWithDecimal:self.volDecimalLimit] decimalNumberByDividingBy:[self.rate PL_ProvidencedigitalValue] withBehavior:amountHandle];
                
                NSString *amountString = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[amountDec stringValue] decimalsLimit:self.volDecimalLimit prefix:@"" suffix:@""];
                
                [NSObject PL_ProvidencedrawVerticalCenterTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - SCALE_Length(10.0f), rect.size.height) text:amountString attributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"]}];
            }
                break;
                
            default:
                break;
        }
        
        // 价格
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.alignment = NSTextAlignmentRight;
        
        [NSObject PL_ProvidencedrawVerticalCenterTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - SCALE_Length(5.0f), rect.size.height)  text:model.price attributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:textColor,NSParagraphStyleAttributeName:paragraphStyle}];
        
    }else {
        CGRect backRect = CGRectMake(rect.origin.x, rect.origin.y, backColorWidth, rect.size.height);
        // 背景颜色
        [NSObject PL_ProvidencedrawBackGroundColorWithCtx:ctx rect:backRect color:backColor];
        
        // 价格
        [NSObject PL_ProvidencedrawVerticalCenterTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - SCALE_Length(10.0f), rect.size.height) text:model.price attributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:textColor}];
        
        switch (self.showDataType) {
            case OrderBookDisPlayDataTypeCount:
            {
                // 数量
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.alignment = NSTextAlignmentRight;
                
                NSDecimalNumber *volDec = [model PL_ProvidencegetCountWithDecimal:self.volDecimalLimit unitAmount:self.unitAmount];
                
                [NSObject PL_ProvidencedrawVerticalCenterTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)  text:[volDec stringValue] attributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"],NSParagraphStyleAttributeName:paragraphStyle}];
            }
                break;
                
            case OrderBookDisPlayDataTypeAmount:
            {
                // 金额
                NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
                paragraphStyle.alignment = NSTextAlignmentRight;
                
                NSDecimalNumberHandler *amountHandle = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:self.volDecimalLimit raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
                
                NSDecimalNumber *amountDec = [[model PL_ProvidencegetAmountWithDecimal:self.volDecimalLimit] decimalNumberByDividingBy:[self.rate PL_ProvidencedigitalValue] withBehavior:amountHandle];
                
                NSString *amountString = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[amountDec stringValue] decimalsLimit:self.volDecimalLimit prefix:@"" suffix:@""];
                
                [NSObject PL_ProvidencedrawVerticalCenterTextInRect:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)  text:amountString attributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"],NSParagraphStyleAttributeName:paragraphStyle}];
            }
                break;
                
            default:
                break;
        }
    }
}

/* 左边 */
- (void)PL_ProvidenceleftTipLabelAction:(UITapGestureRecognizer *)tap {
    
    if (_delegate && [_delegate respondsToSelector:@selector(orderBookView:didSwitchDataType:)]) {
        [_delegate orderBookView:self didSwitchDataType:self.showDataType];
    }
}

/* 右边 */
- (void)PL_ProvidencerightTipLabelAction:(UITapGestureRecognizer *)tap {
    
    if (_delegate && [_delegate respondsToSelector:@selector(orderBookView:didSwitchDataType:)]) {
        [_delegate orderBookView:self didSwitchDataType:self.showDataType];
    }
}


/* 更新最大值 */
- (void)PL_ProvidenceupdateMaxAmount {
    
    self.askMaxAmount = [@"0" PL_ProvidencedigitalValue];
    self.bidMaxAmount = [@"0" PL_ProvidencedigitalValue];
    
    for (int i = 0; i < self.sellOrderList.count; i ++) {
        
        PL_ProvidenceHomeOrderModel *tempBookModel = self.sellOrderList[i];
        NSDecimalNumber *tempAmount = [tempBookModel.amount PL_ProvidencedigitalValue];
        if ([tempAmount compare:self.askMaxAmount] == NSOrderedDescending) {
            self.askMaxAmount = tempAmount;
        }
        
        if (i >= (self.gears - 1)) {
            break;
        }
    }
    
    for (int i = 0; i < self.buyOrderList.count; i ++) {
        
        PL_ProvidenceHomeOrderModel *tempBookModel = self.buyOrderList[i];
        NSDecimalNumber *tempAmount = [tempBookModel.amount PL_ProvidencedigitalValue];
        if ([tempAmount compare:self.bidMaxAmount] == NSOrderedDescending) {
            self.bidMaxAmount = tempAmount;
        }
        
        if (i >= (self.gears - 1)) {
            break;
        }
    }
    
    if (!self.askMaxAmount) {
        self.askMaxAmount = [@"0" PL_ProvidencedigitalValue];
    }
    
    if(!self.bidMaxAmount) {
        self.bidMaxAmount = [@"0" PL_ProvidencedigitalValue];
    }
}



#pragma mark - 公共方法 --

- (void)setLeftTipTitle:(NSAttributedString *)leftTipTitle {
    if (leftTipTitle) {
        _leftTipTitle = leftTipTitle;
        
        [self.leftTipLabel setAttributedText:_leftTipTitle];
    }
}

- (void)setRightTipTitle:(NSAttributedString *)rightTipTitle {
    if (rightTipTitle) {
        _rightTipTitle = rightTipTitle;
        
        [self.rightTipLabel setAttributedText:_rightTipTitle];
    }
}

/**
 更新挂单列表
 
 @param bidArray 买方列表
 @param askArray 卖方列表
 @param unitAmount 每手币种数量
 */
- (void)updateTraderOrderBidListArray:(NSArray *)bidArray askListArray:(NSArray *)askArray unitAmount:(CGFloat)unitAmount {
    
    if (unitAmount <= 0) {
        self.buyOrderList = @[].mutableCopy;
        self.sellOrderList = @[].mutableCopy;
        self.askMaxAmount = [@"0" PL_ProvidencedigitalValue];
        self.bidMaxAmount = [@"0" PL_ProvidencedigitalValue];
        self.unitAmount = 0.0f;
    }else {
        if (bidArray && [bidArray isKindOfClass:[NSArray class]]) {
            self.buyOrderList = [bidArray copy];
        }else {
            self.buyOrderList = @[].mutableCopy;
        }
        
        if (askArray && [askArray isKindOfClass:[NSArray class]]) {
            self.sellOrderList = [askArray copy];
        }else {
            self.sellOrderList = @[].mutableCopy;
        }
        
        self.unitAmount = unitAmount;
        // 更新最大值数据
        [self PL_ProvidenceupdateMaxAmount];
    }
    [self setNeedsDisplay];
}

/**
 清除所有已存在的数据
 */
- (void)clearAllData {
    
    self.buyOrderList = @[].mutableCopy;
    self.sellOrderList = @[].mutableCopy;
    
    [self setNeedsDisplay];
}

/**
 切换展示的数据类型
 
 @param dataType 数据类型
 @param rate 汇率
 */
- (void)switchDisplayDataType:(OrderBookDisPlayDataType)dataType withExchangeRate:(NSString *)rate {
    
    if (self.showDataType != dataType) {
        self.showDataType = dataType;

    }
    
    if(!isStrEmpty(rate)) {
        self.rate = rate;
    }else {
        self.rate = @"1";
    }
    
    [self setNeedsDisplay];
}


- (UILabel *)leftTipLabel {
    if (!_leftTipLabel) {
        _leftTipLabel = [[UILabel alloc] init];
        _leftTipLabel.textColor = [UIColor colorWithHexString:@"0x4299FF"];
        _leftTipLabel.font = [UIFont PL_ProvidencesystemFontOfSize:12.0f];
        _leftTipLabel.textAlignment = NSTextAlignmentLeft;
        [_leftTipLabel setAttributedText:self.leftTipTitle];
        _leftTipLabel.userInteractionEnabled = YES;
        [_leftTipLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PL_ProvidenceleftTipLabelAction:)]];
    }
    return _leftTipLabel;
}

- (UILabel *)rightTipLabel {
    if (!_rightTipLabel) {
        _rightTipLabel = [[UILabel alloc] init];
        _rightTipLabel.textColor = [UIColor colorWithHexString:@"0x4299FF"];
        _rightTipLabel.font = [UIFont PL_ProvidencesystemFontOfSize:12.0f];
        _rightTipLabel.textAlignment = NSTextAlignmentRight;
        [_rightTipLabel setAttributedText:self.rightTipTitle];
        _rightTipLabel.userInteractionEnabled = YES;
        [_rightTipLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PL_ProvidencerightTipLabelAction:)]];
    }
    return _rightTipLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self PL_Providenceinitialize];;
    }
    return self;
}



@end
