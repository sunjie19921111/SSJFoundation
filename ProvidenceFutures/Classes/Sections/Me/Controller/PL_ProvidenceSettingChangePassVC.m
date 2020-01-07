//
//  PL_ProvidenceSettingChangePassVC.m
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

#import "PL_ProvidenceSettingChangePassVC.h"

@interface PL_ProvidenceSettingChangePassVC ()

@property (weak, nonatomic) IBOutlet UITextField *oldPass;
@property (weak, nonatomic) IBOutlet UITextField *freshPass;
@property (weak, nonatomic) IBOutlet UITextField *freshPass2;
@property (weak, nonatomic) IBOutlet UIButton *subitButton;

@end

@implementation PL_ProvidenceSettingChangePassVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.subitButton.backgroundColor = kMainColor;
}

- (void)PL_ProvidenceupdatePass {
    NSString *text1 = self.oldPass.text;
    NSString *text2 = self.freshPass.text;
    if (![text1 isEqualToString:k_CurrentLoginData.password]) {
        [MBProgressHUD showSuccess:@"请输入正确的原密码"];
        return;
    }
    if (text2.length == 0) {
        [MBProgressHUD showSuccess:@"请输入新密码"];
        return;
    }
    NSDictionary *parameter = @{
                                @"uid" : k_CurrentLoginData.uid,
                                @"oldPass" : text1,
                                @"newPass" : text2
                                };
    [PL_ProvidenceHttpRequest post:PL_ProvidenceUPDATE_USER_URL params:parameter complete:^(id result, NSError *error, NSURLSessionDataTask *task) {
        if (!error) {
            PL_ProvidenceLoginData *data = k_CurrentLoginData;
            data.password = text2;
            k_CurrentLoginData = data;
        }
    }];
}

- (IBAction)PL_ProvidenceclickSubitButton:(id)sender {
    [self PL_ProvidenceupdatePass];
}




@end
