//
//  PL_ProvidenceHomeStockOptionTopView.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/16.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceHomeStockOptionTopView.h"

@interface PL_ProvidenceHomeStockOptionTopView ()


/** 涨跌label */
@property (strong, nonatomic) UILabel *chgLabel;

/* 传入的标题 */
@property (strong, nonatomic) NSArray *titles;
/** 股票label */
@property (strong, nonatomic) UILabel *symbolLabel;

/** 价格label */
@property (strong, nonatomic) UILabel *priceLabel;


@end

@implementation PL_ProvidenceHomeStockOptionTopView


- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    
    if (self = [super initWithFrame:frame]) {

        if(titles && titles.count > 0) {
            self.titles = [titles copy];
        }

        [self PL_Providenceinitialize];;
        
        [self PL_ProvidenceconfigUI];

        [self PL_ProvidencesetUpTitle];
    }
    return self;
}

- (void)PL_Providenceinitialize {
    self.backgroundColor = [UIColor whiteColor];
    self.symbolLabel.text = @"股票";
    self.priceLabel.text = @"最新价格";
    self.chgLabel.text = @"涨跌幅";
}

- (void)PL_ProvidenceconfigUI {
    
    _symbolLabel = [[UILabel alloc] init];
    _symbolLabel.font = [UIFont fontWithName:fFont size:12.0f];
    _symbolLabel.textAlignment = NSTextAlignmentCenter;
    _symbolLabel.textColor = [UIColor colorWithHexString:@"0x666666"];
    [self addSubview:self.symbolLabel];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.font = [UIFont fontWithName:fFont size:12.0f];
    _priceLabel.textAlignment = NSTextAlignmentCenter;
    _priceLabel.textColor = [UIColor colorWithHexString:@"0x666666"];
    [self addSubview:self.priceLabel];
    
    _chgLabel = [[UILabel alloc] init];
    _chgLabel.font = [UIFont fontWithName:fFont size:12.0f];
    _chgLabel.textAlignment = NSTextAlignmentCenter;
    _chgLabel.textColor = [UIColor colorWithHexString:@"0x666666"];
    [self addSubview:self.chgLabel];
    
    [self.symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {

         make.left.equalTo(self.mas_left).mas_offset(SCALE_Length(10.0f));
         make.centerY.mas_equalTo(self.mas_centerY);
         make.width.mas_equalTo(SCALE_Length(60.0f));
     }];

     [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.equalTo(self.mas_left).mas_offset(SCALE_Length(180.0f));
         make.centerY.equalTo(self.mas_centerY);
     }];

     [self.chgLabel mas_makeConstraints:^(MASConstraintMaker *make) {
         make.right.equalTo(self.mas_right).offset(SCALE_Length(- 10.0f));
         make.width.mas_equalTo(SCALE_Length(80.0f));
         make.centerY.equalTo(self.mas_centerY);
     }];

//    [self layoutWithMasonry];
}

- (void)layoutWithMasonry {

 
}

- (void)PL_ProvidencesetUpTitle {

    if(self.titles && self.titles.count >= 3) {

        self.symbolLabel.text = [self.titles objectAtIndex:0];
        self.priceLabel.text = [self.titles objectAtIndex:1];
        self.chgLabel.text = [self.titles objectAtIndex:2];

    }
}




//- (UILabel *)symbolLabel {
//    if (!_symbolLabel) {
//        _symbolLabel = [[UILabel alloc] init];
//        _symbolLabel.font = [UIFont fontWithName:fFont size:12.0f];
//        _symbolLabel.textAlignment = NSTextAlignmentCenter;
//        _symbolLabel.textColor = [UIColor colorWithHexString:@"0x666666"];
//    }
//    return _symbolLabel;
//}
//
//- (UILabel *)priceLabel {
//    if (!_priceLabel) {
//        _priceLabel = [[UILabel alloc] init];
//        _priceLabel.font = [UIFont fontWithName:fFont size:12.0f];
//        _priceLabel.textAlignment = NSTextAlignmentCenter;
//        _priceLabel.textColor = [UIColor colorWithHexString:@"0x666666"];
//    }
//    return _priceLabel;
//}
//
//- (UILabel *)chgLabel {
//    if (!_chgLabel) {
//        _chgLabel = [[UILabel alloc] init];
//        _chgLabel.font = [UIFont fontWithName:fFont size:12.0f];
//        _chgLabel.textAlignment = NSTextAlignmentCenter;
//        _chgLabel.textColor = [UIColor colorWithHexString:@"0x666666"];
//    }
//    return _chgLabel;
//}

@end
