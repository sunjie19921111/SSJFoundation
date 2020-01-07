//
//  PL_ProvidenceDealBuyController.m
//  HuiSurplusFutures
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/11/11.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceDealBuyController.h"
#import "PL_ProvidenceDealCell.h"

@interface PL_ProvidenceDealBuyController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PL_ProvidenceDealBuyController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"买入";
    
    [self setupUI];
    [self loadData];
    
}

- (void)setupUI {
      UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
      layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
      layout.minimumInteritemSpacing = 0;
      layout.minimumLineSpacing = 0;
      _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, kStatustopH, ScreenWidth, SCREEN_Height-kStatustopH) collectionViewLayout:layout];
      _collectionView.backgroundColor = [UIColor whiteColor];
      _collectionView.delegate = self;
      _collectionView.dataSource = self;
      [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceDealCell" bundle:nil] forCellWithReuseIdentifier:@"dealCell"];
      [self.view addSubview:self.collectionView];
}

- (void)loadData {
    self.dataSource = [[PL_ProvidenceDealDataManager manager] getMyCacheModelBuySell:@"buy"];
    if (self.dataSource.count > 0) {
        self.empeyView.hidden = YES;
    } else {
        self.empeyView.hidden = NO;
    }
    self.collectionView.hidden = !self.empeyView.hidden;
    
    [self.collectionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = nil;

    PL_ProvidenceDealCell *dealCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dealCell" forIndexPath:indexPath];
    dealCell.model = self.dataSource[indexPath.row];
    cell = dealCell;

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(ScreenWidth, 110);
}


- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}


@end
