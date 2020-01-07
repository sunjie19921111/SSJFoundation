//
//  PL_ProvidenceDealTodayTradeVC.m
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

#import "PL_ProvidenceDealTodayTradeVC.h"
#import "PL_ProvidenceDealCell.h"
#import "PL_ProvidenceDealModel.h"

@interface PL_ProvidenceDealTodayTradeVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;


@end

@implementation PL_ProvidenceDealTodayTradeVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"今日交易";
    [self setupUI];
    [self loadData];
    
}

- (void)setupUI {
    [self.view addSubview:self.tableView];
}

- (void)loadData {
    self.dataSource = [[PL_ProvidenceDealDataManager manager] getAllModels];
    NSString *nowDate = [NSString localStringFromDate:[NSDate date]];
    NSArray *models = [self.dataSource mutableCopy];
    [models enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (![obj.dateString isEqualToString:nowDate]) {
            [self.dataSource removeObject:obj];
        }
    }];
    if (self.dataSource.count > 0) {
        self.empeyView.hidden = YES;
    } else {
        self.empeyView.hidden = NO;
    }
    self.tableView.hidden = !self.empeyView.hidden;
    [self.tableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    PL_ProvidenceDealCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    PL_ProvidenceDealModel *model = [self.dataSource objectAtIndex:indexPath.row];
    cell.model = model;

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 110;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"PL_ProvidenceDealCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        _tableView.tableFooterView = [[UIView alloc] init];
        
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSource;
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
