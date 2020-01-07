//
//  PL_ProvidenceDealDyCell.m
//  EvianFutures-OC
//
//  // Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//

#import "PL_ProvidenceDealDyCell.h"
#import "PL_ProvidenceDealCollectionViewCell.h"

@interface PL_ProvidenceDealDyCell ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (strong, nonatomic)  UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation PL_ProvidenceDealDyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self pf_periodsetupUI];
}

- (void)clickMoneyButton {
    //    PF_PeriodDynamicMoneyController *vc = [[PF_PeriodDynamicMoneyController alloc] init];
    //    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (void)refreshData {
//    self.dataSource = nil;
//    NSString *totalValue = k_MoneyManagerModel.totalValue ? k_MoneyManagerModel.totalValue : @"---";
//    NSString *totalyk = k_MoneyManagerModel.totalyk ? k_MoneyManagerModel.totalyk : @"---";;
//    NSString *onDayyk = k_MoneyManagerModel.onDayyk ? k_MoneyManagerModel.onDayyk : @"---";;
//    NSString *totalIntegral = k_MoneyManagerModel.totalIntegral ? k_MoneyManagerModel.totalIntegral : @"---";;
//    NSString *availableIntegral = k_MoneyManagerModel.availableIntegral ? k_MoneyManagerModel.availableIntegral : @"---";;
//
//    self.dataSource = @[@{@"title":@"持仓市值",@"des":totalValue},@{@"title":@"持总盈亏",@"des":totalyk},@{@"title":@"当日盈亏",@"des":onDayyk},@{@"title":@"总积分",@"des":totalIntegral},@{@"title":@"可用",@"des":availableIntegral},@{@"title":@"申请积分",@"des":@""}];
//    [self.collectionView reloadData];
}



- (void)pf_periodsetupUI {
    
    self.backgroundColor = [UIColor colorWithHexString:@"#f5f5f5"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ScreenWidth/3, 110);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.scrollDirection  =UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 5, self.bounds.size.width, 110) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.alwaysBounceHorizontal = YES;
    _collectionView.showsHorizontalScrollIndicator = NO;
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceDealCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"TopCell"];
    [self addSubview:self.collectionView];
    
    [self.lineView bringSubviewToFront:self];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    //    if ([self.delegate respondsToSelector:@selector(topViewClickdidSelectItemAtIndexPath:)]) {
    //        [self.delegate topViewClickdidSelectItemAtIndexPath:indexPath];
    //    }
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   PL_ProvidenceDealCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
    [cell refreshData:self.model indexRow:indexPath.item];
    return cell;
}

@end
