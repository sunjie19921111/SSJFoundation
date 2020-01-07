//
//  PL_ProvidenceHomeScreenLoadVC.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/17.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceHomeScreenLoadVC.h"
#import "PL_ProvidenceFullScreenKLineView.h"
#import "PL_ProvidenceListMenuView.h"
#import "PL_ProvidenceZSHKLineView.h"
#import "PL_ProvidenceLineDataLogic.h"
#import "PL_ProvidenceZSHKLineView.h"
#import "PL_ProvidenceLineDataLogic.h"
#import "PL_ProvidenceMarketLogic.h"
#import "PL_ProvidenceHomeStockModel.h"

#define kBaseBtnTag (7893)


@interface PL_ProvidenceHomeScreenLoadVC ()
<
PL_ProvidenceListMenuViewProtocol,
UIGestureRecognizerDelegate,
UINavigationBarDelegate
>


@property (strong, nonatomic) UIButton *PL_ProvidencetimeLineBtn;
@property (strong, nonatomic) UIButton *PL_ProvidencedayLineBtn;

@property (strong, nonatomic) UIButton *PL_ProvidenceweekLineBtn;

@property (strong, nonatomic) UIButton *PL_ProvidencemouthLineBtn;

@property (strong, nonatomic) UITapGestureRecognizer *PL_ProvidencebackTapGesture;

@property (strong, nonatomic) NSArray *PL_ProvidencebottomBtnArray;

@property (copy, nonatomic) NSString *PL_ProvidencetimeTypeString;

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////


@property (strong, nonatomic) UILabel *currentPriceLabel;

@property (strong, nonatomic) UILabel *hour_24_changeLabel;

@property (strong, nonatomic) UIButton *quitBtn;

@property (strong, nonatomic) PL_ProvidenceListMenuView * indicatorSelectView;

@property (strong, nonatomic) PL_ProvidenceListMenuView * timeSelectView;

@property (strong, nonatomic) UIButton *minuteBtn;

@property (strong, nonatomic) UIButton *hourBtn;

@property (strong, nonatomic) UIButton *timeLineBtn;
@property (strong, nonatomic) UIButton *dayLineBtn;

@property (strong, nonatomic) UIButton *weekLineBtn;

@property (strong, nonatomic) UIButton *mouthLineBtn;

@property (strong, nonatomic) UITapGestureRecognizer *backTapGesture;

@property (strong, nonatomic) NSArray *bottomBtnArray;

@property (copy, nonatomic) NSString *timeTypeString;

@property (strong, nonatomic) NSArray *kLineTimeTypeArray;

@property (strong, nonatomic) PL_ProvidenceHomeStockModel *stockModel;

@property (strong, nonatomic) NSString *marketCode;

@property (strong, nonatomic) UIColor *priceColor;

@property (strong, nonatomic) PL_ProvidenceFullScreenKLineView *fullKLineView;

@property (strong, nonatomic) UIView *backView;

@property (strong, nonatomic) UILabel *symbolLabel;


@end

@implementation PL_ProvidenceHomeScreenLoadVC

- (PL_ProvidenceListMenuView *)indicatorSelectView {
    if (!_indicatorSelectView) {
        _indicatorSelectView = [[PL_ProvidenceListMenuView alloc] initWithFrame:CGRectZero identifier:@"indicatorSelectView"];
        _indicatorSelectView.delegate = self;
        _indicatorSelectView.isShowSeparator = YES;
        _indicatorSelectView.backgroundColor = [UIColor colorWithHexString:@"0xf8f8f8"];
        _indicatorSelectView.textColor = [UIColor colorWithHexString:@"0x666666"];
        _indicatorSelectView.heightForRow = (SCREEN_Width - 100.0f) / 5.0f;
        _indicatorSelectView.textAlignment = NSTextAlignmentCenter;
    }
    return _indicatorSelectView;
}

- (PL_ProvidenceListMenuView *)timeSelectView {
    if (!_timeSelectView) {
        _timeSelectView = [[PL_ProvidenceListMenuView alloc] initWithFrame:CGRectZero identifier:self.minuteBtn.currentTitle];
        _timeSelectView.backgroundColor = [UIColor colorWithHexString:@"0xf8f8f8"];
        _timeSelectView.isShowSeparator = YES;
        _timeSelectView.delegate = self;
        _timeSelectView.textColor = [UIColor colorWithHexString:@"0x666666"];
        _timeSelectView.textAlignment = NSTextAlignmentCenter;
    }
    return _timeSelectView;
}

- (UIButton *)timeLineBtn {
    
    if (!_timeLineBtn) {
        _timeLineBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_timeLineBtn setTitle:@"分时" forState:UIControlStateNormal];
        _timeLineBtn.tag = kBaseBtnTag + 0;
        [_timeLineBtn addTarget:self action:@selector(PL_ProvidencetimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeLineBtn;
}

- (UIButton *)minuteBtn {
    if (!_minuteBtn) {
        _minuteBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_minuteBtn setTitle:[NSString stringWithFormat:@"%@ ▼",@"分钟"] forState:UIControlStateNormal];
        _minuteBtn.tag = kBaseBtnTag + 1;
        [_minuteBtn addTarget:self action:@selector(PL_ProvidencetimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _minuteBtn;
}

//▲
- (UIButton *)hourBtn{
    if (!_hourBtn) {
        _hourBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_hourBtn setTitle:@"1时" forState:UIControlStateNormal];
        _hourBtn.tag = kBaseBtnTag + 2;
        [_hourBtn addTarget:self action:@selector(PL_ProvidencetimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hourBtn;
}


- (UIButton *)dayLineBtn {
    
    if (!_dayLineBtn) {
        _dayLineBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_dayLineBtn setTitle:@"1日" forState:UIControlStateNormal];
        _dayLineBtn.tag = kBaseBtnTag + 3;
        [_dayLineBtn addTarget:self action:@selector(PL_ProvidencetimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dayLineBtn;
}

- (UIButton *)weekLineBtn {
    
    if (!_weekLineBtn) {
        _weekLineBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_weekLineBtn setTitle:@"1周" forState:UIControlStateNormal];
        _weekLineBtn.tag = kBaseBtnTag + 4;
        [_weekLineBtn addTarget:self action:@selector(PL_ProvidencetimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weekLineBtn;
}

- (UIButton *)mouthLineBtn {
    if (!_mouthLineBtn) {
        _mouthLineBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_mouthLineBtn setTitle:@"1月" forState:UIControlStateNormal];
        _mouthLineBtn.tag = kBaseBtnTag + 5;
        [_mouthLineBtn addTarget:self action:@selector(PL_ProvidencetimeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _mouthLineBtn;
}

- (NSArray *)bottomBtnArray {
    if (!_bottomBtnArray) {
        _bottomBtnArray = @[self.mouthLineBtn,self.weekLineBtn,self.dayLineBtn,self.hourBtn,self.minuteBtn,self.timeLineBtn];
    }
    return _bottomBtnArray;
}

- (NSArray *)kLineTimeTypeArray {
    if(!_kLineTimeTypeArray) {
        _kLineTimeTypeArray = @[@"分时",@"1分", @"5分", @"15分", @"30分", @"1时",@"1日",@"1周",@"1月"];
    }
    return _kLineTimeTypeArray;
}



- (instancetype)initWithModel:(PL_ProvidenceHomeStockModel *)listModel marketCode:(NSString *)marketCode {
    if(self = [super init]) {
        if (listModel) {
            self.stockModel = listModel;
        }
        if (!isStrEmpty(marketCode)) {
            self.marketCode = marketCode;
        }
    }
    return self;
}

- (void)PL_Providenceinitialize {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.delegate = (id)self;
    self.priceColor = [UIColor colorWithHexString:@"0x333333"];
    self.timeTypeString = @"1日";
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self PL_Providenceinitialize];;
    [self PL_ProvidenceconfigUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self PL_ProvidenceupdateKlineData];
    [self PL_ProvidenceupdateStockDetailInfo];
    [self PL_ProvidencetransFormBackView];
    [self PL_ProvidencesetSelectedStateForBtnWithTimeString:self.timeTypeString];
    
}


- (void)PL_ProvidenceconfigUI {
    
    [self.backView addSubview:self.fullKLineView];
    [self.backView addSubview:self.quitBtn];
    [self.backView addSubview:self.symbolLabel];
    [self.backView addSubview:self.currentPriceLabel];
    [self.backView addSubview:self.hour_24_changeLabel];
    
    [self.backView addSubview:self.indicatorSelectView];
    [self.backView addSubview:self.timeLineBtn];
    [self.backView addSubview:self.dayLineBtn];
    [self.backView addSubview:self.weekLineBtn];
    [self.backView addSubview:self.mouthLineBtn];
    [self.backView addSubview:self.hourBtn];
    [self.backView addSubview:self.minuteBtn];
    
    [self.view addSubview:self.backView];
    
    [self PL_ProvidencelayoutWithMasonry];
}


#pragma mark - 控件事件 ---

- (void)PL_ProvidencebackViewTapAction:(UITapGestureRecognizer *)tap {
    
    [self PL_ProvidencehideSelectedView];
}

- (void)PL_ProvidencequitBtnAction:(UIButton *)btn {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)PL_ProvidencetimeBtnAction:(UIButton *)btn {
    
    NSUInteger tag = btn.tag - kBaseBtnTag;
    
    switch (tag) {
        case 0:
        {   // 分时
            [self PL_ProvidencehideSelectedView];
            
            [self PL_ProvidencesetSelectedStateForBtn:self.timeLineBtn];
            // 切换K线周期
            [self PL_ProvidenceupdateKlineTimeTypeStringWithTitle:self.timeLineBtn.currentTitle];
        }
            break;
            
            
            
        case 1:
        {
            // 分钟
            if(_timeSelectView && [self.backView.subviews containsObject:_timeSelectView] && _timeSelectView.tag == self.minuteBtn.tag) {
                [self PL_ProvidencehideSelectedView];
            }else {
                
                [self PL_ProvidenceshowSelectedViewWithBtn:self.minuteBtn];
            }
            
        }
            break;
            
        case 2:
        {   // 小时
            
            [self PL_ProvidencehideSelectedView];
            [self PL_ProvidencesetSelectedStateForBtn:self.hourBtn];
            
            // 切换K线周期
            [self PL_ProvidenceupdateKlineTimeTypeStringWithTitle:self.hourBtn.currentTitle];
        }
            break;
            
        case 3:
        {   // 日线
            [self PL_ProvidencehideSelectedView];
            [self PL_ProvidencesetSelectedStateForBtn:self.dayLineBtn];
            
            // 切换K线周期
            [self PL_ProvidenceupdateKlineTimeTypeStringWithTitle:self.dayLineBtn.currentTitle];
        }
            break;
            
        case 4:
        {
            
            // 周线
            [self PL_ProvidencehideSelectedView];
            [self PL_ProvidencesetSelectedStateForBtn:self.weekLineBtn];
            
            // 切换K线周期
            [self PL_ProvidenceupdateKlineTimeTypeStringWithTitle:self.weekLineBtn.currentTitle];
        }
            break;
            
        case 5:
        {
            [self PL_ProvidencehideSelectedView];
            [self PL_ProvidencesetSelectedStateForBtn:self.mouthLineBtn];
            
            // 切换K线周期
            [self PL_ProvidenceupdateKlineTimeTypeStringWithTitle:self.mouthLineBtn.currentTitle];
        }
            break;
            
        default:
            break;
    }
}

/**
 对视图进行旋转
 */
- (void)PL_ProvidencetransFormBackView {
    
    self.view.transform = CGAffineTransformMakeRotation(M_PI_2);
}


/**
 计算并展示24h涨跌
 */
- (void)PL_Providenceupdate24HchangeWithRate:(NSString *)rate24 {
    NSString *rate = [NSString stringWithFormat:@"%.2f",[rate24 doubleValue] * 100.0];
    
    if ([rate24 doubleValue] > 0) {
        self.priceColor = [UIColor colorWithHexString:@"0x50B383"];
    }else if([rate24 doubleValue] < 0) {
        self.priceColor = [UIColor colorWithHexString:@"0xE04A59"];
    }else if([rate24 doubleValue] == 0) {
        self.priceColor = [UIColor colorWithHexString:@"0x333333"];
    }
    NSMutableAttributedString *mutableAttri = [[NSMutableAttributedString alloc] initWithString:@"涨跌幅   " attributes:@{NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x666666"],NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@%%",rate] attributes:@{NSForegroundColorAttributeName:self.priceColor,NSFontAttributeName:[UIFont systemFontOfSize:17.0]}];
    [mutableAttri appendAttributedString:attri];
    
    [self.hour_24_changeLabel setAttributedText:mutableAttri];
}


- (void)PL_ProvidenceupdateKlineData {
    
    // K线数据请求
    
    NSString *market = self.marketCode;
    
    if ([self.marketCode isEqualToString:@"usa"]) {
        market = self.stockModel.market;
    }
    
    [self.fullKLineView startAnimatingWithOffset:CGPointZero activityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    weakSelf(self);
    [PL_ProvidenceMarketLogic getKlineDateWithMarketCode:self.marketCode market:market symbol:self.stockModel.code timeType:[PL_ProvidenceMarketLogic getTimeInervalWithTimeType:self.timeTypeString] success:^(NSArray<PL_ProvidenceKLineModel *> * _Nonnull klineArray) {
        
        [weakSelf.fullKLineView stopAnimating];
        
        [weakSelf.fullKLineView.dataCenter cleanData];
        
        [weakSelf.fullKLineView.dataCenter reloadDataWithArray:klineArray withDecimalsLimit:2];
        if ([weakSelf.timeTypeString isEqualToString:@"分时"]) {
            [weakSelf.fullKLineView switchKLineMainViewToType:KLineMainViewTypeTimeLineWithMA];
        }else {
            [weakSelf.fullKLineView switchKLineMainViewToType:KLineMainViewTypeKLineWithMA];
        }
        
    } faild:^(NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        
        [weakSelf.fullKLineView stopAnimating];
    }];
    
}

/* 更新股票信息 */
- (void)PL_ProvidenceupdateStockDetailInfo {
    
    self.symbolLabel.text = self.stockModel.name ? : @"--";
    
    [self PL_Providenceupdate24HchangeWithRate:self.stockModel.changepercent];
    
    self.currentPriceLabel.textColor = self.priceColor;
    self.currentPriceLabel.text = self.stockModel.trade ? : @"--";
}


/**
 更新K线指标
 
 @param title 按钮标题
 @param indexPath 按钮的位置
 */
- (void)PL_ProvidenceswitchIndicatorWithSelectedTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath {
    
    if (!title || title.length < 1) {
        return;
    }
    
    if ([title isEqualToString:@"MA"]) {
        switch (self.fullKLineView.mainViewType) {
            case KLineMainViewTypeKLineWithMA:
            {
                [self.fullKLineView switchKLineMainViewToType:KLineMainViewTypeKLine];
                [self.indicatorSelectView setSelectedState:NO forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
            }
                break;
            case KLineMainViewTypeTimeLine:
            {
                [self.fullKLineView switchKLineMainViewToType:KLineMainViewTypeTimeLineWithMA];
                [self.indicatorSelectView setSelectedState:YES forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
            }
                break;
            case KLineMainViewTypeTimeLineWithMA:
            {
                [self.fullKLineView switchKLineMainViewToType:KLineMainViewTypeTimeLine];
                [self.indicatorSelectView setSelectedState:NO forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
            }
                break;
                
            default:
            {
                [self.fullKLineView switchKLineMainViewToType:KLineMainViewTypeKLineWithMA];
                [self.indicatorSelectView setSelectedState:YES forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
            }
                break;
        }
        
    }else if([title isEqualToString:@"BOLL"]){
        if (self.fullKLineView.mainViewType == KLineMainViewTypeTimeLineWithMA || self.fullKLineView.mainViewType == KLineMainViewTypeTimeLine) {
            [self.fullKLineView switchKLineMainViewToType:KLineMainViewTypeTimeLineWithMA];
            [self.indicatorSelectView setSelectedState:YES forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] cleanOtherItemCurrentSection:YES];
        }else {
            if (self.fullKLineView.mainViewType == KLineMainViewTypeKLineWithBOLL) {
                [self.fullKLineView switchKLineMainViewToType:KLineMainViewTypeKLine];
                [self.indicatorSelectView setSelectedState:NO forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
            }else {
                [self.fullKLineView switchKLineMainViewToType:KLineMainViewTypeKLineWithBOLL];
                [self.indicatorSelectView setSelectedState:YES forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
            }
        }
        
    }else if([title isEqualToString:@"KDJ"]) {
        if (self.fullKLineView.assistantViewType == KLineAssistantViewTypeKDJ) {
            [self.fullKLineView switchKlineAssistantViewToType:KLineAssistantViewTypeVolWithMA];
            [self.indicatorSelectView setSelectedState:NO forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
        }else {
            [self.fullKLineView switchKlineAssistantViewToType:KLineAssistantViewTypeKDJ];
            [self.indicatorSelectView setSelectedState:YES forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
        }
    }else if([title isEqualToString:@"MACD"]) {
        if (self.fullKLineView.assistantViewType == KLineAssistantViewTypeMACD) {
            [self.fullKLineView switchKlineAssistantViewToType:KLineAssistantViewTypeVolWithMA];
            [self.indicatorSelectView setSelectedState:NO forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
        }else {
            [self.fullKLineView switchKlineAssistantViewToType:KLineAssistantViewTypeMACD];
            [self.indicatorSelectView setSelectedState:YES forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
        }
    }else if([title isEqualToString:@"RSI"]) {
        
        if (self.fullKLineView.assistantViewType == KLineAssistantViewTypeRSI) {
            [self.fullKLineView switchKlineAssistantViewToType:KLineAssistantViewTypeVolWithMA];
            [self.indicatorSelectView setSelectedState:NO forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
        }else {
            [self.fullKLineView switchKlineAssistantViewToType:KLineAssistantViewTypeRSI];
            [self.indicatorSelectView setSelectedState:YES forIndexPath:indexPath cleanOtherItemCurrentSection:YES];
        }
    }
}

/**
 更新K线视图样式
 */
- (void)PL_ProvidenceupdateKLineMainViewType {
    
    self.fullKLineView.dataCenter.decimalsLimit = 2;
    
    if ([self.timeTypeString isEqualToString:@"分时"]) {
        
        if (!(self.fullKLineView.mainViewType == KLineMainViewTypeTimeLine || self.fullKLineView.mainViewType == KLineMainViewTypeTimeLineWithMA)) {
            [self.fullKLineView switchKLineMainViewToType:KLineMainViewTypeTimeLineWithMA];
            [self.indicatorSelectView setSelectedState:YES forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] cleanOtherItemCurrentSection:YES];
        }
    }else {
        
        if ((self.fullKLineView.mainViewType == KLineMainViewTypeTimeLineWithMA || self.fullKLineView.mainViewType == KLineMainViewTypeTimeLine)) {
            
            [self.fullKLineView switchKLineMainViewToType:KLineMainViewTypeKLineWithMA];
            [self.indicatorSelectView setSelectedState:YES forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] cleanOtherItemCurrentSection:YES];
        }else if(self.fullKLineView.mainViewType == KLineMainViewTypeKLineWithMA) {
            [self.indicatorSelectView setSelectedState:YES forIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] cleanOtherItemCurrentSection:YES];
        }
    }
}

/**
 收回选择视图
 */
- (void)PL_ProvidencehideSelectedView {
    
    if (_timeSelectView) {
        [self.timeSelectView removeFromSuperview];
        
        NSString *newMinuteTitle = [self.minuteBtn.currentTitle stringByReplacingOccurrencesOfString:@"▲" withString:@"▼"];
        [self.minuteBtn setTitle:newMinuteTitle forState:UIControlStateNormal];
        
    }
}

/**
 展示选择视图
 
 @param btn 需要展示选择视图的按钮
 */
- (void)PL_ProvidenceshowSelectedViewWithBtn:(UIButton *)btn {
    
    [self.backView addSubview:self.timeSelectView];
    [self.timeSelectView updateIdentifier:btn.currentTitle];
    
    if (btn == self.minuteBtn) {
        
        self.timeSelectView.frame = CGRectMake(0, 0, 100.0f, 4*44.0f);
        [self.timeSelectView reloadListData];
        self.timeSelectView.tag = self.minuteBtn.tag;
        [self.timeSelectView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.minuteBtn.mas_top);
            make.centerX.equalTo(self.minuteBtn.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(100.0f, 4 * 44.0f));
        }];
        
        NSString *newMinuteTitle = [self.minuteBtn.currentTitle stringByReplacingOccurrencesOfString:@"▼" withString:@"▲"];
        [self.minuteBtn setTitle:newMinuteTitle forState:UIControlStateNormal];
        
    }
}

/**
 设置选中状态
 
 @param btn 设置选中状态的按钮
 */
- (void)PL_ProvidencesetSelectedStateForBtn:(UIButton *)btn {
    
    for (UIButton *tmpBtn in self.bottomBtnArray) {
        if (tmpBtn.tag == btn.tag) {
            [tmpBtn setTitleColor:[UIColor colorWithHexString:@"0x4299FF"] forState:UIControlStateNormal];
        }else {
            [tmpBtn setTitleColor:[UIColor colorWithHexString:@"0x666666"] forState:UIControlStateNormal];
        }
    }
}

- (void)PL_ProvidencesetSelectedStateForBtnWithTimeString:(NSString *)timeType {
    if (timeType && timeType.length >= 1) {
        NSInteger index = [self.kLineTimeTypeArray indexOfObject:timeType];
        
        switch (index) {
            case 0:
            {
                [self PL_ProvidencesetSelectedStateForBtn:self.timeLineBtn];
            }
                break;
                
            case 1:
            case 2:
            case 3:
            case 4:
            {
                [self.minuteBtn setTitle:[NSString stringWithFormat:@"%@ ▼",self.timeTypeString] forState:UIControlStateNormal];
                [self PL_ProvidencesetSelectedStateForBtn:self.minuteBtn];
            }
                break;
                
            case 5:
            {
                [self PL_ProvidencesetSelectedStateForBtn:self.hourBtn];
            }
                break;
            case 6:
            {
                [self PL_ProvidencesetSelectedStateForBtn:self.dayLineBtn];
                
            }
                break;
            case 7:
            {
                [self PL_ProvidencesetSelectedStateForBtn:self.weekLineBtn];
                
            }
                break;
            case 8:
            {
                [self PL_ProvidencesetSelectedStateForBtn:self.mouthLineBtn];
            }
                
                break;
            default:
                break;
        }
        
    }
}



#pragma mark - ListMenuView protocol ---

- (void)listMenuView:(PL_ProvidenceListMenuView *)view didSelectedAtIndexPath:(NSIndexPath *)indexPath itemTitle:(NSString *)title {
    
    [self PL_ProvidencehideSelectedView];
    
    if (view.identifier) {
        
        if ([view.identifier isEqualToString:self.indicatorSelectView.identifier]) {
            // 根据标题切换指标
            [self PL_ProvidenceswitchIndicatorWithSelectedTitle:title indexPath:indexPath];
            
        }else if(view.tag == self.minuteBtn.tag){
            [self.minuteBtn setTitle:[NSString stringWithFormat:@"%@ ▼",@"分钟"] forState:UIControlStateNormal];
            [self.minuteBtn setTitle:[NSString stringWithFormat:@"%@ ▼",title] forState:UIControlStateNormal];
            [self PL_ProvidencesetSelectedStateForBtn:self.minuteBtn];
            
            // 切换分钟k线
            [self PL_ProvidenceupdateKlineTimeTypeStringWithTitle:title];
            
            
        }
    }
}

- (NSArray *)itemTitlesAtListMenuView:(PL_ProvidenceListMenuView *)view {
    
    NSArray *dataSource = @[];
    
    if (view.identifier) {
        
        if ([view.identifier isEqualToString:self.indicatorSelectView.identifier]) {
            // 指标
            dataSource = @[@[@"MA",@"BOLL"],@[@"KDJ",@"MACD",@"RSI"]];
        }else if([view.identifier isEqualToString:self.minuteBtn.currentTitle]) {
            // 分钟
            dataSource = @[@"1分",@"5分",@"15分",@"30分"];
        }
    }
    return dataSource;
}

/**
 每个分区的高度
 
 @param section 分区数
 */
- (CGFloat)listMenuView:(PL_ProvidenceListMenuView *)view heightForSectionHeaderViewAtSection:(NSInteger)section {
    
    if ([view isEqual:self.indicatorSelectView] && section == 1) {
        return 1.0f;
    }else {
        return 0.0001f;
    }
}

- (UIView *)listMenuView:(PL_ProvidenceListMenuView *)view sectionHeaderViewAtSection:(NSInteger)section {
    
    if (view == self.indicatorSelectView) {
        if (section == 1) {
            UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.size.width, 1.0f)];
            sectionView.backgroundColor = [UIColor whiteColor];
            return sectionView;
        }
    }
    return nil;
}


#pragma mark - 手势代理方法 ---

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if([touch.view isDescendantOfView:self.timeSelectView] || [touch.view isDescendantOfView:self.indicatorSelectView]){
        return NO;
    }
    return YES;
}

/**
 使用masonry 布局
 */
- (void)PL_ProvidencelayoutWithMasonry {
    // 兼容iOS 9 以下版本，使用frame布局
    self.backView.frame = CGRectMake(0, 0, SCREEN_Height, SCREEN_Width);
    self.quitBtn.frame = CGRectMake(SCREEN_Height - 50.0f - TabMustAdd, 0, 50.0f, 50.0f);
    self.indicatorSelectView.frame = CGRectMake(SCREEN_Height - 50.0f - TabMustAdd, 50.0f, 50.0f, SCREEN_Width - 100.0f);
    
    self.mouthLineBtn.frame = CGRectMake(0.0f, SCREEN_Width - 50.0f, SCREEN_Height / 6.0, 50.0f);
    self.weekLineBtn.frame = CGRectMake(CGRectGetMaxX(self.mouthLineBtn.frame), SCREEN_Width - 50.0f, SCREEN_Height / 6.0, 50.0f);
    self.dayLineBtn.frame = CGRectMake(CGRectGetMaxX(self.weekLineBtn.frame), SCREEN_Width - 50.0f, SCREEN_Height / 6.0, 50.0f);
    self.hourBtn.frame = CGRectMake(CGRectGetMaxX(self.dayLineBtn.frame), SCREEN_Width - 50.0f, SCREEN_Height / 6.0, 50.0f);
    self.minuteBtn.frame = CGRectMake(CGRectGetMaxX(self.hourBtn.frame), SCREEN_Width - 50.0f, SCREEN_Height / 6.0, 50.0f);
    self.timeLineBtn.frame = CGRectMake(CGRectGetMaxX(self.minuteBtn.frame), SCREEN_Width - 50.0f, SCREEN_Height / 6.0, 50.0f);
    
    [self.symbolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(10.0f + 10.0f + NavMustAdd);
        make.top.equalTo(self.backView.mas_top);
        make.height.mas_equalTo(50.0f);
    }];
    
    [self.currentPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.symbolLabel.mas_right).offset(20.0f);
        make.top.equalTo(self.symbolLabel);
        make.height.mas_equalTo(50.0f);
    }];
    
    [self.hour_24_changeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentPriceLabel.mas_right).offset(50.0f);
        make.top.equalTo(self.currentPriceLabel);
        make.height.mas_equalTo(50.0f);
    }];
}


/**
 根据标题切换K线周期
 
 @param title 标题
 */
- (void)PL_ProvidenceupdateKlineTimeTypeStringWithTitle:(NSString *)title {
    
    if (!isStrEmpty(title) && ![title isEqualToString:self.timeTypeString]) {
        self.timeTypeString = title;
        
        
        [self PL_ProvidenceupdateKlineData];
        
        [self PL_ProvidenceupdateKLineMainViewType];
        
    }
}



#pragma mark - 懒加载 ---

- (PL_ProvidenceFullScreenKLineView *)fullKLineView {
    
    if (!_fullKLineView) {
        _fullKLineView = [[PL_ProvidenceFullScreenKLineView alloc] initWithFrame:CGRectMake(NavMustAdd, 50.0f, SCREEN_Height - 50.0f - NavMustAdd - TabMustAdd, SCREEN_Width - 100.0f)];
        _fullKLineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    }
    return _fullKLineView;
}

- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        _backView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
        [_backView addGestureRecognizer:self.backTapGesture];
    }
    return _backView;
}

- (UITapGestureRecognizer *)backTapGesture {
    if (!_backTapGesture) {
        _backTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PL_ProvidencebackViewTapAction:)];
        _backTapGesture.delegate = self;
    }
    return _backTapGesture;
}

- (UILabel *)symbolLabel {
    if (!_symbolLabel) {
        _symbolLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 50.0f)];
        _symbolLabel.font = [UIFont boldSystemFontOfSize:17];
        _symbolLabel.text = @"--";
        _symbolLabel.textColor = [UIColor colorWithHexString:@"0x666666"];
    }
    return _symbolLabel;
}

- (UILabel *)currentPriceLabel {
    if (!_currentPriceLabel) {
        _currentPriceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 50.0f)];
        _currentPriceLabel.font = [UIFont PL_ProvidencesystemFontOfSize:15.0f];
        _currentPriceLabel.text = @"--";
    }
    return _currentPriceLabel;
}

- (UILabel *)hour_24_changeLabel {
    if (!_hour_24_changeLabel) {
        _hour_24_changeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100.0f, 50.0f)];
        _hour_24_changeLabel.font = [UIFont PL_ProvidencesystemFontOfSize:17.0];
    }
    return _hour_24_changeLabel;
}

- (UIButton *)quitBtn {
    if (!_quitBtn) {
        _quitBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50.0f, 50.0f)];
        [_quitBtn setImage:[UIImage imageNamed:@"trade_close_full"] forState:UIControlStateNormal];
        [_quitBtn addTarget:self action:@selector(PL_ProvidencequitBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _quitBtn;
}


@end
