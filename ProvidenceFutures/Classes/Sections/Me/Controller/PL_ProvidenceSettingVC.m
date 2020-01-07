//
//  PL_ProvidenceSettingVC.m
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
//.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceSettingVC.h"
#import "PL_ProvidenceSettingCell.h"
#import "PL_ProvidenceWebViewController.h"
#import <UIImageView+WebCache.h>
#import "PL_ProvidenceLoginVC.h"
#import "PL_ProvidenceDealMoneyVC.h"
#import "PL_ProvidenceDealVC.h"
#import "PL_ProvidenceDealModel.h"

@interface PL_ProvidenceSettingVC ()<UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, strong) UILabel *totalValueLabel;
@property (nonatomic, assign) CGFloat imageHeight;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) UIView *tableViewHeaderView;
@property (nonatomic, strong) UIImageView *headerBackView;


@end

@implementation PL_ProvidenceSettingVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self config];
    [self setupUI];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    [self refreshData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.mas_equalTo(0);
    }];
}

- (void)config {
    self.view.backgroundColor = [UIColor whiteColor];
    _imageHeight = 200;
}

- (void)setupUI {
    [self buildData];
    [self createTableViewHeaderView];
    [self.view addSubview:self.tableView];
}

#pragma mark - 创建头视图
- (void)createTableViewHeaderView
{
    _tableViewHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, _imageHeight)];
    
    // 背景图
    _headerBackView = [[UIImageView alloc] init];
    _headerBackView.frame = CGRectMake(0, 0, ScreenWidth, _imageHeight * 0.8);
    _headerBackView.image = [UIImage imageNamed:@"ic_my_hdimg.jpeg"];
    [_tableViewHeaderView addSubview:_headerBackView];
    
    
    UILabel *headLineLabel = [[UILabel alloc] init];
    headLineLabel.frame = CGRectMake(0, 0, ScreenWidth, 20);
    headLineLabel.textColor = [UIColor whiteColor];
    headLineLabel.font = [UIFont boldSystemFontOfSize:18];
    headLineLabel.text = @"我的";
    headLineLabel.textAlignment  = NSTextAlignmentCenter;
    [_tableViewHeaderView addSubview:headLineLabel];
    
    UIButton *exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    exitButton.frame = CGRectMake(ScreenWidth-60, 0,30 , 30);
    [exitButton setImage:[UIImage imageNamed:@"icon_me_exit"] forState:UIControlStateNormal];
    [exitButton addTarget:self action:@selector(logoutCurrentAccount) forControlEvents:UIControlEventTouchUpInside];
    [_tableViewHeaderView addSubview:exitButton];
    
    
    UILabel *totalLabel = [[UILabel alloc] init];
    totalLabel.frame = CGRectMake(0, CGRectGetMaxY(headLineLabel.frame)+10, ScreenWidth, 20);
    totalLabel.textColor = [UIColor whiteColor];
    totalLabel.text = @"总积分";
    totalLabel.font = [UIFont systemFontOfSize:12];
    totalLabel.textAlignment  = NSTextAlignmentCenter;
    [_tableViewHeaderView addSubview:totalLabel];
    
    UILabel *totalValueLabel = [[UILabel alloc] init];
    totalValueLabel.frame = CGRectMake(0, CGRectGetMaxY(totalLabel.frame)+10, ScreenWidth, 40);
    totalValueLabel.textColor = [UIColor whiteColor];
    totalValueLabel.text = @"18888888.00";
    totalValueLabel.font = [UIFont boldSystemFontOfSize:24];
    totalValueLabel.textAlignment  = NSTextAlignmentCenter;
    [_tableViewHeaderView addSubview:totalValueLabel];
    _totalValueLabel = totalValueLabel;
    
    
    UIButton *lookButton = [UIButton buttonWithType:UIButtonTypeCustom];
    lookButton.frame = CGRectMake(0, CGRectGetMaxY(totalValueLabel.frame)+ 10, ScreenWidth, 20);
    lookButton.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    [lookButton setTitle:@"查看详情 >" forState:UIControlStateNormal];
    [lookButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [lookButton addTarget:self action:@selector(clickLookButton) forControlEvents:UIControlEventTouchUpInside];
    [_tableViewHeaderView addSubview:lookButton];
    
    
    UIButton *applyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [applyButton setTitle:@"申请积分" forState:UIControlStateNormal];
    applyButton.frame = CGRectMake(0, CGRectGetMaxY(lookButton.frame)+ 10, 120, 30);
    applyButton.centerX = _tableViewHeaderView.centerX;
    [applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    applyButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];;
    [applyButton addTarget:self action:@selector(clickApplyButton) forControlEvents:UIControlEventTouchUpInside];
    [_tableViewHeaderView addSubview:applyButton];
    applyButton.layer.cornerRadius = 10;
    applyButton.layer.borderColor = [UIColor whiteColor].CGColor;
    applyButton.layer.masksToBounds = YES;
    applyButton.layer.borderWidth = 1;
    
//    [_tableViewHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.size.mas_equalTo(CGSizeMake(ScreenWidth, _imageHeight));
//    }]
//    
//    
//    [headLineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view).offset(kStatustopH);
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(44);
//    }];
//    
//    [totalLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(20);
//        make.top.mas_equalTo(headLineLabel.mas_bottom).offset(10);
//    }];
//    
//    [totalValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(30);
//        make.top.mas_equalTo(totalLabel.mas_bottom).offset(10);
//    }];
//    
//    [lookButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(20);
//        make.top.mas_equalTo(totalValueLabel.mas_bottom).offset(10);
//    }];
//    
//    [applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(30);
//        make.top.mas_equalTo(lookButton.mas_bottom).offset(10);
//    }];
}

- (void)refreshTopViewData {
    NSString *totalIntegral = k_MoneyManagerModel.totalIntegral ? k_MoneyManagerModel.totalIntegral : @"---";;
    self.totalValueLabel.text = totalIntegral;
//    NSString *username = k_CurrentLoginData.username;
//    if (!username) {
//        _userNameLabel.text = @"未登陆";
//    } else {
//        _userNameLabel.text = username;
//    }
//    NSData *imagedata = [[NSUserDefaults standardUserDefaults] objectForKey:@"imageData"];
//    if (imagedata.length >0) {
//        _photoImageView.image = [UIImage imageWithData:imagedata];
//    }
}

- (void)clickLookButton {
    PL_ProvidenceDealVC *vc = [[PL_ProvidenceDealVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)clickApplyButton {
    PL_ProvidenceDealMoneyVC *vc = [[PL_ProvidenceDealMoneyVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat width = self.view.frame.size.width;// 图片的宽度
    CGFloat yOffset = scrollView.contentOffset.y;// 偏移的y值
    NSLog(@"%f",yOffset);
    if (yOffset < 0) {
        CGFloat totalOffset = _imageHeight + ABS(yOffset);
        CGFloat f = totalOffset / _imageHeight;
        self.headerBackView.frame = CGRectMake(- (width * f - width) / 2, yOffset, width * f, totalOffset);// 拉伸后的图片的frame应该是同比例缩放
    }
    
}


#pragma mark - table delegate


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sections = self.dataSource[section];
    return sections.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"reuseCell";
    PL_ProvidenceSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId ];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.mainTitle.text = self.dataSource[indexPath.section][indexPath.row][@"text"];
    cell.desTitle.text = self.dataSource[indexPath.section][indexPath.row][@"des"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 10)];
    view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    view.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
    return view;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (!k_CurrentLoginData.isLogin) {
        PL_ProvidenceLoginVC *vc = [PL_ProvidenceLoginVC new];
        vc.modalPresentationStyle = 0;
        [self presentViewController:vc animated:YES completion:nil]; return;
    }
    
    NSString *className = self.dataSource[indexPath.section][indexPath.row][@"className"];
    NSString *title = self.dataSource[indexPath.section][indexPath.row][@"text"];
    UIViewController *vc = [[NSClassFromString(className) alloc] init];
    vc.title = title;

    if ([className isEqualToString:@"TT_CleanController"]) {
        [self cleanCache];
    } else if ([className isEqualToString:@"PL_ProvidenceSettingAgreeVC"]) {
        [self openUserProtocol];
    } else if ([className isEqualToString:@"PL_ProvidenceLogoutViewController"]) {
        [self logoutCurrentAccount];
    } else if ([className isEqualToString:@"PL_ProvidenceUpdateHeadImg"]) {
        [self clickTap];
    }  else {
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)openUserProtocol {
    PL_ProvidenceWebViewController *webvc = [[PL_ProvidenceWebViewController alloc] init];
    webvc.islocal = YES;
    webvc.gotoURL = [[NSBundle mainBundle] pathForResource:@"PL_Providence_user_protocol" ofType:@"html"];
    [self.navigationController pushViewController:webvc animated:YES];
}

- (void)clickTap {
    
    if (!k_CurrentLoginData.isLogin) {
        PL_ProvidenceLoginVC *vc = [PL_ProvidenceLoginVC new];
        vc.modalPresentationStyle = 0;
        [self presentViewController:vc animated:YES completion:nil]; return;
    }
    [self onTouchPortrait];
}

- (void)cleanCache {
    NSString *cacheString = [NSString stringWithFormat:@"清除缓存%uMB",arc4random_uniform(10)];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:cacheString message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert PL_ProvidenceshowAlertWithCompletionHandler:^(NSInteger alertIndex) {
        switch (alertIndex) {
            case 1:
                [MBProgressHUD showSuccess:@"清理成功"];
                break;
            default:
                break;
        }
    }];
}

- (void)logoutCurrentAccount {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"退出当前帐号？" message:nil delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert PL_ProvidenceshowAlertWithCompletionHandler:^(NSInteger alertIndex) {
        switch (alertIndex) {
            case 1:
               [[NSNotificationCenter defaultCenter] postNotificationName:PL_ProvidenceNotificationLogout object:nil];
                break;
            default:
                break;
        }
    }];
}

- (void)onTouchPortrait{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册", nil];
        [sheet showInView:self.view completionHandler:^(NSInteger index) {
            switch (index) {
                case 0:
                    [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
                    break;
                case 1:
                    [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
                    break;
                default:
                    break;
            }
        }];
    }else{
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"设置头像" delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册", nil];
        [sheet showInView:self.view completionHandler:^(NSInteger index) {
            switch (index) {
                case 0:
                    [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
                    break;
                default:
                    break;
            }
        }];
    }
}

- (void)showImagePicker:(UIImagePickerControllerSourceType)type{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate      = self;
    picker.sourceType    = type;
    picker.allowsEditing = YES;
    [self presentViewController:picker animated:YES completion:nil];
}


#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    [picker dismissViewControllerAnimated:YES completion:^{
        [self uploadImage:image];
    }];
}

- (void)uploadImage:(UIImage *)image{
    [MBProgressHUD showMessage:@""];
    NSData *imageData = UIImageJPEGRepresentation(image,1.0);
    [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:@"imageData"];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


- (void)buildData {
    
      
     self.dataSource = @[@[@{@"des":@"",@"text":@"缓存清理",@"className":@"TT_CleanController"},@{@"des":@"",@"text":@"意见反馈",@"className":@"PL_ProvidenceSettingTickVC"},@{@"des":@"",@"text":@"用户服务协议",@"className":@"PL_ProvidenceSettingAgreeVC"}],@[@{@"des":k_CurrentLoginData.username ?k_CurrentLoginData.username:@"" ,@"text":@"昵称",@"className":@"PL_ProvidenceSettingNameVC"},@{@"des":k_CurrentLoginData.sgin ? k_CurrentLoginData.sgin : @"",@"text":@"个性签名",@"className":@"PL_ProvidenceSettingSignVC"},@{@"des":@"",@"text":@"修改头像",@"className":@"PL_ProvidenceUpdateHeadImg"},@{@"des":@"",@"text":@"修改密码",@"className":@"PL_ProvidenceSettingChangePassVC"}],@[@{@"des":@"",@"text":@"关于我们",@"className":@"PL_ProvidenceSettingAboutVC"}]];
    
}

- (void)refreshData {
    [self buildData];
    [self refreshTopViewData];
    [self.tableView reloadData];
}


- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 64;
        _tableView.tableHeaderView = _tableViewHeaderView;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"f5f5f5"];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"PL_ProvidenceSettingCell" bundle:nil] forCellReuseIdentifier:@"reuseCell"];
        
    }
    return _tableView;
}


@end
