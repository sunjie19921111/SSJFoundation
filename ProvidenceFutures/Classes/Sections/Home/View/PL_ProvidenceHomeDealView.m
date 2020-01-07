//
//  PL_ProvidenceHomeDealView.m
//  QWEStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/5/6.
//  Copyright © 2019 ASO. All rights reserved.
//

#import "PL_ProvidenceHomeDealView.h"
#import "PL_ProvidenceStepperView.h"

@interface PL_ProvidenceHomeDealView ()<UIGestureRecognizerDelegate>

/** 手数输入框 */
@property (strong, nonatomic) PL_ProvidenceStepperView *handsField;

/** 底图 */
@property (strong, nonatomic) UIView *backView;

/** 关闭按钮 */
@property (strong, nonatomic) UIButton *quitBtn;

/** 手数提示标签 */
@property (strong, nonatomic) UILabel *tipLabel;

/** 交易按钮 */
@property (strong, nonatomic) UIButton *tradeBtn;

/** 背景视图点击手势 */
@property (strong, nonatomic) UITapGestureRecognizer *tapGesture;

/**  交易类型 */
@property (assign, nonatomic) PL_ProvidenceTradeType tradeType;

/** symbol */
@property (strong, nonatomic) NSString *symbol;

/** 价格 */
@property (strong, nonatomic) NSString *priceNow;

/** 输入手数 */
@property (strong, nonatomic) NSString *hands;

/** 手数限制 */
@property (assign, nonatomic) NSInteger handsLimit;

/** 股票名称 */
@property (strong, nonatomic) NSString *name;

/** 价格输入框 */
@property (strong, nonatomic) PL_ProvidenceStepperView *priceField;



@end

@implementation PL_ProvidenceHomeDealView


- (instancetype)initWithFrame:(CGRect)frame symbol:(NSString *)symbol priceNow:(NSString *)priceNow name:(NSString *)name {
    if(self = [super initWithFrame:frame]) {
        self.name = name;
        self.symbol = symbol;
        self.priceNow = priceNow;
        
        [self PL_Providenceinitialize];
        
        [self PL_ProvidencesetUpUI];
    }
    return self;
}

- (void)showTradeView {
    weakSelf(self);
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.backView.top = weakSelf.height - weakSelf.backView.height;
    }];
}

- (void)hideTradeView {
    weakSelf(self);
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.backView.top = weakSelf.height;
    }];
    
}

- (void)clearInputData {
    
    [self.priceField updateText:@""];
    
    [self.handsField updateText:@""];

}

- (void)updateOpenPrice:(NSString *)openPrice {
    
}



- (void)PL_Providenceinitialize {
    self.tradeType = PL_ProvidenceTradeTypeBuy;
    [self addGestureRecognizer:self.tapGesture];
//    [[KeyBoardManager shareManager] addDelegate:self];
}

- (void)PL_ProvidencesetUpUI {
    
    _backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), SCREEN_Width, SCALE_Length(160.0f) + TabMustAdd)];
    _backView.backgroundColor = [[UIColor colorWithHexString:@"0xffffff"] colorWithAlphaComponent:1.0f];
    _backView.alpha = 1.0f;
    [self addSubview:self.backView];
    
    _quitBtn = [[UIButton alloc] init];
          [_quitBtn setImage:[UIImage imageNamed:@"icon_login_quitBtn"] forState:UIControlStateNormal];
          [_quitBtn addTarget:self action:@selector(PL_ProvidencequitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:self.quitBtn];
            _priceField = [[PL_ProvidenceStepperView alloc] initWithFrame:CGRectZero hideFineTuning:YES];
            _priceField.decimal = 2;
            _priceField.minValue = 0;
            _priceField.isCanPaste = NO;
            _priceField.isForceNumKeyBoard = YES;
            _priceField.attributedPlaceHolder = [@"买入价" PL_ProvidencecreateAttributedStringWithFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor colorWithHexString:@"0xcccccc"]];
            _priceField.textFont = [UIFont PL_ProvidencesystemFontOfSize:12.0f];
            _priceField.textColor = [UIColor colorWithHexString:@"0x666666"];
            [_priceField updateText:self.priceNow];
            _priceField.layer.borderColor = [UIColor colorWithHexString:@"0x50B383"].CGColor;
            _priceField.layer.borderWidth = 2.0f;
            weakSelf(self);
//    _priceField.valueChangeBlock = ^(NSString *value) {}
    //            strongSelf(weakSelf);
    
    [self.backView addSubview:self.priceField];
    
                
    [self.backView addSubview:self.handsField];
    
    [self.backView addSubview:self.tipLabel];
    
    [self.backView addSubview:self.tradeBtn];
    
        [self.quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(SCALE_Length(- 5.0f));
        make.top.equalTo(self.backView.mas_top).offset(SCALE_Length(10.0f));
        make.size.mas_equalTo(CGSizeMake(SCALE_Length(24.0f), SCALE_Length(24.0f)));
    }];
    
    [self.priceField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.backView.mas_left).offset(SCALE_Length(10.0f));
        make.top.equalTo(self.quitBtn.mas_bottom).offset(SCALE_Length(10.0f));
        make.size.mas_equalTo(CGSizeMake((SCREEN_Width - SCALE_Length(40.0f)) / 2.0f, SCALE_Length(30.0f)));
    }];
    
    [self.handsField mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.equalTo(self.backView.mas_right).offset(SCALE_Length(- 10.0f));
        make.top.equalTo(self.quitBtn.mas_bottom).offset(SCALE_Length(10.0f));
        make.size.mas_equalTo(CGSizeMake((SCREEN_Width - SCALE_Length(40.0f)) / 2.0f, SCALE_Length(30.0f)));
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.backView.mas_right).offset(SCALE_Length(- 10.0f));
        make.top.equalTo(self.handsField.mas_bottom).offset(SCALE_Length(10.0f));
    }];
    
    [self.tradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(SCALE_Length(10.0f));
        make.right.equalTo(self.backView.mas_right).offset(SCALE_Length(- 10.0f));
        make.height.mas_equalTo(SCALE_Length(40.0f));
        make.top.equalTo(self.tipLabel.mas_bottom).offset(SCALE_Length(10.0f));
    }];
}

//- (void)PL_Providencelayout {
//
//
//    [self.quitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.backView.mas_right).offset(SCALE_Length(- 5.0f));
//        make.top.equalTo(self.backView.mas_top).offset(SCALE_Length(10.0f));
//        make.size.mas_equalTo(CGSizeMake(SCALE_Length(24.0f), SCALE_Length(24.0f)));
//    }];
//
//    [self.priceField mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.backView.mas_left).offset(SCALE_Length(10.0f));
//        make.top.equalTo(self.quitBtn.mas_bottom).offset(SCALE_Length(10.0f));
//        make.size.mas_equalTo(CGSizeMake((SCREEN_Width - SCALE_Length(40.0f)) / 2.0f, SCALE_Length(30.0f)));
//    }];
//
//    [self.handsField mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.right.equalTo(self.backView.mas_right).offset(SCALE_Length(- 10.0f));
//        make.top.equalTo(self.quitBtn.mas_bottom).offset(SCALE_Length(10.0f));
//        make.size.mas_equalTo(CGSizeMake((SCREEN_Width - SCALE_Length(40.0f)) / 2.0f, SCALE_Length(30.0f)));
//    }];
//
//    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.backView.mas_right).offset(SCALE_Length(- 10.0f));
//        make.top.equalTo(self.handsField.mas_bottom).offset(SCALE_Length(10.0f));
//    }];
//
//    [self.tradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.backView.mas_left).offset(SCALE_Length(10.0f));
//        make.right.equalTo(self.backView.mas_right).offset(SCALE_Length(- 10.0f));
//        make.height.mas_equalTo(SCALE_Length(40.0f));
//        make.top.equalTo(self.tipLabel.mas_bottom).offset(SCALE_Length(10.0f));
//    }];
//
//}

- (void)PL_ProvidencequitBtnAction:(UIButton *)btn {
    
    [self hideTradeView];
    
    if (_delegate && [_delegate respondsToSelector:@selector(tradeView:touchQuitBtn:)]) {
        [_delegate tradeView:self touchQuitBtn:btn];
    }
    
    !self.quitBlock ? : self.quitBlock(self);
    
}

- (void)PL_ProvidencetradeBtnAction:(UIButton *)tradeBtn {
    
    if (_delegate && [_delegate respondsToSelector:@selector(tradeView:price:hands:)]) {
        [_delegate tradeView:self price:self.priceField.numValue hands:self.handsField.numValue];
    }
    
    !self.tradeBlock ? : self.tradeBlock(self, self.tradeType,self.priceField.numValue, self.handsField.numValue);
    
}

- (void)PL_ProvidencetapAction:(UITapGestureRecognizer *)tap {
    
    [self PL_ProvidencequitBtnAction:self.quitBtn];
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if ([touch.view isEqual:self.backView]) {
        return NO;
    }
    return YES;
}

//- (void)keyBoardStateChangedWithType:(KeyBoardChangedType)changeType beginFrame:(CGRect)beginFrame endFrame:(CGRect)endFrame userInfo:(NSDictionary *)info {
//    
//    [UIView animateWithDuration:0.2 animations:^{
//        self.backView.top = endFrame.origin.y - (SCALE_Length(160.0f) + TabMustAdd);
//    }];
//    
//}

#pragma mark - lazy load ---
//
//- (UIView *)backView {
//    if (!_backView) {
//        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.frame), SCREEN_Width, SCALE_Length(160.0f) + TabMustAdd)];
//        _backView.backgroundColor = [[UIColor colorWithHexString:@"0xffffff"] colorWithAlphaComponent:1.0f];
//        _backView.alpha = 1.0f;
//    }
//    return _backView;
//}
//
//- (PL_ProvidenceStepperView *)priceField {
//
//    if (!_priceField) {
//        _priceField = [[PL_ProvidenceStepperView alloc] initWithFrame:CGRectZero hideFineTuning:YES];
//        _priceField.decimal = 2;
//        _priceField.minValue = 0;
//        _priceField.isCanPaste = NO;
//        _priceField.isForceNumKeyBoard = YES;
//        _priceField.attributedPlaceHolder = [@"买入价" PL_ProvidencecreateAttributedStringWithFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor colorWithHexString:@"0xcccccc"]];
//        _priceField.textFont = [UIFont PL_ProvidencesystemFontOfSize:12.0f];
//        _priceField.textColor = [UIColor colorWithHexString:@"0x666666"];
//        [_priceField updateText:self.priceNow];
//        _priceField.layer.borderColor = [UIColor colorWithHexString:@"0x50B383"].CGColor;
//        _priceField.layer.borderWidth = 2.0f;
//        weakSelf(self);
//        _priceField.valueChangeBlock = ^(NSString *value) {
////            strongSelf(weakSelf);
//
//        };
//    }
//    return _priceField;
//}
    
    - (void)updateAvailableHands:(NSUInteger)hands {
        
        if (self.tradeType == PL_ProvidenceTradeTypeSell) {
            NSMutableAttributedString *tipString = [@"可卖：" PL_ProvidencecreateAttributedStringWithFont:[UIFont fontWithName:fFont size:12.0f] textColor:[UIColor colorWithHexString:@"0x666666"]].mutableCopy;
            NSString *handsString = [NSString stringWithFormat:@"%ld",hands];
            [tipString appendAttributedString:[handsString PL_ProvidencecreateAttributedStringWithFont:[UIFont fontWithName:fFont size:12.0f] textColor:[UIColor colorWithHexString:@"0x4299FF"]]];
            
            [self.tipLabel setAttributedText:tipString];
        }else {
            NSMutableAttributedString *tipString = [@"可买：" PL_ProvidencecreateAttributedStringWithFont:[UIFont fontWithName:fFont size:12.0f] textColor:[UIColor colorWithHexString:@"0x666666"]].mutableCopy;
            NSString *handsString = [NSString stringWithFormat:@"%ld",hands];
            [tipString appendAttributedString:[handsString PL_ProvidencecreateAttributedStringWithFont:[UIFont fontWithName:fFont size:12.0f] textColor:[UIColor colorWithHexString:@"0x4299FF"]]];
            
            [self.tipLabel setAttributedText:tipString];
        }
    }

    - (void)switchTradeViewWithType:(PL_ProvidenceTradeType)tradeType {
        
        if(tradeType == PL_ProvidenceTradeTypeSell) {
            self.tradeType = PL_ProvidenceTradeTypeSell;
            self.priceField.layer.borderColor = [UIColor colorWithHexString:@"0xE04A59"].CGColor;
            self.handsField.layer.borderColor = [UIColor colorWithHexString:@"0xE04A59"].CGColor;
            self.tradeBtn.backgroundColor = [UIColor colorWithHexString:@"0xE04A59"];
            [self.tradeBtn setTitle:@"卖出" forState:UIControlStateNormal];
            self.priceField.attributedPlaceHolder = [@"卖出价" PL_ProvidencecreateAttributedStringWithFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor colorWithHexString:@"0xcccccc"]];
            self.handsField.attributedPlaceHolder = [@"卖出数量" PL_ProvidencecreateAttributedStringWithFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor colorWithHexString:@"0xcccccc"]];

        }else {
            self.tradeType = PL_ProvidenceTradeTypeBuy;
            [self.tradeBtn setTitle:@"买入" forState:UIControlStateNormal];
            self.priceField.layer.borderColor = [UIColor colorWithHexString:@"0x50B383"].CGColor;
            self.handsField.layer.borderColor = [UIColor colorWithHexString:@"0x50B383"].CGColor;
            self.tradeBtn.backgroundColor = [UIColor colorWithHexString:@"0x50B383"];
            self.priceField.attributedPlaceHolder = [@"买入价" PL_ProvidencecreateAttributedStringWithFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor colorWithHexString:@"0xcccccc"]];
            self.handsField.attributedPlaceHolder = [@"买入数量" PL_ProvidencecreateAttributedStringWithFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor colorWithHexString:@"0xcccccc"]];
        }
    }

    #pragma mark - 私有方法 --



- (PL_ProvidenceStepperView *)handsField {
    
    if (!_handsField) {
        _handsField = [[PL_ProvidenceStepperView alloc] initWithFrame:CGRectZero hideFineTuning:YES];
        _handsField.decimal = 0;
        _handsField.minValue = 0;
        _handsField.isCanPaste = NO;
        _handsField.isForceNumKeyBoard = YES;
        _handsField.attributedPlaceHolder = [@"买入数量" PL_ProvidencecreateAttributedStringWithFont:[UIFont systemFontOfSize:12.0f] textColor:[UIColor colorWithHexString:@"0xcccccc"]];
        _handsField.textFont = [UIFont PL_ProvidencesystemFontOfSize:12.0f];
        _handsField.textColor = [UIColor colorWithHexString:@"0x666666"];
        _handsField.layer.borderColor = [UIColor colorWithHexString:@"0x50B383"].CGColor;
        _handsField.layer.borderWidth = 2.0f;
        weakSelf(self);
        _handsField.valueChangeBlock = ^(NSString *value) {
//            strongSelf(weakSelf);
            
        };
    }
    return _handsField;
}

- (UIButton *)quitBtn {
    if (!_quitBtn) {
        _quitBtn = [[UIButton alloc] init];
        [_quitBtn setImage:[UIImage imageNamed:@"icon_login_quitBtn"] forState:UIControlStateNormal];
        [_quitBtn addTarget:self action:@selector(PL_ProvidencequitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitBtn;
}

- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment = NSTextAlignmentRight;
        _tipLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _tipLabel.text = @"可买0股";
    }
    return _tipLabel;
}

- (UIButton *)tradeBtn {
    if (!_tradeBtn) {
        _tradeBtn = [[UIButton alloc] init];
        [_tradeBtn setTitle:@"买入" forState:UIControlStateNormal];
        [_tradeBtn setBackgroundColor:kMainColor];
        [_tradeBtn addTarget:self action:@selector(PL_ProvidencetradeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tradeBtn;
}

- (UITapGestureRecognizer *)tapGesture {
    if (!_tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PL_ProvidencetapAction:)];
        _tapGesture.delegate = self;
    }
    return _tapGesture;
}
@end
