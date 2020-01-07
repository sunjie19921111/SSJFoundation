//
//  PL_ProvidenceHomeTheNewVC.m
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
//2019/11/8.
//  Copyright © 2019 qhwr. All rights reserved.
//


#import "PL_ProvidenceHomeTheNewModel.h"
#import "PL_ProvidenceHomeTheNewDetailVC.h"
#import "PL_ProvidenceHomeTheNewVC.h"


@interface PL_ProvidenceHomeTheNewVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation PL_ProvidenceHomeTheNewVC

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.rowHeight = 60;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"新手入门";
    [self setupUI];
    [self getInfo];
  
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
}

- (void)getInfo {
    [MBProgressHUD showMessage:@"正在加载"];
    [PL_ProvidenceHttpRequest getWithURL:@"http://149.28.12.15:8080/gp/manual/list" params:@{} completion:^(NSError *error, id responseObject) {
        [MBProgressHUD hideHUD];
        if (!error) {
            self.dataSource = [PL_ProvidenceHomeTheNewModel mj_objectArrayWithKeyValuesArray:responseObject[@"retData"]];
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    PL_ProvidenceHomeTheNewModel *model = self.dataSource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row+1,model.name];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PL_ProvidenceHomeTheNewModel *model = self.dataSource[indexPath.row];
    PL_ProvidenceHomeTheNewDetailVC *vc = [[PL_ProvidenceHomeTheNewDetailVC alloc] init];
    vc.title = model.name;
    vc.m_id = model.m_id;
    [self.navigationController pushViewController:vc animated:YES];
}




@end
