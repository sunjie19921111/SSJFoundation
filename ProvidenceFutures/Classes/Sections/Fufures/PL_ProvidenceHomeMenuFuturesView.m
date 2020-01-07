//
//  PL_ProvidenceHomeMenuFuturesView.m
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
//2019/10/16.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceMarketLogic.h"
#import "PL_ProvidenceHomeMenuFuturesView.h"
#import "PL_ProvidenceHomeStockCell.h"
#import "PL_ProvidenceHomeStockOptionTopView.h"
#import "PL_ProvidenceFavDBManager.h"


@interface PL_ProvidenceHomeMenuFuturesView ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *listView;
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (assign, nonatomic) NSInteger page;
@property (strong, nonatomic) UIButton *refreshBtn;


@end

@implementation PL_ProvidenceHomeMenuFuturesView


static NSString *const MainMenuViewCell = @"MainMenuViewCell";

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[].mutableCopy;
    }
    return _dataSource;
}

- (UIButton *)refreshBtn {
    if (!_refreshBtn) {
        _refreshBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SCALE_Length(200), SCALE_Length(200))];
        _refreshBtn.titleLabel.font = [UIFont fontWithName:fFont size:14.0f];
        [_refreshBtn setTitleColor:[UIColor colorWithHexString:@"0xB4B4B4"] forState:UIControlStateNormal];
        [_refreshBtn setTitle:@"当前无数据，请点击重试" forState:UIControlStateNormal];
        [_refreshBtn addTarget:self  action:@selector(PL_ProvidencerefreshBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _refreshBtn;
}

#pragma mark - 懒加载 ----

//- (UITableView *)listView {
//    if (!_listView) {
//        _listView = [[UITableView alloc] initWithFrame:self.bounds];
//        _listView.backgroundColor = [UIColor clearColor];
//        _listView.showsVerticalScrollIndicator = NO;
//        _listView.showsHorizontalScrollIndicator = NO;
//        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _listView.delegate = self;
//        _listView.dataSource = self;
//        [_listView registerClass:[PL_ProvidenceHomeStockCell class] forCellReuseIdentifier:MainMenuViewCell];
//        _listView.backgroundColor = [UIColor whiteColor];
//    }
//    return _listView;
//}


- (instancetype)initWithFrame:(CGRect)frame identifier:(NSString *)identifier  {
    if (self = [super initWithFrame:frame identifier:identifier]) {
        
        [self PL_Providenceinitialize];;
        
        [self PL_ProvidenceconfigUI];
        
        [self PL_ProvidenceloadDataFromNet];
    }
    return self;
}


- (void)PL_Providenceinitialize {

    self.page = 1;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)PL_ProvidenceconfigUI {
    
    _listView = [[UITableView alloc] initWithFrame:self.bounds];
    _listView.backgroundColor = [UIColor clearColor];
    _listView.showsVerticalScrollIndicator = NO;
    _listView.showsHorizontalScrollIndicator = NO;
    _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _listView.delegate = self;
    _listView.dataSource = self;
    [_listView registerClass:[PL_ProvidenceHomeStockCell class] forCellReuseIdentifier:MainMenuViewCell];
    _listView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.listView];
    
    self.listView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [self reloadNewData];
    }];
    
    self.listView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        [self PL_ProvidenceloadDataFromNet];
    }];
    
    if (![self.identifier isEqualToString:@"fav"]) {
        self.listView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
            [self PL_ProvidenceloadDataFromNet];
        }];
    }
    
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

#pragma mark - 公共方法 --

- (void)loadNextPageData {
    self.page++;
    [self PL_ProvidenceloadDataFromNet];
}

- (void)reloadNewData {
    [super reloadNewData];
    
    self.page = 1;
    
    [self PL_ProvidenceloadDataFromNet];
}


- (void)updateIdentifier:(NSString *)identifier {
    
    [super updateIdentifier:identifier];
    [self reloadNewData];
    
    if ([self.identifier isEqualToString:@"fav"]) {
        self.listView.mj_footer = nil;
    }
}

#pragma mark - TableView delegate ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.dataSource.count <= 0) {
        tableView.mj_footer.mj_h = 0.0f;
    }else {
        tableView.mj_footer.mj_h = 44.0f;
    }
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PL_ProvidenceHomeStockCell *cell = [tableView dequeueReusableCellWithIdentifier:MainMenuViewCell forIndexPath:indexPath];
    
    PL_ProvidenceHomeStockModel *model = [self.dataSource objectAtIndex:indexPath.row];
    
    [cell updateWithDataModel:model indexPath:indexPath];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return SCALE_Length(60.0f);
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    return [[PL_ProvidenceHomeStockOptionTopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_Width, SCALE_Length(40.0f)) titles:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCALE_Length(40.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (_delegate && [_delegate respondsToSelector:@selector(PL_ProvidencemarketListView:didSelectedModel:indexPath:)]) {
        
        PL_ProvidenceHomeStockModel *model = [self.dataSource objectAtIndex:indexPath.row];
        
        [_delegate PL_ProvidencemarketListView:self didSelectedModel:model indexPath:indexPath];
    }
}

#pragma mark - 私有方法 --

- (void)PL_ProvidenceloadDataFromNet {
    
    if ([self.identifier isEqualToString:@"fav"]) {
        
        [self PL_ProvidenceloadDataFromLocal];
    }else {
        
        weakSelf(self);
        
        [PL_ProvidenceMarketLogic getFuturesListDateWithCode:self.identifier page:self.page success:^(NSArray<PL_ProvidenceHomeStockModel *> * _Nonnull list) {
            
            [weakSelf PL_ProvidenceprocessDataWithList:list];
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(PL_ProvidencemarketListViewDidLoadData:)]) {
                [weakSelf.delegate PL_ProvidencemarketListViewDidLoadData:weakSelf];
            }
            
        } faild:^(NSError * _Nonnull error) {
            //            [SVProgressHUD showErrorWithStatus:NetErrorTipString];
            [weakSelf.listView.mj_header endRefreshing];
            [weakSelf.listView.mj_footer endRefreshing];
            
            [weakSelf PL_ProvidencerefreshBtnState];
            
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(PL_ProvidencemarketListViewDidLoadData:)]) {
                [weakSelf.delegate PL_ProvidencemarketListViewDidLoadData:weakSelf];
            }
        }];
    }
    
}


- (void)PL_ProvidenceloadDataFromLocal {
    
    //    [SVProgressHUD show];
    weakSelf(self);
    [[PL_ProvidenceFavDBManager manager] getFavArrayWithCallback:^(NSArray * _Nonnull favList) {
        
        [SVProgressHUD dismiss];
        [weakSelf.dataSource removeAllObjects];
        
        [weakSelf PL_ProvidenceprocessDataWithList:favList];
        
        [weakSelf.listView.mj_header endRefreshing];
        [weakSelf.listView.mj_footer endRefreshing];
        
        
        if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(PL_ProvidencemarketListViewDidLoadData:)]) {
            [weakSelf.delegate PL_ProvidencemarketListViewDidLoadData:weakSelf];
        }
    }];
}


- (void)PL_ProvidenceprocessDataWithList:(NSArray *)list {
    [self.listView.mj_header endRefreshing];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    if (list && list.count > 0) {
        
        [self.dataSource addObjectsFromArray:list];
        
        self.page ++;
        
        [self.listView.mj_footer endRefreshing];
        
    }else {
        [self.listView.mj_footer endRefreshingWithNoMoreData];
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.listView reloadData];
        [self PL_ProvidencerefreshBtnState];
    });
}

- (void)PL_ProvidencerefreshBtnAction:(UIButton *)btn {
    if ([self.identifier isEqualToString:@"fav"]) {
        if (_delegate && [_delegate respondsToSelector:@selector(PL_ProvidencemarketListViewShouldShowSearch:)]) {
            [_delegate PL_ProvidencemarketListViewShouldShowSearch:self];
        }
    }else {
        [self.listView.mj_header beginRefreshing];
    }
}


/* 展示无数据刷新按钮 */
- (void)PL_ProvidencesetUpRefreshBtnIsShow:(BOOL)show {
    
    if (show) {
        
        if (![self.subviews containsObject:self.refreshBtn]) {
            [self addSubview:self.refreshBtn];
        }
        
        [self.refreshBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.mas_centerX);
            make.centerY.equalTo(self.mas_centerY);
        }];
    }else {
        if (_refreshBtn) {
            [self.refreshBtn removeFromSuperview];
            self.listView.mj_footer.mj_h = 0.0f;
        }
    }
}

- (void)PL_ProvidencerefreshBtnState {
    
    if (self.dataSource.count > 0) {
        [self PL_ProvidencesetUpRefreshBtnIsShow:NO];
    }else {
        [self PL_ProvidencesetUpRefreshBtnIsShow:YES];
    }
}


@end
