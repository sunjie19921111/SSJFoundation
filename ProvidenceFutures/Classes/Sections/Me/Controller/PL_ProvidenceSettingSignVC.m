//
//  PL_ProvidenceSettingSignVC.m
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
//2019/9/25.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceSettingSignVC.h"

@interface PL_ProvidenceSettingSignVC ()

@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation PL_ProvidenceSettingSignVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.saveButton.backgroundColor = kMainColor;
}

- (IBAction)clickSaveButton:(UIButton *)sender {
    [self clickRightButton];
}

- (void)clickRightButton {
    if (self.textFiled.text.length < 1) {
        [MBProgressHUD showError:@"请输入个性签名"]; return;
    }
    PL_ProvidenceLoginData *data = k_CurrentLoginData;
    data.sgin = self.textFiled.text;
    k_CurrentLoginData = data;
    [MBProgressHUD showMessage:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUD];
        [self.navigationController popViewControllerAnimated:YES];
    });
}


//- (void)setupUI {
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
//}


@end
