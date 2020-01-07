//
//  PL_ProvidenceStepperView.m
//  kkcoin
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// walker on 2018/7/23.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "PL_ProvidenceStepperView.h"
#import "PL_ProvidenceIndentTextField.h"
@interface PL_ProvidenceStepperView ()<UITextFieldOtherProtocol,UITextFieldDelegate>

/** textFiled */
@property (strong, nonatomic) PL_ProvidenceIndentTextField *textField;

/** 加号按钮 */
@property (strong, nonatomic) UIButton *addBtn;

/** 减号按钮 */
@property (strong, nonatomic) UIButton *subtractBtn;

/** 是否隐藏加减号 */
@property (assign, nonatomic) BOOL isHideFT;

/** 文字 */
@property (strong, nonatomic, readwrite) NSString *text;
@end

@implementation PL_ProvidenceStepperView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    [NSObject PL_ProvidencedrawTextBackGroundInRect:rect content:ctx boderColor:[UIColor colorWithHexString:@"0xcccccc"] boderWidth:SCALE_Length(1.0f) fillColor:[UIColor clearColor]];
}




/**
 初始化
 
 @param frame 尺寸
 @param isHide 是否隐藏加减号
 */
- (instancetype)initWithFrame:(CGRect)frame hideFineTuning:(BOOL)isHide {
    if (self = [super initWithFrame:frame]) {
        
        self.isHideFT = isHide;
        
        [self PL_Providenceinitialize];
        
        [self PL_ProvidencesetUpUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self PL_Providenceinitialize];
        
        [self PL_ProvidencesetUpUI];
    }
    return self;
}

#pragma mark - 控件事件 ---

/**
 减号按钮事件
 */
- (void)PL_ProvidencesubtractBtnAction:(UIButton *)btn {
    
    if(!self.isCanEdit) {
        return;
    }
    double value = [self.textField.text doubleValue];
    
    if (value >= self.minValue + self.scaleValue) {
        value -= self.scaleValue;
        NSString *valueString = [NSString PL_ProvidencefixNumString:[@(value) stringValue] minDecimalsLimit:self.decimal maxDecimalsLimit:self.decimal];
        self.textField.text = valueString;
        
        !self.valueChangeBlock ?: self.valueChangeBlock(self.textField.text);
    }
}

/**
 加号按钮事件
 */
- (void)PL_ProvidenceaddBtnAction:(UIButton *)btn {
    
    if (!self.isCanEdit) {
        return;
    }
    
    double value = [self.textField.text doubleValue];
    
    if (value <= self.maxValue - self.scaleValue) {
        value += self.scaleValue;
        NSString *valueString = [NSString PL_ProvidencefixNumString:[@(value) stringValue] minDecimalsLimit:self.decimal maxDecimalsLimit:self.decimal];
        self.textField.text = valueString;
        
        !self.valueChangeBlock ?: self.valueChangeBlock(self.textField.text);
    }
    
    if (value <= self.minValue - self.scaleValue) {
        self.textField.text = [NSString PL_ProvidencefixNumString:[@(self.minValue) stringValue] minDecimalsLimit:self.decimal maxDecimalsLimit:self.decimal];;
        
        !self.valueChangeBlock ?: self.valueChangeBlock(self.textField.text);
    }
}

#pragma mark - 公共方法或get方法 --

- (NSString *)numValue {
    NSString *num = @"0";
    
    if (self.textField.text && self.textField.text.length) {
        if ([self.textField.text doubleValue] > 0) {
            num = self.textField.text;
        }
    }
    
    return num;
}

- (void)setIsForceNumKeyBoard:(BOOL)isForceNumKeyBoard {
    _isForceNumKeyBoard = isForceNumKeyBoard;
    
    if (_isForceNumKeyBoard) {
        self.textField.keyboardType = UIKeyboardTypeDecimalPad;
        self.textField.isUniteDecimalPointType = YES;
    }else {
        self.textField.keyboardType = UIKeyboardTypeDefault;
    }
}

- (void)setIsCanPaste:(BOOL)isCanPaste {
    _isCanPaste = isCanPaste;
    
    self.textField.pasteEnable = _isCanPaste;
}

- (void)setAttributedPlaceHolder:(NSAttributedString *)attributedPlaceHolder {
    if (attributedPlaceHolder) {
        _attributedPlaceHolder = attributedPlaceHolder;
    }
    
    self.textField.attributedPlaceholder = _attributedPlaceHolder;
}

- (void)setPlaceHolder:(NSString *)placeHolder {
    if (placeHolder && placeHolder.length >= 1) {
        _placeHolder = placeHolder;
    }
    
    self.textField.placeholder = _placeHolder;
}

- (void)setTextFont:(UIFont *)textFont {
    if(textFont) {
        _textFont = textFont;
        
        self.textField.font = _textFont;
    }
}

- (void)setTextColor:(UIColor *)textColor {
    if (textColor) {
        _textColor = textColor;
        self.textField.textColor = _textColor;
    }
}

- (NSString *)text {
    
    if (self.textField) {
        _text = self.textField.text;
    }else {
        _text = @"";
    }
    return _text;
}

- (void)setIsCanEdit:(BOOL)isCanEdit {
    _isCanEdit = isCanEdit;
    
    self.textField.enabled = _isCanEdit;
    if (_isCanEdit) {
        self.textField.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    }else {
        self.textField.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    }
    
}

- (void)setDecimal:(NSInteger)decimal {
    _decimal = decimal;
    self.textField.decimal = _decimal;
}

#pragma mark - 公共方法 --

- (void)updateText:(NSString *)text {
    
    if (text) {
        _text = text;
        self.textField.text = _text;
    }
}

#pragma mark - 代理方法 -

/**
 输入框文字改变的回调
 
 @param textField 输入框
 @param info 其他信息
 */
- (void)textField:(PL_ProvidenceIndentTextField *)textField textDidChangeWithUserInfo:(NSDictionary * _Nullable)info {
    if (textField != self.textField) {
        return;
    }
    if([textField.text doubleValue] >= self.maxValue) {
        textField.text = [NSString PL_ProvidencefixNumString:[@(self.maxValue) stringValue] minDecimalsLimit:self.decimal maxDecimalsLimit:self.decimal];
    }
    
    !self.valueChangeBlock ? : self.valueChangeBlock(self.textField.text);
}

/**
 文字被改变的代理方法
 */
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    
    //    !self.valueChangeBlock ?: self.valueChangeBlock(self.textField.text);
    return YES;
}

#pragma mark - 私有方法 --



- (void)PL_Providenceinitialize {
    
    ;
    
    self.isForceNumKeyBoard = YES;
    self.scaleValue = 1.0f;
    self.minValue = 0.0f;
    self.defaultValue = 0;
    self.maxValue = DBL_MAX;
    self.isCanEdit = YES;
}

- (void)PL_ProvidencesetUpUI {
    
    self.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    if (!self.isHideFT) {
        [self addSubview:self.addBtn];
        [self addSubview:self.subtractBtn];
    }
    [self addSubview:self.textField];
    
    [self PL_ProvidencelayoutWithMasonry];
}

- (void)PL_ProvidencelayoutWithMasonry {
    
    if (!self.isHideFT) {
        [self.subtractBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(self.mas_height);
            make.width.equalTo(self.mas_height);
        }];
        
        [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right);
            make.centerY.equalTo(self.mas_centerY);
            make.height.equalTo(self.mas_height);
            make.width.equalTo(self.mas_height);
        }];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.subtractBtn.mas_right);
            make.right.equalTo(self.addBtn.mas_left);
            make.top.equalTo(self.mas_top).offset(SCALE_Length(1.0f));
            make.bottom.equalTo(self.mas_bottom).offset(SCALE_Length(- 1.0f));
        }];
    }else {
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(SCALE_Length(1.0f));
            make.right.equalTo(self.mas_right).offset(SCALE_Length(- 1.0f));
            make.top.equalTo(self.mas_top).offset(SCALE_Length(1.0f));
            make.bottom.equalTo(self.mas_bottom).offset(SCALE_Length(- 1.0f));
        }];
    }
}

#pragma mark - 懒加载 --

- (PL_ProvidenceIndentTextField *)textField {
    if (!_textField) {
        _textField = [[PL_ProvidenceIndentTextField alloc] initWithFrame:CGRectZero indentWidth:0.0f];
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
        _textField.textColor = [UIColor whiteColor];
        _textField.keyboardType = UIKeyboardTypeDecimalPad;
        _textField.PL_ProvidenceIndentTextFieldDelegate = self;
        _textField.delegate = self;
        _textField.isNum = YES;
        _textField.isUniteDecimalPointType = YES;
    }
    return _textField;
}

- (UIButton *)addBtn {
    
    if (!_addBtn) {
        _addBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_addBtn setImage:[UIImage imageNamed:@"trade_plus"] forState:UIControlStateNormal];
        [_addBtn addTarget:self action:@selector(PL_ProvidenceaddBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBtn;
}

- (UIButton *)subtractBtn {
    
    if (!_subtractBtn) {
        _subtractBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_subtractBtn setImage:[UIImage imageNamed:@"trade_reduce"] forState:UIControlStateNormal];
        [_subtractBtn addTarget:self action:@selector(PL_ProvidencesubtractBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _subtractBtn;
}

@end
