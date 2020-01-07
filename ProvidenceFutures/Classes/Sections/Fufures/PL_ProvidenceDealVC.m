//
//  PL_ProvidenceDealVC.m
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
//2019/9/28.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceDealVC.h"
#import "PL_ProvidenceDealDyTopView.h"
#import "PL_ProvidenceHomeStockCell.h"
#import "PL_ProvidenceFavDBManager.h"
#import "PL_ProvidenceHomeStockOptionTopView.h"
#import "PL_ProvidenceDealDyCell.h"
#import "PL_ProvidenceMarketLogic.h"
#import "PL_ProvidenceDealModel.h"

static NSString const *marketListViewCell = @"PL_ProvidenceHomeStockCell";

@interface PL_ProvidenceDealVC ()<UITableViewDelegate,UITableViewDataSource>

/** 列表视图 */
@property (strong, nonatomic) UITableView *listView;
@property (strong, nonatomic) PL_ProvidenceDealDyTopView *topView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation PL_ProvidenceDealVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setupUI {
    _topView = [[PL_ProvidenceDealDyTopView alloc] initWithFrame:CGRectMake(0, Nav_topH, ScreenWidth, 160)];
    [self.view addSubview:_topView];
    
    [self.view addSubview:self.listView];
}

- (void)configData {
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    self.navigationItem.title = @"持仓";
    [self setupUI];
}

- (void)loadData {
    [_topView refreshData];

    [[PL_ProvidenceDataManager manager] update];
    self.dataSource = nil;
    NSArray *models = [[PL_ProvidenceDataManager manager] getAllModels];
    self.dataSource = models;
    if (self.dataSource.count > 0) {
        self.empeyView.hidden = YES;
    } else {
        self.empeyView.hidden = NO;
    }
    self.collectionView.hidden = !self.empeyView.hidden;
    
    [self.listView reloadData];
}

#pragma mark - TableView delegate ------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PL_ProvidenceDealDyCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PL_ProvidenceDealModel *model = [self.dataSource objectAtIndex:indexPath.row];
    cell.model = model;

    return cell;
}

#pragma mark - 懒加载 ----

- (UITableView *)listView {
    if (!_listView) {
        _listView = [[UITableView alloc] initWithFrame:CGRectMake(0, Nav_topH + 160, ScreenWidth, ScreenHeight - Nav_topH - 160)];
        _listView.backgroundColor = [UIColor whiteColor];
        _listView.showsVerticalScrollIndicator = NO;
        _listView.showsHorizontalScrollIndicator = NO;
        _listView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listView.delegate = self;
        _listView.dataSource = self;
        [_listView registerNib:[UINib nibWithNibName:@"PL_ProvidenceDealDyCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _listView.backgroundColor = [UIColor whiteColor];
    }
    return _listView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    return lineView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return SCALE_Length(10.0f);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

@end
