//
//  PL_ProvidenceHomeTopView.m
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
//2019/9/27.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceHomeTopView.h"
#import "PL_ProvidenceHomeStockTopCell.h"
#import "PL_ProvidenceHomeStockTopModel.h"

@interface PL_ProvidenceHomeTopView ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PL_ProvidenceHomeTopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        [self loadData];
    }
    return self;
}

- (void)refreshData {
    [self loadData];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    
//    self.dataSource = @[@[@"上证指数",@"2905.19",@"-26.98.24[-0.92%]"],@[@"深证指数",@"9446.24",@"-102.72[-1.08%]"],@[@"创业指数",@"1627.55",@"-19.99[-1.21%]"]];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(ScreenWidth/3, ScreenWidth/3);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceHomeStockTopCell" bundle:nil] forCellWithReuseIdentifier:@"TopCell"];
    [self addSubview:self.collectionView];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PL_ProvidenceHomeStockTopCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TopCell" forIndexPath:indexPath];
    [cell refreshData:self.dataSource[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(topViewClickdidSelectItemAtIndexPath:)]) {
        [self.delegate topViewClickdidSelectItemAtIndexPath:indexPath];
    }
}

- (void)loadData {
    NSString *urlString = @"http://47.110.124.138:8081/stock/api/index";
    [PL_ProvidenceHttpRequest getWithURL:urlString params:@{} completion:^(NSError *error, id responseObject) {
        if (!error) {
            self.dataSource = [PL_ProvidenceHomeStockTopModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            [self.collectionView reloadData];
        }
    }];
    
    
}



@end
