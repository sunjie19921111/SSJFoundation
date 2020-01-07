//
//  PL_ProvidenceHomeInfoDetailsVC.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/17.
//  Copyright © 2019 GhostLord. All rights reserved.
//


#import "PL_ProvidenceHomeInfoDetailsVC.h"
#import "PL_ProvidenceHomeStockModel.h"
#import "PL_ProvidenceHomeStockParticularsView.h"
#import "PL_ProvidenceSimpleKLineVolView.h"
#import "PL_ProvidenceHomeOptionView.h"
#import "PL_ProvidenceHomeFormHorView.h"
#import "PL_ProvidenceMarketLogic.h"
#import "PL_ProvidenceHomeScreenLoadVC.h"
#import "PL_ProvidenceFavDBManager.h"
#import "PL_ProvidenceDealMoneyVC.h"
#import <YYWebImage/YYWebImage.h>
#import <YYImage/YYImage.h>

#import "PL_ProvidenceDealModel.h"
#import "PL_ProvidenceHomeDealView.h"
#import "PL_ProvidenceDealModel.h"

#import "PL_ProvidenceBaseButton.h"
#define kBuyBtnTag  (4673)
#define kSellBtnTag (6385)

@interface PL_ProvidenceHomeInfoDetailsVC ()<PL_ProvidenceMainSelectedViewProtocol,UIGestureRecognizerDelegate,UIScrollViewDelegate>

@property (strong, nonatomic) NSString *marketCode;


@property (strong, nonatomic) UIButton *bugBtn;
@property (strong, nonatomic) UIButton *sellBtn;
@property (assign, nonatomic) BOOL isCanTrade;
@property (strong, nonatomic) PL_ProvidenceHomeStockModel *marketListModel;
@property (strong, nonatomic) UIScrollView *contentView;
@property (strong, nonatomic) PL_ProvidenceHomeStockParticularsView *infoHeaderView;
@property (strong, nonatomic) PL_ProvidenceSimpleKLineVolView *simpleKLineView;
@property (strong, nonatomic) UIView *selectBackView;
@property (strong, nonatomic) PL_ProvidenceBaseButton *timeSelectedBtn;
@property (strong, nonatomic) PL_ProvidenceBaseButton *fullScreenBtn;
@property (strong, nonatomic) PL_ProvidenceHomeOptionView *timeSelectedView;
@property (strong, nonatomic) NSArray *timeTypes;
@property (strong, nonatomic) NSString *currentTimeinterval;
@property (strong, nonatomic) UIView *timeBackView;
@property (strong, nonatomic) UITapGestureRecognizer *timeBackViewTap;
@property (strong, nonatomic) PL_ProvidenceHomeFormHorView *orderBookView;
@property (strong, nonatomic) UILabel *orderLabel;
@property (strong, nonatomic) UIButton *navRightBtn;
@property (strong, nonatomic) YYAnimatedImageView *futureImg;



@end

@implementation PL_ProvidenceHomeInfoDetailsVC

- (instancetype)initWithMarketListModel:(PL_ProvidenceHomeStockModel * _Nonnull)marketListModel marketCode:(NSString *)marketCode {
    if (self = [super init]) {
        if (marketListModel) {
            self.marketListModel = marketListModel;
        }
        if (!isStrEmpty(marketCode)) {
            self.marketCode = marketCode;
        }else {
            self.marketCode = self.marketListModel.marketCode;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self configData];;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self PL_ProvidencereloadData];
    
    [self.timeSelectedBtn setTitle:self.currentTimeinterval forState:UIControlStateNormal];
}

- (void)loadData {
    
}

- (void)PL_ProvidencetimeSelectedViewBackTapAction:(UITapGestureRecognizer *)tap {
    
    [self.timeBackView setHidden:YES];
    
    [self.timeSelectedBtn setImage:[UIImage imageNamed:@"icon_future_arrow_down"] forState:UIControlStateNormal];
}


#pragma mark - 私有方法 --

- (void)configData {
    
    self.currentTimeinterval = [self.timeTypes firstObject];
    self.view.backgroundColor =  [UIColor whiteColor];
    self.currentTimeinterval = @"1日";
    self.navigationItem.title = [NSString stringWithFormat:@"%@(%@)",self.marketListModel.name,self.marketListModel.code];
    
    UIButton *rightBarButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBarButton setImage:[UIImage imageNamed:@"icon_home_fav"] forState:UIControlStateNormal];
    [rightBarButton addTarget:self action:@selector(PL_ProvidencefavAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBarButton];
    
    [self.futureImg yy_setImageWithURL:[NSURL URLWithString:self.marketListModel.minurl] placeholder:[UIImage imageNamed:@""]];

    [self PL_ProvidencecheckTrade];
}

- (void)setupUI {
    
//    PL_ProvidenceBaseButtonConfig *config = [PL_ProvidenceBaseButtonConfig buttonConfig];
//    config.styleType = JMButtonStyleTypeRight;
//    config.image = [UIImage imageNamed:@"icon_future_arrow_down"];
//    config.imageSize = CGSizeMake(SCALE_Length(7.0f), SCALE_Length(4.0f));
//    config.title = @"分时";
//    _timeSelectedBtn = [[PL_ProvidenceBaseButton alloc] initWithFrame:CGRectZero ButtonConfig:config];
//    [_timeSelectedBtn setBackgroundColor:[UIColor clearColor]];
//    [_timeSelectedBtn setTitleColor:[UIColor colorWithHexString:@"0x4299FF"] forState:UIControlStateNormal];
//    [_timeSelectedBtn addTarget:self action:@selector(PL_ProvidencetimeSelectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBackView addSubview:self.timeSelectedBtn];
    
//    PL_ProvidenceBaseButtonConfig *config1 = [PL_ProvidenceBaseButtonConfig buttonConfig];
//    config1.styleType = JMButtonStyleTypeRight;
//    config1.image = [UIImage imageNamed:@"trade_fullscreen"];
//    config1.title = @"全屏";
//    config.titleColor =[UIColor colorWithHexString:@"0xB4B4B4"];
//    _fullScreenBtn = [[PL_ProvidenceBaseButton alloc] initWithFrame:CGRectZero ButtonConfig:config];
//    [_fullScreenBtn setBackgroundColor:[UIColor clearColor]];
//    [_fullScreenBtn addTarget:self action:@selector(PL_ProvidencefullScreenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.selectBackView  addSubview:self.fullScreenBtn];
    
//    _infoHeaderView = [[PL_ProvidenceHomeStockParticularsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCALE_Length(145.0f)) contractModel:self.marketListModel];
//    _infoHeaderView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    [self.contentView addSubview:self.infoHeaderView];
    
//    _selectBackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infoHeaderView.frame), SCREEN_Width, SCALE_Length(30.0f))];
//    _selectBackView.backgroundColor = [UIColor colorWithHexString:@"0xF8F8F8"];
    [self.contentView addSubview:self.selectBackView];
    
//    _orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.simpleKLineView.frame) - Nav_topH, SCREEN_Width, SCALE_Length(30.0f))];
//    _orderLabel.text = @"委托订单";
//    _orderLabel.textAlignment = NSTextAlignmentCenter;
//    _orderLabel.font = [UIFont fontWithName:fFont size:15.0f];
//    _orderLabel.textColor = [UIColor colorWithHexString:@"0xB4B4B4"];
//    _orderLabel.backgroundColor = [UIColor colorWithHexString:@"0xF8F8F8"];
//    [self.contentView addSubview:self.orderLabel];
    [self.contentView addSubview:self.orderBookView];
    
//    _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Nav_topH, SCREEN_Width, SCREEN_Height - Nav_topH - TabMustAdd - SCALE_Length(60.0f))];
//    _contentView.contentSize = CGSizeMake(SCREEN_Width, SCREEN_Height - Nav_topH);
//    _contentView.showsVerticalScrollIndicator = NO;
//    _contentView.showsHorizontalScrollIndicator = NO;
//    if (@available(iOS 11.0, *)) {
//        _contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    } else {
//        self.automaticallyAdjustsScrollViewInsets = YES;
//    }
//    _contentView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
//    _contentView.delegate = self;
    [self.view addSubview:self.contentView];
    
//    [self.view addSubview:self.futureImg];
    if (self.isMarket) {
        [self.view addSubview:self.futureImg];
    } else {
         [self.view addSubview:self.simpleKLineView];
    }
//
//    _bugBtn = [[UIButton alloc] init];
//    [_bugBtn setTitle:@" 模拟买入 " forState:UIControlStateNormal];
//    [_bugBtn addTarget:self action:@selector(PL_ProvidencetradAction:) forControlEvents:UIControlEventTouchUpInside];
//    _bugBtn.backgroundColor = [UIColor colorWithHexString:@"0x50B383"];
//    _bugBtn.layer.cornerRadius = SCALE_Length(5.0f);
//    _bugBtn.layer.masksToBounds = YES;
//    _bugBtn.tag = kBuyBtnTag;
    [self.view addSubview:self.bugBtn];
    
//    _sellBtn = [[UIButton alloc] init];
//    [_sellBtn setTitle:@" 模拟卖出 " forState:UIControlStateNormal];
//    [_sellBtn addTarget:self action:@selector(PL_ProvidencetradAction:) forControlEvents:UIControlEventTouchUpInside];
//    _sellBtn.backgroundColor = [UIColor colorWithHexString:@"0xE04A59"];
//    _sellBtn.layer.cornerRadius = SCALE_Length(5.0f);
//    _sellBtn.layer.masksToBounds = YES;
//    _sellBtn.tag = kSellBtnTag;
    [self.view addSubview:self.sellBtn];
    [self setupLayout];
}

- (void)setupLayout {
    [self.timeSelectedBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectBackView.mas_left).offset(SCALE_Length(15.0f));
        make.centerY.equalTo(self.selectBackView.mas_centerY);
    }];
    
    [self.fullScreenBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.selectBackView.mas_right).offset(- SCALE_Length(15.0f));
        make.centerY.equalTo(self.selectBackView.mas_centerY);
    }];
    
    if (self.isCanTrade) {
        
        self.contentView.frame = CGRectMake(0, Nav_topH, SCREEN_Width, SCREEN_Height - Nav_topH - TabMustAdd - SCALE_Length(60.0f));
        
        self.bugBtn.hidden = NO;
        self.sellBtn.hidden = NO;
        
        [self.bugBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(SCALE_Length(20.0f));
            make.bottom.equalTo(self.view.mas_bottom).offset(- SCALE_Length(10) - TabMustAdd);
            make.width.mas_equalTo((SCREEN_Width - SCALE_Length(80.0f)) / 2.0f);
            make.height.mas_equalTo(SCALE_Length(40.0f));
        }];
        
        [self.sellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bugBtn.mas_right).offset(SCALE_Length(40.0f));
            make.bottom.equalTo(self.view.mas_bottom).offset(- SCALE_Length(10) - TabMustAdd);
            make.width.mas_equalTo((SCREEN_Width - SCALE_Length(80.0f)) / 2.0f);
            make.height.mas_equalTo(SCALE_Length(40.0f));
        }];
    }else {
        
         self.contentView.frame = CGRectMake(0, Nav_topH, SCREEN_Width, SCREEN_Height - Nav_topH - TabMustAdd - SCALE_Length(60.0f));
        
        self.bugBtn.hidden = NO;
        self.sellBtn.hidden = NO;
        
        [self.bugBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(SCALE_Length(20.0f));
            make.bottom.equalTo(self.view.mas_bottom).offset(- SCALE_Length(10) - TabMustAdd);
            make.width.mas_equalTo((SCREEN_Width - SCALE_Length(80.0f)) / 2.0f);
            make.height.mas_equalTo(SCALE_Length(40.0f));
        }];
        
        [self.sellBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bugBtn.mas_right).offset(SCALE_Length(40.0f));
            make.bottom.equalTo(self.view.mas_bottom).offset(- SCALE_Length(10) - TabMustAdd);
            make.width.mas_equalTo((SCREEN_Width - SCALE_Length(80.0f)) / 2.0f);
            make.height.mas_equalTo(SCALE_Length(40.0f));
        }];
//        self.bugBtn.hidden = YES;
//        self.sellBtn.hidden = YES;
    }
}

- (void)PL_ProvidenceclickRightBarButton {
    
}

/*  更新数据 */
- (void)PL_ProvidencereloadData {
    
    [self PL_ProvidenceupdateOrderBookData];
    
    [self PL_ProvidenceupdateKlineData];
    
    [self PL_ProvidenceupdateFavState];
}

- (void)PL_ProvidenceupdateOrderBookData {
    
    [self.orderBookView startAnimatingWithOffset:CGPointZero activityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    weakSelf(self)
    [PL_ProvidenceMarketLogic getMarketOrderBookDateWithMarket:self.marketCode symbol:self.marketListModel.symbol success:^(NSArray<PL_ProvidenceHomeOrderModel *> * _Nonnull buyList, NSArray<PL_ProvidenceHomeOrderModel *> * _Nonnull sellList) {
        
        [weakSelf.orderBookView updateTraderOrderBidListArray:buyList askListArray:sellList unitAmount:1.0];
        [weakSelf.orderBookView stopAnimating];
    } faild:^(NSError * _Nonnull error) {
        NSLog(@"error : %@",error);
        [weakSelf.orderBookView stopAnimating];
    }];
    
}

- (void)PL_ProvidenceupdateKlineData {
    
    NSString *market = self.marketCode;
    
    if ([self.marketCode isEqualToString:@"usa"]) {
        market = self.marketListModel.market;
    }
    
    [self.simpleKLineView startAnimatingWithOffset:CGPointZero activityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
    
    weakSelf(self);
    [PL_ProvidenceMarketLogic getKlineDateWithMarketCode:self.marketCode market:market symbol:self.marketListModel.code timeType:[PL_ProvidenceMarketLogic getTimeInervalWithTimeType:self.currentTimeinterval] success:^(NSArray<PL_ProvidenceKLineModel *> * _Nonnull klineArray) {
        
        [weakSelf.simpleKLineView stopAnimating];
        
        [weakSelf.simpleKLineView.dataCenter cleanData];
        
        [weakSelf.simpleKLineView.dataCenter reloadDataWithArray:klineArray withDecimalsLimit:2];
        if ([weakSelf.currentTimeinterval isEqualToString:@"分时"]) {
            [weakSelf.simpleKLineView switchKLineMainViewToType:KLineMainViewTypeTimeLineWithMA];
        }else {
            [weakSelf.simpleKLineView switchKLineMainViewToType:KLineMainViewTypeKLineWithMA];
        }
        
    } faild:^(NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        
        [weakSelf.simpleKLineView stopAnimating];
    }];
}

- (void)PL_ProvidenceupdateFavState {
    
    if ([[PL_ProvidenceFavDBManager manager] isFavWithSymbol:self.marketListModel.symbol]) {

        [self.navRightBtn setSelected:YES];
    }else {
        [self.navRightBtn setSelected:NO];
    }
}

- (void)PL_ProvidencefavAction:(UIButton *)favBtn {
    
    [SVProgressHUD show];
     weakSelf(self)
    if (self.navRightBtn.isSelected) {
        
        [[PL_ProvidenceFavDBManager manager] removeFavWithListModel:self.marketListModel callBack:^(BOOL suc, PL_ProvidenceHomeStockModel *listModel) {
            [MBProgressHUD showSuccess:@"删除自选成功"];

            [weakSelf PL_ProvidenceupdateFavState];
        }];
    }else {
        [[PL_ProvidenceFavDBManager manager] addFavWithMarketListModel:self.marketListModel callBack:^(BOOL suc, PL_ProvidenceHomeStockModel *listModel) {
            [MBProgressHUD showSuccess:@"添加自选成功"];
            [weakSelf PL_ProvidenceupdateFavState];

            [SVProgressHUD dismiss];
        }];
    }
}

- (void)PL_ProvidencetradAction:(UIButton *)btn {

    // 交易
    weakSelf(self)
    PL_ProvidenceHomeDealView *tradeView = [[PL_ProvidenceHomeDealView alloc] initWithFrame:[UIScreen mainScreen].bounds symbol:[self.marketListModel convertTo51ApiSymbol] priceNow:self.marketListModel.trade name:self.marketListModel.name];
    if (btn.tag == 4673) {
        CGFloat number = [k_MoneyManagerModel.availableIntegral integerValue] / [self.marketListModel.trade floatValue];
        [tradeView updateAvailableHands:number];
    } else {
        __block NSString *hans= nil;

        
        NSArray *favList = [[PL_ProvidenceDataManager manager] getAllModels];
        [favList enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.symbol isEqualToString:self.marketListModel.symbol]) {
                hans = obj.postion;
            }
        }];
        
        [tradeView updateAvailableHands:[hans integerValue]];
    }

    tradeView.tradeBlock = ^(PL_ProvidenceHomeDealView * _Nonnull tradeView, PL_ProvidenceTradeType tradeType, NSString * _Nonnull price, NSString * _Nonnull hands) {
        PL_ProvidenceHomeStockTradeModel *tradeModel = nil;
        if (tradeType == PL_ProvidenceTradeTypeBuy) {
            
            tradeModel = [PL_ProvidenceHomeStockTradeModel tradeModelWithHands:[hands integerValue] price:[weakSelf.marketListModel.trade floatValue] isSell:NO];
            CGFloat number = [k_MoneyManagerModel.availableIntegral integerValue] / [price floatValue];
           
            [tradeView updateAvailableHands:    [k_MoneyManagerModel.availableIntegral integerValue] / [price floatValue]];
            if (number <= 0) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"没有充足的积分进行购买，您是否要充值积分呢？" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert PL_ProvidenceshowAlertWithCompletionHandler:^(NSInteger alertIndex) {
                    switch (alertIndex) {
                        case 1:
                            [self.navigationController pushViewController:[PL_ProvidenceDealMoneyVC new] animated:YES];
                            break;
                        default:
                            break;
                    }
                }];
                [UIView animateWithDuration:0.2 animations:^{
                    tradeView.backgroundColor = [UIColor clearColor];
                } completion:^(BOOL finished) {
                    [tradeView setHidden:YES];
                    [tradeView removeFromSuperview];
                }];
                return ;
            }
            
            
            if (tradeModel.hands < 100) {
                [SVProgressHUD showErrorWithStatus:@"输入数量不可低于100"];
                return;
            }
      
            
            if (number < tradeModel.hands) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"最多可买%f股",number]];
                return;
            }
            
        
            self.marketListModel.price = price;
            self.marketListModel.hands =  hands;
            [[PL_ProvidenceFavDBManager manager] addPositionWithMarketListModel:self.marketListModel callBack:^(BOOL suc, PL_ProvidenceHomeStockModel * _Nonnull listModel) {
                
            }];
            
            PL_ProvidenceDealModel *model = [[PL_ProvidenceDealModel alloc] initWithconvertListModel:self.marketListModel];
    
            [[PL_ProvidenceDataManager manager] insertModel:model];
               
                model.buySell = @"buy";
                model.dateString = [NSString localStringFromDate:[NSDate date]];
            
            [[PL_ProvidenceDealDataManager manager] insertModel:model];
            
        }else if(tradeType == PL_ProvidenceTradeTypeSell) {
            // 暂时用最新价进行交易
            __block NSString *hans= nil;

           NSArray *favList = [[PL_ProvidenceDataManager manager] getAllModels];
            [favList enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if ([obj.symbol isEqualToString:self.marketListModel.symbol]) {
                    hans = obj.postion;
                }
            }];
            
            tradeModel = [PL_ProvidenceHomeStockTradeModel tradeModelWithHands:[hands integerValue] price:[weakSelf.marketListModel.trade floatValue] isSell:YES];
            
            if (hans <= 0) {
                 [SVProgressHUD showErrorWithStatus:@"没有充足的股票提供你售卖，请您先购买股票"];
                return;
            }
            
            if ([hans integerValue] < [hands integerValue]) {
                [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"您最多可卖出%@股，请您重新输入",hans]]; return;
            }
            self.marketListModel.hands =  [NSString stringWithFormat:@"%.2f",[hans doubleValue] - [hands doubleValue]];
            
            PL_ProvidenceDealModel *model = [[PL_ProvidenceDealModel alloc] initWithconvertListModel:self.marketListModel];
            [[PL_ProvidenceDataManager manager] updateMyCachePostion:model];
            
            model.buySell = @"sell";
            model.dateString = [NSString localStringFromDate:[NSDate date]];
            [[PL_ProvidenceDealDataManager manager] insertModel:model];
        }
        
        if (tradeModel) {
             [SVProgressHUD showErrorWithStatus:@"当前股票暂不支持模拟交易(暂时只支持上证和深证股票进行模拟交易)"];
        }
        
    

        [SVProgressHUD showSuccessWithStatus:@"交易成功！"];
        

        
        [UIView animateWithDuration:0.2 animations:^{
            tradeView.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [tradeView setHidden:YES];
            [tradeView removeFromSuperview];
        }];
    };
    
    tradeView.quitBlock = ^(PL_ProvidenceHomeDealView * _Nonnull tradeView) {
        
        [UIView animateWithDuration:0.2 animations:^{
            tradeView.backgroundColor = [UIColor clearColor];
        } completion:^(BOOL finished) {
            [tradeView setHidden:YES];
            [tradeView removeFromSuperview];
        }];
    };
    
    if (btn.tag == kBuyBtnTag) {
        [tradeView switchTradeViewWithType:PL_ProvidenceTradeTypeBuy];
    }else if(btn.tag == kSellBtnTag) {
        [tradeView switchTradeViewWithType:PL_ProvidenceTradeTypeSell];
    }
    
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (![keyWindow.subviews containsObject:tradeView]) {
        [keyWindow addSubview:tradeView];
    }
    
    [tradeView showTradeView];
    [tradeView setHidden:NO];
    [UIView animateWithDuration:0.2 animations:^{
        tradeView.backgroundColor = [[UIColor colorWithHexString:@"0x000000"] colorWithAlphaComponent:0.4];
    }];
}

- (void)PL_ProvidencecheckTrade {
    self.isCanTrade = YES;
    if (([self.marketCode isEqualToString:@"sh"] || [self.marketCode isEqualToString:@"sz"]) && !self.marketListModel.isIndex) {
        self.isCanTrade = YES;
    }
    
    if (([self.marketCode isEqualToString:@"dl"] || [self.marketCode isEqualToString:@"zz"]|| [self.marketCode isEqualToString:@"sh"])) {
        self.isCanTrade = YES;
    }
}

- (void)PL_ProvidencetimeSelectedBtnAction:(PL_ProvidenceBaseButton *)btn {
    
    if (![self.view.subviews containsObject:self.timeBackView]) {
        [self.view addSubview:self.timeBackView];
    }
    [self.timeBackView setHidden:NO];
    self.timeSelectedView.top = self.simpleKLineView.top;
    self.futureImg.top = self.simpleKLineView.top;
    [self.timeSelectedBtn setImage:[UIImage imageNamed:@"icon_future_arrow_up"] forState:UIControlStateNormal];
    
    // 设置当前展示的时间类型
    NSInteger index = [self.timeTypes indexOfObject:self.currentTimeinterval];
    [self.timeSelectedView setItemSelectedState:YES atIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (void)PL_ProvidencefullScreenBtnAction:(PL_ProvidenceBaseButton *)btn {
    
    PL_ProvidenceHomeScreenLoadVC *fullVC = [[PL_ProvidenceHomeScreenLoadVC alloc] initWithModel:self.marketListModel marketCode:self.marketCode];
    [self.navigationController pushViewController:fullVC animated:YES];
}

#pragma mark - 代理方法 --


/**
 时间周期选中的选项
 
 @param selectedView 选择视图
 @param title 选中选项的标题
 @param indexPath 选中选项的下标
 */
- (void)selectedView:(PL_ProvidenceHomeOptionView *)selectedView selectedItemTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"title:%@,index:%ld",title,indexPath.row);
    [self.timeSelectedBtn setTitle:title forState:UIControlStateNormal];
    [self.timeSelectedBtn setImage:[UIImage imageNamed:@"icon_future_arrow_down"] forState:UIControlStateNormal];
    [self.timeBackView setHidden:YES];
    
    //  选中其他周期
    self.currentTimeinterval = title;
    
    [self PL_ProvidenceupdateKlineData];
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (gestureRecognizer == self.timeBackViewTap) {
        CGPoint touchPoint = [touch locationInView:self.timeBackView];
        if (CGRectContainsPoint(self.timeSelectedView.frame, touchPoint)) {
            return NO;
        }else {
            return YES;
        }
    }
    return YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView == self.contentView) {
        self.simpleKLineView.frame = CGRectMake(0, CGRectGetMaxY(self.selectBackView.frame) - scrollView.contentOffset.y + Nav_topH, SCREEN_Width, SCALE_Length(240.0f));
        self.futureImg.frame = CGRectMake(0, CGRectGetMaxY(self.selectBackView.frame) - scrollView.contentOffset.y + Nav_topH, SCREEN_Width, SCALE_Length(240.0f));
    }
}

- (PL_ProvidenceHomeStockParticularsView *)infoHeaderView {
    if (!_infoHeaderView) {
        _infoHeaderView = [[PL_ProvidenceHomeStockParticularsView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCALE_Length(145.0f)) contractModel:self.marketListModel];
        _infoHeaderView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    }
    return _infoHeaderView;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, Nav_topH, SCREEN_Width, SCREEN_Height - Nav_topH - TabMustAdd - SCALE_Length(60.0f))];
        _contentView.contentSize = CGSizeMake(SCREEN_Width, SCREEN_Height - Nav_topH);
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.showsHorizontalScrollIndicator = NO;
        if (@available(iOS 11.0, *)) {
            _contentView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            self.automaticallyAdjustsScrollViewInsets = YES;
        }
        _contentView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
        _contentView.delegate = self;
    }
    return _contentView;
}


- (PL_ProvidenceBaseButton *)timeSelectedBtn {
    if(!_timeSelectedBtn) {
        PL_ProvidenceBaseButtonConfig *config = [PL_ProvidenceBaseButtonConfig buttonConfig];
        config.styleType = JMButtonStyleTypeRight;
        config.image = [UIImage imageNamed:@"icon_future_arrow_down"];
        config.imageSize = CGSizeMake(SCALE_Length(7.0f), SCALE_Length(4.0f));
        config.title = @"分时";
        _timeSelectedBtn = [[PL_ProvidenceBaseButton alloc] initWithFrame:CGRectZero ButtonConfig:config];
        [_timeSelectedBtn setBackgroundColor:[UIColor clearColor]];
        [_timeSelectedBtn setTitleColor:[UIColor colorWithHexString:@"0x4299FF"] forState:UIControlStateNormal];
        [_timeSelectedBtn addTarget:self action:@selector(PL_ProvidencetimeSelectedBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _timeSelectedBtn;
}

- (PL_ProvidenceBaseButton *)fullScreenBtn {
    if (!_fullScreenBtn) {
        PL_ProvidenceBaseButtonConfig *config = [PL_ProvidenceBaseButtonConfig buttonConfig];
        config.styleType = JMButtonStyleTypeRight;
        config.image = [UIImage imageNamed:@"trade_fullscreen"];
        config.title = @"全屏";
        config.titleColor =[UIColor colorWithHexString:@"0xB4B4B4"];
        _fullScreenBtn = [[PL_ProvidenceBaseButton alloc] initWithFrame:CGRectZero ButtonConfig:config];
        [_fullScreenBtn setBackgroundColor:[UIColor clearColor]];
        [_fullScreenBtn addTarget:self action:@selector(PL_ProvidencefullScreenBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fullScreenBtn;
}

- (UIView *)selectBackView {
    if (!_selectBackView) {
        _selectBackView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.infoHeaderView.frame), SCREEN_Width, SCALE_Length(30.0f))];
        _selectBackView.backgroundColor = [UIColor colorWithHexString:@"0xF8F8F8"];

    }
    return _selectBackView;
}

- (PL_ProvidenceSimpleKLineVolView *)simpleKLineView {
    if(!_simpleKLineView){
        _simpleKLineView = [[PL_ProvidenceSimpleKLineVolView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectBackView.frame) + Nav_topH, SCREEN_Width, SCALE_Length(240.0f))];
        [_simpleKLineView switchKLineMainViewToType:KLineMainViewTypeTimeLineWithMA];
        _simpleKLineView.dataCenter.decimalsLimit = 2;
        _simpleKLineView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
    }
    return _simpleKLineView;
}

- (UIImageView *)futureImg {
    if (!_futureImg) {
        _futureImg = [[YYAnimatedImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.selectBackView.frame) + Nav_topH, SCREEN_Width, SCALE_Length(240.0f))];
        _futureImg.backgroundColor = [UIColor whiteColor];
    }
    return _futureImg;
}


- (NSArray *)timeTypes {
    if (!_timeTypes) {
        _timeTypes = @[@"分时",@"1分", @"5分", @"15分", @"30分", @"1时",@"1日",@"1周",@"1月"];
    }
    return _timeTypes;
}

- (PL_ProvidenceHomeOptionView *)timeSelectedView {
    if (!_timeSelectedView) {
        NSMutableArray *titles = @[].mutableCopy;
        for (NSString *timeType in self.timeTypes) {
            [titles addObject:timeType];
        }
        _timeSelectedView = [[PL_ProvidenceHomeOptionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCALE_Length(130.0f)) itemsTitles:titles];
        _timeSelectedView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
        _timeSelectedView.delegate = self;
        _timeSelectedView.layer.borderColor = [UIColor colorWithHexString:@"0xcccccc"].CGColor;
        _timeSelectedView.layer.borderWidth = 1.0f;
    }
    return _timeSelectedView;
}

- (UIView *)timeBackView {
    if (!_timeBackView) {
        _timeBackView = [[UIView alloc] initWithFrame:self.view.bounds];
        _timeBackView.backgroundColor = [UIColor clearColor];
        [_timeBackView addSubview:self.timeSelectedView];
        [_timeBackView addGestureRecognizer:self.timeBackViewTap];
    }
    return _timeBackView;
}

- (UITapGestureRecognizer *)timeBackViewTap {
    if (!_timeBackViewTap) {
        _timeBackViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(PL_ProvidencetimeSelectedViewBackTapAction:)];
        _timeBackViewTap.delegate = self;
    }
    return _timeBackViewTap;
}

- (UILabel *)orderLabel {

    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.simpleKLineView.frame) - Nav_topH, SCREEN_Width, SCALE_Length(30.0f))];
        _orderLabel.text = @"委托订单";
        _orderLabel.textAlignment = NSTextAlignmentCenter;
        _orderLabel.font = [UIFont fontWithName:fFont size:15.0f];
        _orderLabel.textColor = [UIColor colorWithHexString:@"0xB4B4B4"];
        _orderLabel.backgroundColor = [UIColor colorWithHexString:@"0xF8F8F8"];
    }
    return _orderLabel;
}

- (PL_ProvidenceHomeFormHorView *)orderBookView {
    if (!_orderBookView) {
        _orderBookView = [[PL_ProvidenceHomeFormHorView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.orderLabel.frame), SCREEN_Width, SCREEN_Height - Nav_topH - SCALE_Length(150 + 30 + 30) - CGRectGetHeight(self.simpleKLineView.frame) - TabMustAdd)];
        _orderBookView.gears = 5;
        _orderBookView.gearGap = SCALE_Length(2.0f);
        _orderBookView.backgroundColor = [UIColor clearColor];
        [_orderBookView switchDisplayDataType:OrderBookDisPlayDataTypeCount withExchangeRate:@"1"];
    }
    return _orderBookView;
}

- (UIButton *)navRightBtn {
    if (!_navRightBtn) {
        _navRightBtn = [[UIButton alloc] init];
        [_navRightBtn setImage:[UIImage imageNamed:@"icon_no_fav"] forState:UIControlStateNormal];
        [_navRightBtn setImage:[UIImage imageNamed:@"icon_fav"] forState:UIControlStateSelected];
        [_navRightBtn addTarget:self action:@selector(PL_ProvidencefavAction:) forControlEvents:UIControlEventTouchUpInside];
        [_navRightBtn sizeToFit];
    }
    return _navRightBtn;
}

- (UIButton *)bugBtn {
    if (!_bugBtn) {
        _bugBtn = [[UIButton alloc] init];
        [_bugBtn setTitle:@" 模拟买入 " forState:UIControlStateNormal];
        [_bugBtn addTarget:self action:@selector(PL_ProvidencetradAction:) forControlEvents:UIControlEventTouchUpInside];
        _bugBtn.backgroundColor = [UIColor colorWithHexString:@"0x50B383"];
        _bugBtn.layer.cornerRadius = SCALE_Length(5.0f);
        _bugBtn.layer.masksToBounds = YES;
        _bugBtn.tag = kBuyBtnTag;
    }
    return _bugBtn;
}

- (UIButton *)sellBtn {
    if (!_sellBtn) {
        _sellBtn = [[UIButton alloc] init];
        [_sellBtn setTitle:@" 模拟卖出 " forState:UIControlStateNormal];
        [_sellBtn addTarget:self action:@selector(PL_ProvidencetradAction:) forControlEvents:UIControlEventTouchUpInside];
        _sellBtn.backgroundColor = [UIColor colorWithHexString:@"0xE04A59"];
        _sellBtn.layer.cornerRadius = SCALE_Length(5.0f);
        _sellBtn.layer.masksToBounds = YES;
        _sellBtn.tag = kSellBtnTag;
    }
    return _sellBtn;
}

@end
