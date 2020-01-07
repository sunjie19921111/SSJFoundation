//
//  PL_ProvidenceDealController.m
//  ProvidenceFutures
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/12/3.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceDealController.h"
#import "PL_ProvidenceDealCell.h"
#import "PL_ProvidenceDealNameCell.h"
#import "PL_ProvidenceDealMenuCell.h"
#import "PL_ProvidenceDealTopView.h"
#import "PL_ProvidenceFavDBManager.h"

#import "PL_ProvidenceDealBuyController.h"
#import "PL_ProvidenceDealSellViewController.h"
#import "PL_ProvidenceDealVC.h"
#import "PL_ProvidenceDealHistoryController.h"
#import "PL_ProvidenceDealMoneyVC.h"

@interface PL_ProvidenceDealController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong)  NSMutableArray *dealImgs;
@property (nonatomic, strong)  NSMutableArray *dealTitles;
@property (nonatomic, strong)  NSMutableArray *dealVCS;
@property (nonatomic, strong)  NSMutableArray *topModels;

@end

@implementation PL_ProvidenceDealController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"交易";
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kStatustopH, ScreenWidth, SCREEN_Height-kStatustopH) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
  
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceDealNameCell" bundle:nil] forCellWithReuseIdentifier:@"nameCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceDealCell" bundle:nil] forCellWithReuseIdentifier:@"dealCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceDealMenuCell" bundle:nil] forCellWithReuseIdentifier:@"menuCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceDealTopView" bundle:nil] forCellWithReuseIdentifier:@"topCell"];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if (section == 1){
        return 5;
    } else if (section == 2) {
        return 1;
    }
    return self.dataSource.count;
//    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;
    if (indexPath.section == 0) {
        PL_ProvidenceDealTopView *topCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        [topCell refresh];
        cell = topCell;
    } else if (indexPath.section == 1 ) {
        PL_ProvidenceDealMenuCell *menuCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuCell" forIndexPath:indexPath];
        menuCell.menuImg.image = [UIImage imageNamed:self.dealImgs[indexPath.row]];
        menuCell.menuTitle.text = self.dealTitles[indexPath.row];
        cell = menuCell;
    } else if (indexPath.section == 2) {
        PL_ProvidenceDealNameCell *nameCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nameCell" forIndexPath:indexPath];
        cell = nameCell;
    } else {
        PL_ProvidenceDealCell *dealCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
        dealCell.model = self.dataSource[indexPath.row];
        cell = dealCell;
    }

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *vcs = @[@"PL_ProvidenceDealBuyController",@"PL_ProvidenceDealSellViewController",@"PL_ProvidenceDealVC",@"PL_ProvidenceDealHistoryController",@"PL_ProvidenceDealMoneyVC"];
    if (indexPath.section == 1) {
        [self.navigationController pushViewController:[NSClassFromString(vcs[indexPath.row]) new] animated:YES];
    }
}

- (void)loadData {
    self.dataSource = [[PL_ProvidenceDataManager manager] getAllModels];
    [self.collectionView reloadData];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenWidth,150);
    }
    if (indexPath.section == 1) {
        return CGSizeMake(ScreenWidth/5, 90);
//        return CGSizeMake(ScreenWidth/4, ScreenWidth/4);
    } else if (indexPath.section == 2) {
        return CGSizeMake(ScreenWidth,64);
    } else {
        return CGSizeMake(ScreenWidth,110);
    }
}

- (NSMutableArray *)dealImgs {
    if (!_dealImgs) {
        _dealImgs = [NSMutableArray arrayWithArray:@[@"icon_deal_buy",@"icon_deal_sell",@"icon_deal_deal",@"icon_deal_dy",@"icon_deal_jifen"]];
    }
    return _dealImgs;
}

- (NSMutableArray *)dealTitles {
    if (!_dealTitles) {
        _dealTitles = [NSMutableArray arrayWithArray:@[@"买入",@"卖出",@"持仓",@"历史交易",@"申请积分",]];
    }
    return _dealTitles;
}

@end
