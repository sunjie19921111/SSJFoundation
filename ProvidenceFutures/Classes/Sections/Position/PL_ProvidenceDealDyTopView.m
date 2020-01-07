//
//  PL_ProvidenceDealTopView.m
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


#import "PL_ProvidenceFavDBManager.h"
#import "PL_ProvidenceHomeStockModel.h"
#import "PL_ProvidenceDealModel.h"
#import "PL_ProvidenceDealDyTopView.h"
#import "PL_ProvidenceDealTopCell.h"
#import "PL_ProvidenceDealMoneyVC.h"


@interface PL_ProvidenceDealDyTopView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation PL_ProvidenceDealDyTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self refreshData];
    }
    return self;
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PL_ProvidenceDealTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
    [cell refreshData:self.dataSource[indexPath.row]];
    [cell.moneyButton addTarget:self action:@selector(clickMoneyButton) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if ([self.delegate respondsToSelector:@selector(topViewClickdidSelectItemAtIndexPath:)]) {
//        [self.delegate topViewClickdidSelectItemAtIndexPath:indexPath];
//    }
}

- (void)clickMoneyButton {
    PL_ProvidenceDealMoneyVC *vc = [[PL_ProvidenceDealMoneyVC alloc] init];
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)refreshData {
  
    /*
     self.mainTitleLabel.text = @"持仓盈亏";
     NSString *postion = [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] - [model.avgPrice doubleValue]) * [model.postion doubleValue]];
     NSString *postionRate = [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] *  [model.postion doubleValue]) / ([model.postion doubleValue] * [model.avgPrice doubleValue]) - 1.00] ;
     if ([postion doubleValue] > 0) {
     self.subTitleLabel.text = postion;
     } else {
     self.subTitleLabel.text = @"0.00";
     }
     if ([postion doubleValue] > 0) {
     self.desTitleLabel.text = [NSString stringWithFormat:@"%.2f%%",[postionRate doubleValue] * 100];
     } else {
     self.desTitleLabel.text = @"0.00%";
     }
     */
    
    NSArray *favLists = [[PL_ProvidenceDataManager manager] getAllModels];
    
    __block float availableMoney = 0;
    [favLists enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        availableMoney += [obj.avgPrice floatValue] * [obj.postion floatValue];
    }];
    
    [[PL_ProvidenceFavDBManager manager] getPositionArrayWithCallback:^(NSArray * _Nonnull favList) {
        [favList enumerateObjectsUsingBlock:^(PL_ProvidenceHomeStockModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![obj.symbol containsString:@"sh"] || ![obj.symbol containsString:@"sz"]) {
                availableMoney += [obj.trade floatValue] * [obj.hands floatValue];
            }
        }];
//        self.dataSource = favList;
    }];
    
    __block float totalValue1 = 0;
    [favLists enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        totalValue1  += [obj.priceNow floatValue] * [obj.postion floatValue];
    }];
    
    self.dataSource = nil;
    NSString *totalValue = nil;
    if (totalValue1 == 0) {
        totalValue = @"----";
    } else {
        totalValue = [NSString stringWithFormat:@"%.2lf",totalValue1];
    }
    
    __block float totalyk1 = 0;
    [favLists enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        
        totalyk1 += ([model.priceNow doubleValue] - [model.avgPrice doubleValue]) * [model.postion doubleValue];
    }];
    

    NSString *totalyk = nil;
    if (totalValue1 == 0) {
        totalyk  = @"----";
    } else {
        totalyk = [NSString stringWithFormat:@"%.2lf",totalyk1];
    }
    
    __block float onDayyk1 = 0;
    [favLists enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
        onDayyk1 += ([model.priceNow doubleValue] - [model.settlement doubleValue]) * [model.postion doubleValue];
    }];
    
    NSString *onDayyk = nil;
    if (totalValue1 == 0) {
        onDayyk  = @"----";
    } else {
        onDayyk = [NSString stringWithFormat:@"%.2lf",onDayyk1];
    }
    onDayyk  = @"----";
//    NSInteger result = [NSString compareDate:model.time withDate:[NSString localStringFromUTCDate:[NSDate date]]];
//
//    if (result == 0) {
//        onDayyk  = @"----";
//    }
    
    NSString *totalIntegral = k_MoneyManagerModel.totalIntegral ? k_MoneyManagerModel.totalIntegral : @"---";;
    NSString *availableIntegral = [NSString stringWithFormat:@"%.2f",[totalIntegral floatValue] - availableMoney];
    
    self.dataSource = @[@{@"title":@"持仓市值",@"des":totalIntegral},@{@"title":@"持总盈亏",@"des":totalyk},@{@"title":@"当日盈亏",@"des":onDayyk},@{@"title":@"总积分",@"des":totalIntegral},@{@"title":@"可用",@"des":availableIntegral},@{@"title":@"申请积分",@"des":@""}];
    [self.collectionView reloadData];
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    self.dataSource = @[@{@"title":@"持仓市值",@"des":@"17000"},@{@"title":@"持总盈亏",@"des":@"----"},@{@"title":@"当日盈亏",@"des":@"-----"},@{@"title":@"总积分",@"des":@"---"},@{@"title":@"可用",@"des":@"---"},@{@"title":@"申请积分",@"des":@""}];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ScreenWidth/3, 80);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceDealTopCell" bundle:nil] forCellWithReuseIdentifier:@"TopCell"];
    [self addSubview:self.collectionView];
}


@end
