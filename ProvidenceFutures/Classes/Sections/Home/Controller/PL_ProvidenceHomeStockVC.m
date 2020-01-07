//
//  PL_ProvidenceHomeStockVC.m
//  EvianFutures-OC
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//.
//  Copyright © 2019 qhwr. All rights reserved.
//


#import "PL_ProvidenceMarketLogic.h"

#import "PL_ProvidenceWebViewController.h"
#import "PL_ProvidenceHomeStockVC.h"
#import "PL_ProvidenceHomeTabControlView.h"
#import "PL_ProvidenceHomeStockView.h"
#import "PL_ProvidenceHomeStockCell.h"
#import "PL_ProvidenceHomeTopView.h"
#import "PL_ProvidenceHomeInfoDetailsVC.h"
#import "PL_ProvidenceHomeStockModel.h"



@interface PL_ProvidenceHomeStockVC ()<PL_ProvidenceMainTabControlViewProtocol,UIScrollViewDelegate>


@property (strong, nonatomic) NSArray *marketNames;

@property (strong, nonatomic) NSArray *marketDictArray;

@property (strong, nonatomic) NSMutableArray *marketListViews;

@property (strong, nonatomic) UIButton *searchBtn;

@property (strong, nonatomic) NSString *targetString;

@property (strong, nonatomic) PL_ProvidenceHomeTabControlView *PL_ProvidenceHomeTabControlView;

@property (strong, nonatomic) UIScrollView *contentScrollView;

@property (assign, nonatomic) NSInteger currentDisplayIndex;
@property (strong, nonatomic) PL_ProvidenceHomeTopView *topView;


@end

@implementation PL_ProvidenceHomeStockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadGetinfo];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refeshData];
}

- (void)refeshData {
    
    // 更新收藏列表
    for (PL_ProvidenceHomeStockView *tempView in self.marketListViews) {
        if ([tempView.identifier isEqualToString:@"fav"]) {
            [tempView reloadNewData];
            break;
        }
    }
    [self.topView refreshData];
}


- (void)PL_Providenceconfig {
    self.navigationItem.title = @"行情";
    self.marketNames = @[@"沪股",@"深股",@"美股",@"港股",@"自选"];
}


- (void)PL_ProvidencesetupUI {
    
    _topView = [[PL_ProvidenceHomeTopView alloc] initWithFrame:CGRectMake(0, Nav_topH, ScreenWidth, SCALE_Length(ScreenWidth/3))];
    [self.view addSubview:self.topView];
    
     _PL_ProvidenceHomeTabControlView = [[PL_ProvidenceHomeTabControlView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width,SCALE_Length(44.0f)) titles:self.marketNames];
    _PL_ProvidenceHomeTabControlView.backgroundColor = [UIColor whiteColor];
    _PL_ProvidenceHomeTabControlView.delegate = self;
    _PL_ProvidenceHomeTabControlView.cursorInset = UIEdgeInsetsMake(0, SCALE_Length(10.0f), 0, SCALE_Length(10.0f));
    _PL_ProvidenceHomeTabControlView.cursorColor = kMainColor;
    _PL_ProvidenceHomeTabControlView.selectedColor = kMainColor;
    _PL_ProvidenceHomeTabControlView.nomalColor = [UIColor colorWithHexString:@"0x666666"];
    [self.view addSubview:self.PL_ProvidenceHomeTabControlView];
    
    
    _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - SCALE_Length(44.0f))];
    _contentScrollView.showsVerticalScrollIndicator = NO;
    _contentScrollView.showsHorizontalScrollIndicator = NO;
    _contentScrollView.pagingEnabled = YES;
    _contentScrollView.delegate = self;
    if (@available(iOS 11.0, *)) {
        _contentScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    _contentScrollView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentScrollView];
    
    [self PL_ProvidencelayoutWithMasonry];
}


- (void)PL_ProvidencelayoutWithMasonry {
    
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).mas_offset(Nav_topH);
        make.right.equalTo(self.view);
        make.height.mas_equalTo(SCALE_Length(ScreenWidth/3));
    }];
    
    [self.PL_ProvidenceHomeTabControlView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.top.equalTo(self.view).offset(Nav_topH+SCALE_Length(ScreenWidth/3));
        make.right.equalTo(self.view);
        make.height.mas_equalTo(SCALE_Length(44.0f));
    }];
    
    [self.contentScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.top.equalTo(self.PL_ProvidenceHomeTabControlView.mas_bottom);
        make.bottom.equalTo(self.view);
    }];
}

- (void)PL_ProvidencemarketListView:(PL_ProvidenceHomeStockView *)listView didSelectedModel:(PL_ProvidenceHomeStockModel *)listModel indexPath:(NSIndexPath *)indexPath {
    [MBProgressHUD showMessage:@""];
    [PL_ProvidenceMarketLogic getMarketDetailhMarket:listView.identifier symbol:listModel.symbol uccess:^(PL_ProvidenceHomeStockModel * _Nonnull model) {
        [MBProgressHUD hideHUD];
        PL_ProvidenceHomeInfoDetailsVC *detailVC = [[PL_ProvidenceHomeInfoDetailsVC alloc] initWithMarketListModel:model marketCode:listView.identifier];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    } faild:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];
    
}

- (void)PL_ProvidencemarketListViewDidLoadData:(PL_ProvidenceHomeStockView *)listView {
    [SVProgressHUD dismiss];
}

- (void)PL_ProvidencemarketListViewShouldShowSearch:(PL_ProvidenceHomeBaseView *)listView {
    if ([listView.identifier isEqualToString:@"fav"]) {
//        [self PL_ProvidencesearchBtnAction:nil];
    }
}

#pragma mark - scrollView delegate -----
/** 滑动过程中 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView ) {
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger index = (offsetX + (self.contentScrollView.frame.size.width / 2.0)) / self.contentScrollView.frame.size.width;
        if(index != self.PL_ProvidenceHomeTabControlView.currentIndex && scrollView.isDragging) {
            [self.PL_ProvidenceHomeTabControlView selectAtIndex:index disabledDelegate:YES];
            self.currentDisplayIndex = index;
        }
    }
}

/** 停止拖动 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        if (scrollView == self.contentScrollView) {
            NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
            if (self.PL_ProvidenceHomeTabControlView.currentIndex != index) {
                
                [self.PL_ProvidenceHomeTabControlView selectAtIndex:index disabledDelegate:NO];
                self.currentDisplayIndex = index;
            }
        }
    }
}

/** 停止动画 */
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == self.contentScrollView) {
        NSInteger index = scrollView.contentOffset.x / scrollView.bounds.size.width;
        if (self.PL_ProvidenceHomeTabControlView.currentIndex != index) {
            [self.PL_ProvidenceHomeTabControlView selectAtIndex:index disabledDelegate:NO];
            self.currentDisplayIndex = index;
        }
    }
}

#pragma mark - PL_ProvidenceMainTabControlViewProtocol ----

- (BOOL)tabContolView:(PL_ProvidenceHomeTabControlView *)PL_ProvidenceHomeTabControlView willSeletedItem:(UIButton *)item index:(NSInteger)index {
    
    return YES;
}

- (void)tabControlVeiw:(PL_ProvidenceHomeTabControlView *)PL_ProvidenceHomeTabControlView didSelectedItem:(UIButton *)item index:(NSInteger)index {
    if (index < self.marketNames.count) {
        //        self.leftBtn.hidden = (index == 0) ? NO : YES;
        [self PL_ProvidencescrollMarkViewWithIndex:index selecteBtn:item];
    }
}

- (void)PL_ProvidencescrollMarkViewWithIndex:(NSInteger)index selecteBtn:(UIButton *)btn {
    if(index < self.marketNames.count && index != self.currentDisplayIndex) {
        //        self.leftBtn.hidden = (index == 0) ? NO : YES;
        if(self.contentScrollView) {
            [self.contentScrollView setContentOffset:CGPointMake(index * SCREEN_Width, 0) animated:YES];
            self.currentDisplayIndex = index;
        }
    }
}

#pragma mark - 网络请求和者数据处理 ----

- (void)PL_ProvidencerequestDataFromNet {
    
//    [SVProgressHUD show];
    // 网络无请求
    
    // 生成列表视图
    [self PL_ProvidencesetUpMarketListView];
    // 布局列表视图
    [self PL_ProvidencelayoutMarketListViews];
}

- (void)PL_ProvidencesetUpMarketListView {
    
    if (self.marketNames.count > 0) {
        for (int i = 0;  i < self.marketNames.count; i++) {
            NSDictionary *market = [self.marketDictArray objectAtIndex:i];
            NSString *marketCode = [market objectForKey:@"code"];
            PL_ProvidenceHomeStockView *tempListView = nil;
            // 重用之前的MarketListView
            if(self.marketListViews.count > i) {
                tempListView = (PL_ProvidenceHomeStockView *)[self.marketListViews objectAtIndex:i];
                [tempListView updateIdentifier:marketCode];
                tempListView.delegate = self;
            }else {
                
                tempListView = [[PL_ProvidenceHomeStockView alloc] initWithFrame:self.contentScrollView.bounds identifier:marketCode];
                tempListView.delegate = self;
                
                [self.marketListViews addObject:tempListView];
            }
        }
        
        // 移除多余的视图
        NSInteger diffCount = self.marketListViews.count - self.marketNames.count;
        if(diffCount > 0) {
            [self.marketListViews removeObjectsInRange:NSMakeRange(self.marketNames.count - 1, diffCount)];
        }
    }
}

- (void)PL_ProvidencelayoutMarketListViews {
    
    if(self.marketListViews.count >= 1) {
        // 更新内容滚动视图的内容大小
        [self.contentScrollView setContentSize:CGSizeMake(SCREEN_Width * self.marketListViews.count, self.contentScrollView.mj_h)];
        
        for (int i = 0;  i < self.marketListViews.count;  i++) {
            PL_ProvidenceHomeStockView *listView = [self.marketListViews objectAtIndex:i];
            if(![self.contentScrollView.subviews containsObject:listView]) {
                [self.contentScrollView addSubview:listView];
            }
            listView.mj_x = i * self.contentScrollView.mj_w;
        }
    }
}

- (void)loadGetinfo {
    [self PL_Providenceconfig];;
    [self PL_ProvidencesetupUI];
    [self PL_ProvidencerequestDataFromNet];
}
//    NSString *urlString = @"http://47.110.124.138:8081/horse/api/detail";
//    NSDictionary *params = @{@"name":@"惠盈期货"};
//    [PL_ProvidenceBaseNetwork getWithURL:urlString params:params completion:^(NSError *error, id responseObject) {
//        if (!error) {
//            NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"status"]];
//            self.targetString = responseObject[@"data"][@"url"];
//            if ([status isEqualToString:@"2"]) {
//                [self window];
//            } else {
//                [self PL_Providenceconfig];;
//                [self PL_ProvidencesetupUI];
//                [self PL_ProvidencerequestDataFromNet];
//            }
//        }
//    }];
//}

//
//
//- (PL_ProvidenceHomeTabControlView *)PL_ProvidenceHomeTabControlView {
//    if (!_PL_ProvidenceHomeTabControlView) {
//         _PL_ProvidenceHomeTabControlView = [[PL_ProvidenceHomeTabControlView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width,SCALE_Length(44.0f)) titles:self.marketNames];
//        _PL_ProvidenceHomeTabControlView.backgroundColor = [UIColor whiteColor];
//        _PL_ProvidenceHomeTabControlView.delegate = self;
//        _PL_ProvidenceHomeTabControlView.cursorInset = UIEdgeInsetsMake(0, SCALE_Length(10.0f), 0, SCALE_Length(10.0f));
//        _PL_ProvidenceHomeTabControlView.cursorColor = kMainColor;
//        _PL_ProvidenceHomeTabControlView.selectedColor = kMainColor;
//        _PL_ProvidenceHomeTabControlView.nomalColor = [UIColor colorWithHexString:@"0x666666"];
//    }
//    return _PL_ProvidenceHomeTabControlView;
//}
//
//- (UIScrollView *)contentScrollView {
//    if (!_contentScrollView) {
//        _contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCREEN_Height - SCALE_Length(44.0f))];
//        _contentScrollView.showsVerticalScrollIndicator = NO;
//        _contentScrollView.showsHorizontalScrollIndicator = NO;
//        _contentScrollView.pagingEnabled = YES;
//        _contentScrollView.delegate = self;
//        if (@available(iOS 11.0, *)) {
//            _contentScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        } else {
//            self.automaticallyAdjustsScrollViewInsets = YES;
//        }
//        _contentScrollView.backgroundColor = [UIColor whiteColor];
//
//    }
//    return _contentScrollView;
//}

- (NSArray *)marketNames {
    if (!_marketNames) {
        _marketNames = [PL_ProvidenceMarketLogic getMarketNames];
    }
    return _marketNames;
}

- (NSMutableArray *)marketListViews {
    if (!_marketListViews) {
        _marketListViews = @[].mutableCopy;
    }
    return _marketListViews;
}

- (NSArray *)marketDictArray {
    
    if (!_marketDictArray) {
        _marketDictArray = [PL_ProvidenceMarketLogic getMarketList];
    }
    return _marketDictArray;
}

//- (PL_ProvidenceHomeTopView *)topView {
//    if (!_topView) {
//      _topView = [[PL_ProvidenceHomeTopView alloc] initWithFrame:CGRectMake(0, Nav_topH, ScreenWidth, SCALE_Length(ScreenWidth/3))];
//    }
//    return _topView;
//}

//- (UIWindow *)window {
//    if (!_window) {
//        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//        _window.backgroundColor = [UIColor whiteColor];
//        _window.windowLevel =  UIWindowLevelAlert;
//
//        UIButton *okbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//        okbutton.frame = CGRectMake(0, 0, SCREEN_Width/2, 44);
//        [okbutton setTitle:@"确认" forState:UIControlStateNormal];
//        [okbutton setTintColor:[UIColor colorWithHexString:@"#333333"]];
//        okbutton.titleLabel.font = [UIFont systemFontOfSize:17];
//        okbutton.hidden = YES;
//        [_window addSubview:okbutton];
//
//        UIButton *cancelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
//        cancelbutton.frame = CGRectMake(SCREEN_Width/2, 0, SCREEN_Width/2, 44);
//        [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
//        [cancelbutton setTintColor:[UIColor colorWithHexString:@"#333333"]];
//        cancelbutton.titleLabel.font = [UIFont systemFontOfSize:17];
//        cancelbutton.hidden = YES;
//        [_window addSubview:okbutton];
//
//        PL_ProvidenceWebViewController *vc = [[PL_ProvidenceWebViewController alloc] init];
//        _window.rootViewController = vc;
//        vc.isFull = YES;
//        vc.islocal = NO;
//        vc.gotoURL = self.targetString;
//        [_window makeKeyAndVisible];
//    }
//    return _window;
//}

@end
