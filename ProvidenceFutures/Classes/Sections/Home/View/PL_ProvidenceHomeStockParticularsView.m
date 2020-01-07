//
//  PL_ProvidenceHomeStockParticularsView.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/17.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceHomeStockParticularsView.h"
#import "PL_ProvidenceHomeStockModel.h"
#define kRectWith  ((SCREEN_Width - SCALE_Length(60.0f)) / 2.0f)
@interface PL_ProvidenceHomeStockParticularsView ()


/** position */
@property (strong, nonatomic) NSString *position;
/** vol */
@property (strong, nonatomic) NSString *vol;
/** priceAttribute */
@property (strong, nonatomic) NSDictionary *priceAttribute;
/* key的属性 */
@property (strong, nonatomic) NSDictionary *keyAttribute;
/** 值的属性 */
@property (strong, nonatomic) NSDictionary *valueAttribute;
/** 价格颜色 */
@property (strong, nonatomic) UIColor *priceColor;
/** 价格涨跌的标志 */
@property (strong, nonatomic) NSString *tailString;
/** 合约列表模型 */
@property (strong, nonatomic) PL_ProvidenceHomeStockModel *model;
/** 合约产品按钮 */
@property (strong, nonatomic) UIButton *nameBtn;
/** priceLabel */
@property (strong, nonatomic) UILabel *priceLabel;
/** nameTitle */
@property (strong, nonatomic) NSString *nameTitle;
/** 当前价格 */
@property (strong, nonatomic) NSString *price;
/** 涨跌幅 */
@property (strong, nonatomic) NSString *change;
/** index */
@property (strong, nonatomic) NSString *indexPrice;
/** high */
@property (strong, nonatomic) NSString *highPrice;
/** low */
@property (strong, nonatomic) NSString *lowPrice;


@end

@implementation PL_ProvidenceHomeStockParticularsView


/* 绘图方法 */
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 昨收
    [NSObject PL_ProvidencedrawTextPairWithCtx:ctx rect:CGRectMake(kRectWith + SCALE_Length(50.0f), SCALE_Length(50.0f), kRectWith, SCALE_Length(15.0f)) keyText:@"昨收" valueText:self.model.settlement keyAttributes:self.keyAttribute valueAttributes:self.valueAttribute];
    
    // 成交量
    [NSObject PL_ProvidencedrawTextPairWithCtx:ctx rect:CGRectMake(kRectWith + SCALE_Length(50.0f), SCALE_Length(80.0f), kRectWith, SCALE_Length(15.0f)) keyText:@"成交量" valueText:self.position keyAttributes:self.keyAttribute valueAttributes:self.valueAttribute];
    
    // 成交额
    [NSObject PL_ProvidencedrawTextPairWithCtx:ctx rect:CGRectMake(kRectWith + SCALE_Length(50.0f), SCALE_Length(110.0f), kRectWith, SCALE_Length(15.0f)) keyText:@"成交额" valueText:self.vol keyAttributes:self.keyAttribute valueAttributes:self.valueAttribute];
    
    // 最高
    [NSObject PL_ProvidencedrawTextPairWithCtx:ctx rect:CGRectMake(SCALE_Length(10.0f), SCALE_Length(80.0f), kRectWith, SCALE_Length(15.0f)) keyText: @"最高" valueText:self.highPrice keyAttributes:self.keyAttribute valueAttributes:self.valueAttribute];
    // 最低
    [NSObject PL_ProvidencedrawTextPairWithCtx:ctx rect:CGRectMake(SCALE_Length(10.0f), SCALE_Length(110.0f), kRectWith, SCALE_Length(15.0f)) keyText: @"最低" valueText:self.lowPrice keyAttributes:self.keyAttribute valueAttributes:self.valueAttribute];
}


#pragma mark - 布局方法  -------

/**
 初始化
 
 @param frame 尺寸
 @param model 模型
 */
- (instancetype)initWithFrame:(CGRect)frame contractModel:(PL_ProvidenceHomeStockModel *)model {
    
    if(self = [super initWithFrame:frame]) {
        
        if (model) {
            self.model = model;
        }
        
        [self PL_Providenceinitialize];;
        
        [self PL_ProvidenceconfigUI];
        
        [self PL_ProvidenceupdateDataWithModel:model];
        
    }
    return self;
}


- (void)PL_Providenceinitialize {
    
    ;
    
    self.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    
    self.nameTitle = @"-- ";
    self.price = @"-- ";
    self.change = @"--%";
    self.indexPrice = @"--";
    self.highPrice = @"--";
    self.lowPrice = @"--";
    self.position = @"--";
    self.vol = @"--";
    self.tailString = @"";
    self.priceColor = [UIColor colorWithHexString:@"0x666666"];
    
}

- (void)PL_ProvidenceconfigUI {
    
    [self addSubview:self.nameBtn];
    [self addSubview:self.priceLabel];
    
    [self layoutWithMasonry];
}

- (void)layoutWithMasonry {
    
    [self.nameBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCALE_Length(10.0f));
        make.top.equalTo(self.mas_top).offset(SCALE_Length(10.0f));
        make.height.mas_equalTo(SCALE_Length(30.0f));
    }];
    
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(SCALE_Length(10.0f));
        make.top.equalTo(self.nameBtn.mas_bottom).offset(SCALE_Length(5.0f));
    }];
    
}

#pragma mark - 公共方法 ----

/**
 根据合约模型更新数据
 
 @param model 合约模型
 */
- (void)updateDataWithModel:(PL_ProvidenceHomeStockModel *)model {
    
    if (model) {

        self.model = model;
        
        [self PL_ProvidenceupdateDataWithModel:self.model];
    }
}

#pragma mark - 私有方法 ----

- (void)PL_ProvidenceupdateDataWithModel:(PL_ProvidenceHomeStockModel *)model {
    
    if (model) {
        self.nameTitle = [NSString stringWithFormat:@"%@",model.name];
        // 最新价
        if (!isStrEmpty(model.trade)) {
            self.price = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:model.trade decimalsLimit:3 prefix:@"" suffix:@""];
        }
        // 涨跌
        if (!isStrEmpty(model.changepercent)) {
            
            // 计算24h价格涨跌幅
            NSDecimalNumberHandler *changeHandle = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
            
            NSDecimalNumber *priceChange = [[self.model.changepercent PL_ProvidencedigitalValue] decimalNumberByMultiplyingBy:[@"1" PL_ProvidencedigitalValue] withBehavior:changeHandle];
            
            NSString *showChange = @" --%";
            if (priceChange && !isStrEmpty([priceChange stringValue])) {
                showChange = [NSString stringWithFormat:@" %@%%",[NSString PL_ProvidencefixNumString:[priceChange stringValue] minDecimalsLimit:2 maxDecimalsLimit:2]];
            }
            self.change = showChange;
        }
        //        // 现货指数
        //        if (!isStrEmpty(contractModel.indexPrice)) {
        //            self.indexPrice = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:contractModel.indexPrice decimalsLimit:[contractModel.price_decimal integerValue] prefix:@"" suffix:@""];
        //        }
//        if(isStrEmpty(self.indexPrice) || [self.indexPrice isEqualToString:@"--"]) {
//            [self PL_ProvidenceupdateIndexToTopView];
//        }
        
        // 最高
        if (!isStrEmpty(model.high)) {
            self.highPrice = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:model.high decimalsLimit:2 prefix:@"" suffix:@""];
        }
        // 最低
        if (!isStrEmpty(model.low)) {
            self.lowPrice = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:model.low decimalsLimit:2 prefix:@"" suffix:@""];
        }
        
        // 持仓量
        if (!isStrEmpty(model.volume)) {
            
            NSDecimalNumberHandler *handle = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
            
            NSDecimalNumber *positionNum = [[model.volume PL_ProvidencedigitalValue] decimalNumberByDividingBy:[@"1" PL_ProvidencedigitalValue]  withBehavior:handle];
            
            self.position = positionNum ? [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:[positionNum stringValue] decimalsLimit:-1 prefix:@"" suffix:@""] : @"0";
        }
        
        // 成交额
        if (!isStrEmpty(model.amount)) {
            
            NSDecimalNumberHandler *handle = [[NSDecimalNumberHandler alloc] initWithRoundingMode:NSRoundDown scale:0 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
            
            NSDecimalNumber *volNum = [[model.amount PL_ProvidencedigitalValue] decimalNumberByDividingBy:[@"1" PL_ProvidencedigitalValue] withBehavior:handle];
            
            self.vol = [NSString PL_ProvidenceconvertToDisplayStringWithOriginNum:volNum ? [volNum stringValue] : @"0" decimalsLimit:0 prefix:@"" suffix:@""];
        }
    }
    
    [self PL_ProvidenceupdateDeatilInfo];
    
}

/* 更新详细信息 */
- (void)PL_ProvidenceupdateDeatilInfo {
    // 更新标题
    [self.nameBtn setTitle:self.nameTitle forState:UIControlStateNormal];
    
    NSDecimalNumber *percent = [self.model.changepercent PL_ProvidencedigitalValue];
    
    if (self.model && [percent compare:@(0)] == NSOrderedAscending) {
        
        if ([percent compare:@(0)] == NSOrderedDescending) {
            // 高于上一次价格
            self.priceColor = [UIColor colorWithHexString:@"0x50B383"];
            self.tailString = @"↑";
        }else if([percent compare:@(0)] == NSOrderedAscending){
            self.priceColor = [UIColor colorWithHexString:@"0xE04A59"];
            self.tailString = @"↓";
        }else {
            self.priceColor = [UIColor colorWithHexString:@"0x50B383"];
        }
    }
    
    // 展示的价格
    NSString *showString = [NSString stringWithFormat:@"%@%@",self.price,self.tailString];
    
    NSMutableAttributedString *priceShowAttributeString = [[NSMutableAttributedString alloc] initWithString:[showString stringByAppendingString:self.change]];
    [priceShowAttributeString addAttributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:24.0f],NSForegroundColorAttributeName:self.priceColor} range:NSMakeRange(0, showString.length)];
    NSInteger changLoc = showString.length;
    changLoc = changLoc < 0 ? 0 : changLoc;
    [priceShowAttributeString addAttributes:@{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:self.priceColor} range:NSMakeRange(changLoc, self.change.length)];
    
    [self.priceLabel setAttributedText:priceShowAttributeString];
    
    [self setNeedsDisplay];
}

#pragma mark - 懒加载 ---------

- (UIButton *)nameBtn {
    
    if(!_nameBtn) {
        _nameBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_nameBtn setTitleColor:[UIColor colorWithHexString:@"0xB4B4B4"] forState:UIControlStateNormal];
        _nameBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18.0f];
    }
    return _nameBtn;
}

- (NSDictionary *)priceAttribute {
    if (!_priceAttribute) {
        _priceAttribute = @{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:24.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"]};
    }
    return _priceAttribute;
}

- (NSDictionary *)keyAttribute {
    
    if (!_keyAttribute) {
        _keyAttribute = @{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"]};
    }
    return _keyAttribute;
}

- (NSDictionary *)valueAttribute {
    if (!_valueAttribute) {
        _valueAttribute = @{NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"]};
    }
    return _valueAttribute;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _priceLabel;
}


@end
