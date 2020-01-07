//
//  PL_ProvidenceSettingNameVC.m
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

#import "PL_ProvidenceSettingNameVC.h"

@interface PL_ProvidenceSettingNameVC ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

@end

@implementation PL_ProvidenceSettingNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self config];
    
    self.saveButton.backgroundColor = kMainColor;
}

- (IBAction)clickRightButton:(id)sender {
    [self clickRightButton];
}

- (void)clickRightButton {
    if (self.textFiled.text.length < 1) {
        [MBProgressHUD showError:@"请输入昵称"]; return;
    }
    PL_ProvidenceLoginData *data = k_CurrentLoginData;
    data.username = self.textFiled.text;
    k_CurrentLoginData = data;
    
    [MBProgressHUD showMessage:@""];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [MBProgressHUD showSuccess:@"修改成功"];
        [self.navigationController popViewControllerAnimated:YES];
    });
}

- (void)config {
//    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [rightButton setTitle:@"保存" forState:UIControlStateNormal];
//    [rightButton addTarget:self action:@selector(clickRightButton) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
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
