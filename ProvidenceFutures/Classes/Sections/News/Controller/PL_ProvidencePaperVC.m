//
//  PL_ProvidencePaperVC.m
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
//2019/9/30.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidencePaperVC.h"
#import "PL_ProvidencePaperCell.h"
#import "PL_ProvidencePaperModel.h"
#import "PL_ProvidencePaperCell.h"
#import "PL_ProvidencePaperDetailVC.h"
#import "PL_ProvidenceWebViewController.h"

@interface PL_ProvidencePaperVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, assign) NSInteger pageSize;

@end

@implementation PL_ProvidencePaperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
 
    [self setupUI];
    [self configData];
    [self loadDataPage:_page];//加载缓存
}



-(void)loadDataPage:(NSInteger)page {
    NSString *urlString = @"http://47.110.124.138:8081/stock/api/newslist";
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    [params setObject:[NSString stringWithFormat:@"%ld",page] forKey:@"page"];
    [PL_ProvidenceHttpRequest getWithURL:urlString params:nil completion:^(NSError *error, id responseObject) {
        [self endLoading];
        if (!error) {
            
            if (self.page == 1) {
                [self.dataSource removeAllObjects];
                self.dataSource = [PL_ProvidencePaperModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
               
            } else {
                NSArray *models = [PL_ProvidencePaperModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
                [self.dataSource addObjectsFromArray:models];
            }
            self.total  = [responseObject[@"count"] integerValue];
            [self.tableView reloadData];
        } else {
            
        }

    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PL_ProvidencePaperCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell3333" forIndexPath:indexPath];
    [cell refreshData:self.dataSource[indexPath.row]];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [_tableView deselectRowAtIndexPath:indexPath animated:NO];
    PL_ProvidencePaperDetailVC *vc = [[PL_ProvidencePaperDetailVC alloc] init];
    PL_ProvidencePaperModel *model = self.dataSource[indexPath.row];
    [self loadDataModelID:model.ID];
}

- (void)loadDataModelID:(NSString *)ID {
    
    
    NSString *urlString = @"http://47.110.124.138:8081/stock/api/newsdetail/";
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:1];
    [params setObject:ID forKey:@"id"];
    [PL_ProvidenceHttpRequest getWithURL:urlString params:params completion:^(NSError *error, id responseObject) {
        if (!error) {
//            self.navigationItem.title = responseObject[@"data"][@"title"];
            NSString *str = responseObject[@"data"][@"content"];
            AXWebViewController *webVC = [[AXWebViewController alloc]
                                          initWithHTMLString:str baseURL:nil];
            webVC.title = responseObject[@"data"][@"title"];
//            webVC.navigationBackBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStyleDone target:self action:@selector(clickBackButton)];;
//            webVC.showsToolBar = NO;
//            webVC.navigationController.navigationBar.translucent = NO;
//            self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:0.100f green:0.100f blue:0.100f alpha:0.800f];
//            self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.996f green:0.867f blue:0.522f alpha:1.00f];
            [self.navigationController pushViewController:webVC animated:YES];
        }
      
    }];

}

- (void)loadRefresh
{
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    [_tableView.mj_header setAutoChangeAlpha:YES];
    [_tableView.mj_footer setAutoChangeAlpha:YES];
    
    [_tableView.mj_header beginRefreshing];
}

-(void)endLoading{
    [_tableView.mj_footer endRefreshing];
    [_tableView.mj_header endRefreshing];
}

-(void)loadMore{
    if ([_tableView.mj_footer isRefreshing])
    {
        _page++;
        _pageSize = 20;
        
        [self requestGo];
    }
}

-(void)refresh{
    if ([_tableView.mj_header isRefreshing]) {
        _page = 1;
        _pageSize = 10;
        [self requestGo];
    }
}
-(void)requestGo{
    [self loadDataPage:_page];
}

#pragma mark 资讯列表数据

-(void)getDataListWithPage:(int)aPage{
    
    __weak typeof(self) weakSelf = self;

}


- (void)configData {
        _page = 1;
    self.navigationItem.title = @"新闻";
}

- (void)setupUI {
    //    self.view.backgroundColor = color_separateLine;
    _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.rowHeight = 100;
//    _tableView.estimatedSectionHeaderHeight = 0;
//    _tableView.estimatedSectionFooterHeight = 0;
    [_tableView registerNib:[UINib nibWithNibName:@"PL_ProvidencePaperCell" bundle:nil] forCellReuseIdentifier:@"cell3333"];
    [self.view addSubview:_tableView];
    [self loadRefresh];
}
//
//- (void)showRemindLabWithNum:(int)newIdNum
//{
//    if (_page == 1) {
//        //        __weak NewsPage * newsPage = self;
//        __block UILabel * remindLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 28)];
//        remindLab.text = newIdNum==0 ? @"暂无信息更新":[NSString stringWithFormat:@"有%d条信息更新",newIdNum];
//        remindLab.alpha = 1;
//        remindLab.font = Font_Text_S;
//        remindLab.textAlignment = NSTextAlignmentCenter;
//        remindLab.textColor = [UIColor colorsWithRed:170/255.0 green:205/255.0 blue:225/255.0];
//        remindLab.backgroundColor = [UIColor colorsWithRed:58/255.0 green:128/255.0 blue:181/255.0];;
//        [self.view addSubview:remindLab];
//        _tableView.frame = CGRectMake(0, 28, ScreenWidth, self.view.frame.size.height-28);
//        [UIView animateWithDuration:1.5 delay:1 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
//            remindLab.alpha = 0.3;
//        } completion:^(BOOL finished) {
//            [remindLab removeFromSuperview];
//            [self tableViewBack];
//            remindLab = nil;
//        }];
//    }
//
//}
//
//- (void)tableViewBack
//{
//    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionOverrideInheritedDuration animations:^{
//        _tableView.frame = CGRectMake(0, 0, ScreenWidth, self.view.frame.size.height);
//    } completion:^(BOOL finished) {
//    }];
//}


#pragma mark 资讯列表数据





@end
