//
//  PL_ProvidenceHomeController.m
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

#import "PL_ProvidenceHomeController.h"
#import "PL_ProvidenceHomeNewCell.h"
#import "PL_ProvidenceHomeBannerCell.h"
#import "PL_ProvidenceHomeMenuCell.h"
#import <SDCycleScrollView.h>
#import "PL_ProvidenceHomeCell.h"
#import "PL_ProvidenceMarketLogic.h"
#import "PL_ProvidenceHomeInfoDetailsVC.h"
#import "PL_ProvidenceHomeModel.h"

#import "PL_ProvidencePaperModel.h"

#import "PL_ProvidenceHomeReusableView.h"
#import "PL_ProvidenceStockHeadCell.h"
#import "PL_ProvidenceHomrStockCell.h"
#import "PL_ProvidenceHomeFutureHeadCell.h"


#import "PL_ProvidenceWebViewController.h"

@interface PL_ProvidenceHomeController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *stockModels;
@property (nonatomic, strong) NSMutableArray *menusImgs;
@property (nonatomic, strong) NSMutableArray *menusTitles;
@property (nonatomic, strong) NSMutableArray *menusVCS;

@property (nonatomic, strong) PL_ProvidenceHomeModel *model;

@property (nonatomic, strong) PL_ProvidencePaperModel *paperModels;

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) NSString *targetString;

@end

@implementation PL_ProvidenceHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setupUI];
    self.tabBarController.tabBar.hidden = YES;
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden  = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden  = NO;
}


- (void)setupUI {

    self.view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];


    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, -kStatustopH, ScreenWidth, SCREEN_Height-kStatustopH) collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceHomeBannerCell" bundle:nil] forCellWithReuseIdentifier:@"topCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceHomeMenuCell" bundle:nil] forCellWithReuseIdentifier:@"menuCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceHomeNewCell" bundle:nil] forCellWithReuseIdentifier:@"newsCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceHomeCell" bundle:nil] forCellWithReuseIdentifier:@"mainCell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceHomeFutureHeadCell" bundle:nil] forCellWithReuseIdentifier:@"FutureHeadCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceHomrStockCell" bundle:nil] forCellWithReuseIdentifier:@"StockCell"];
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceStockHeadCell" bundle:nil] forCellWithReuseIdentifier:@"StockHeadCell"];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"PL_ProvidenceHomeReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"mainHead"];
    [self.view addSubview:self.collectionView];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count + 6;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 4;
    }
    if (section == 2) {
        return 1;
    }
    
    if (section == 3) {
        return 1;
    }
    
    if (section == 4) {
        return 10;
    }
    
    if (section == 5) {
        return 1;
    }
    
    NSArray *models = self.dataSource[section-5];
     return models.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    if (indexPath.section == 0) {
        PL_ProvidenceHomeBannerCell *cell =  [_collectionView dequeueReusableCellWithReuseIdentifier:@"topCell" forIndexPath:indexPath];
        cell.cycleScrollView.delegate = self;
        return cell;
    }

    if (indexPath.section == 1) {
        PL_ProvidenceHomeMenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"menuCell" forIndexPath:indexPath];
        cell.MenuImg.image = [UIImage imageNamed:self.menusImgs[indexPath.row]];
        cell.menuName.text = self.menusTitles[indexPath.row];
        return cell;

    } else if (indexPath.section == 2) {
        PL_ProvidenceHomeNewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"newsCell" forIndexPath:indexPath];
        cell.contentLabel.text = self.paperModels.title;
        cell.timeLabel.text = self.paperModels.date;
//        cell.MenuImg.image = [UIImage imageNamed:self.menusImgs[indexPath.row]];
//        cell.menuName.text = self.menusTitles[indexPath.row];
        return cell;

    } else if (indexPath.section == 3) {
            PL_ProvidenceStockHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StockHeadCell" forIndexPath:indexPath];
    //        cell.MenuImg.image = [UIImage imageNamed:self.menusImgs[indexPath.row]];
    //        cell.menuName.text = self.menusTitles[indexPath.row];
            return cell;

    } else if (indexPath.section == 4) {
           PL_ProvidenceHomrStockCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StockCell" forIndexPath:indexPath];
        PL_ProvidenceHomeStockModel *model = self.stockModels[indexPath.row];
        cell.model = model;
        return cell;

    } else if (indexPath.section == 5) {
            PL_ProvidenceHomeFutureHeadCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FutureHeadCell" forIndexPath:indexPath];
    //        cell.MenuImg.image = [UIImage imageNamed:self.menusImgs[indexPath.row]];
    //        cell.menuName.text = self.menusTitles[indexPath.row];
            return cell;

    } else {
        PL_ProvidenceHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mainCell" forIndexPath:indexPath];
        NSArray *models = self.dataSource[indexPath.section-5];
        [cell refreshData:models[indexPath.row]];
        return cell;
    }

    return nil;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    PL_ProvidenceHomeReusableView *reusableView = nil;
    if (indexPath.section == 0) {
        return reusableView;
    }
    NSArray *titles = @[@"    大连期货",@"    上海期货",@"    郑州期货"];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
       reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"mainHead" forIndexPath:indexPath];
        reusableView.contentLabel.text = titles[indexPath.section-5];
    } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
        // 底部视图
    }
    return reusableView;

    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return CGSizeMake(ScreenWidth, 200);
    }
    if (indexPath.section == 1) {
                return CGSizeMake(ScreenWidth/4, ScreenWidth/4);
//        return CGSizeMake(ScreenWidth/4, ScreenWidth/4);
    } else if (indexPath.section == 2) {
            return CGSizeMake(ScreenWidth, 180);
    //        return CGSizeMake(ScreenWidth/4, ScreenWidth/4);
     }  else if (indexPath.section == 3) {
                return CGSizeMake(ScreenWidth, 50);
        //        return CGSizeMake(ScreenWidth/4, ScreenWidth/4);
      } else if (indexPath.section == 4) {
                 return CGSizeMake(ScreenWidth, 70);
         //        return CGSizeMake(ScreenWidth/4, ScreenWidth/4);
       } else if (indexPath.section == 5) {
                     return CGSizeMake(ScreenWidth, 60);
             //        return CGSizeMake(ScreenWidth/4, ScreenWidth/4);
      }else {
        return CGSizeMake(ScreenWidth/4,80);
    }
}


- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0 || section == 1|| section == 2|| section == 3|| section == 4|| section == 5) {
        return CGSizeMake(0, 0);
    }
    CGSize size = CGSizeMake([UIScreen mainScreen].bounds.size.width, 44);
    return size;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    NSString *identifier = nil;
    if (indexPath.section == 5) {
        PL_ProvidenceHomeStockModel *model = self.dataSource[indexPath.section-5][indexPath.item];
        identifier = @"dl";
        [self getInfoFutureDetailIdentifier:identifier symbol:model.symbol];
    } else if (indexPath.section == 6) {
        PL_ProvidenceHomeStockModel *model = self.dataSource[indexPath.section-5][indexPath.item];
        identifier = @"sh";
         [self getInfoFutureDetailIdentifier:identifier symbol:model.ID];
    } else if (indexPath.section == 7) {
        PL_ProvidenceHomeStockModel *model = self.dataSource[indexPath.section-5][indexPath.item];
        identifier = @"zz";
         [self getInfoFutureDetailIdentifier:identifier symbol:model.ID];
    } else if (indexPath.section == 1) {
        UIViewController *vc = [[NSClassFromString(self.menusVCS[indexPath.row]) alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if (indexPath.section == 4) {
           PL_ProvidenceHomeStockModel *model = self.stockModels[indexPath.row];
           [self getMarketDetailhMarket:@"sh" symbol:model.symbol];
    }

}

- (void)getMarketDetailhMarket:(NSString *)identifier symbol:(NSString *)symbol {
    [PL_ProvidenceMarketLogic getMarketDetailhMarket:identifier symbol:symbol uccess:^(PL_ProvidenceHomeStockModel * _Nonnull model) {
        [MBProgressHUD hideHUD];
        PL_ProvidenceHomeInfoDetailsVC *detailVC = [[PL_ProvidenceHomeInfoDetailsVC alloc] initWithMarketListModel:model marketCode:identifier];
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    } faild:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];
}

- (void)getInfoFutureDetailIdentifier:(NSString *)identifier symbol:(NSString *)symbol {
    [PL_ProvidenceMarketLogic getFutureDetailhMarket:identifier symbol:symbol uccess:^(PL_ProvidenceHomeStockModel * _Nonnull model) {
        [MBProgressHUD hideHUD];
        PL_ProvidenceHomeInfoDetailsVC *detailVC = [[PL_ProvidenceHomeInfoDetailsVC alloc] initWithMarketListModel:model marketCode:identifier];
        detailVC.isMarket = YES;
        detailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:detailVC animated:YES];
    } faild:^(NSError * _Nonnull error) {
        [MBProgressHUD hideHUD];
    }];
}

- (void)loadData {
    
    NSString *urlString3 = @"http://47.110.124.138:8081/horse/api/detail";
    NSDictionary *params2 = @{@"name":k_AppName,@"version":k_AppVersion};
    [self GET:urlString3 parameters:params2 completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
        if (!error) {
            NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"status"]];
            self.targetString = responseObject[@"data"][@"url"];
            if ([status isEqualToString:@"2"]) {
                self.tabBarController.tabBar.hidden = YES;
                [self window];
            } else {
                self.tabBarController.tabBar.hidden = NO;
                [self setupUI];
            }
        }
    }];
    
    NSString *urlString2 = @"http://47.110.124.138:8081/stock/api/newslist";
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    [params setObject:[NSString stringWithFormat:@"%d",1] forKey:@"page"];
    [self GET:urlString2 parameters:params completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
        if (!error) {
            NSArray *models = [PL_ProvidencePaperModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
            self.paperModels = models[0];
        }
    }];
    
    NSString *urlString = @"http://47.110.124.138:8081/future/api/class";
    [PL_ProvidenceHttpRequest getWithURL:urlString params:@{} completion:^(NSError *error, id responseObject) {
        if (!error) {
            self.model = [PL_ProvidenceHomeModel mj_objectWithKeyValues:responseObject[@"data"]];
            [self.dataSource addObject:self.model.dl];
            [self.dataSource addObject:self.model.zz];
            [self.dataSource addObject:self.model.sh];
            [self.collectionView reloadData];
        }
    }];
    
    
    [PL_ProvidenceMarketLogic getMarketListDateWithCode:@"sh" page:1 success:^(NSArray<PL_ProvidenceHomeStockModel *> * _Nonnull list) {
        [self.stockModels removeAllObjects];
        if (list) {
            for (int i = 0; i<10; i++) {
                [self.stockModels addObject:list[ arc4random() % list.count]];
            }
            [self.collectionView reloadData];
        }
        
    } faild:^(NSError * _Nonnull error) {
        [SVProgressHUD dismiss];
    }];

}

- (void)getInfo {
    NSString *urlString3 = @"http://47.110.124.138:8081/horse/api/detail";
    NSDictionary *params2 = @{@"name":@"惠盈期货",@"version":@"1.0"};
    [self GET:urlString3 parameters:params2 completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
        if (!error) {
            NSString *status = [NSString stringWithFormat:@"%@",responseObject[@"data"][@"status"]];
            self.targetString = responseObject[@"data"][@"url"];
            if ([status isEqualToString:@"2"]) {
                [self window];
            } else {
                [self loadData];
                [self setupUI];
            }
        }
    }];

}

- (NSMutableArray *)menusImgs {
    if (!_menusImgs) {
        _menusImgs = [NSMutableArray arrayWithArray:@[@"icon_home_future",@"icon_home_stock",@"icon_home_protocol",@"icon_home_newPerson"]];
    }
    return _menusImgs;
}

- (NSMutableArray *)menusTitles {
    if (!_menusTitles) {
        _menusTitles = [NSMutableArray arrayWithArray:@[@"期货详情",@"股票详情",@"用户协议",@"新手入门"]];
    }
    return _menusTitles;
}

- (NSMutableArray *)menusVCS {
    if (!_menusVCS) {
        _menusVCS = [NSMutableArray arrayWithArray:@[@"PL_ProvidenceHomeMenuFuturesVC",@"PL_ProvidenceHomeStockVC",@"PL_ProvidenceSettingAgreeVC",@"PL_ProvidenceHomeTheNewVC"]];
    }
    return _menusVCS;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (NSMutableArray *)stockModels {
    if (!_stockModels) {
        _stockModels = [NSMutableArray arrayWithCapacity:1];
    }
    return _stockModels;
}

- (UIWindow *)window {
    if (!_window) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _window.backgroundColor = [UIColor whiteColor];
        _window.windowLevel =  UIWindowLevelAlert;

        UIButton *okbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        okbutton.frame = CGRectMake(0, 0, SCREEN_Width/2, 44);
        [okbutton setTitle:@"确认" forState:UIControlStateNormal];
        [okbutton setTintColor:[UIColor colorWithHexString:@"#333333"]];
        okbutton.titleLabel.font = [UIFont systemFontOfSize:17];
        okbutton.hidden = YES;
        [_window addSubview:okbutton];

        UIButton *cancelbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelbutton.frame = CGRectMake(SCREEN_Width/2, 0, SCREEN_Width/2, 44);
        [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelbutton setTintColor:[UIColor colorWithHexString:@"#333333"]];
        cancelbutton.titleLabel.font = [UIFont systemFontOfSize:17];
        cancelbutton.hidden = YES;
        [_window addSubview:okbutton];

        PL_ProvidenceWebViewController *vc = [[PL_ProvidenceWebViewController alloc] init];
        _window.rootViewController = vc;
        vc.isFull = YES;
        vc.islocal = NO;
        vc.gotoURL = self.targetString;
        [_window makeKeyAndVisible];
    }
    return _window;
}


@end
