//
//  PL_ProvidenceLoginVC.m
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
#import "PL_ProvidenceWebViewController.h"
#import "PL_ProvidenceNavigationVC.h"
#import "PL_ProvidenceLoginVC.h"
#import "PL_ProvidenceRegisteredVC.h"
#import "PL_ProvidenceTabVC.h"


@interface PL_ProvidenceLoginVC ()


@property (weak, nonatomic) IBOutlet UITextField *PL_ProvidenceuserName;
@property (weak, nonatomic) IBOutlet UITextField *PL_Providencepassword;
@property (weak, nonatomic) IBOutlet UIButton *PL_ProvidenceloginButton;
@property (weak, nonatomic) IBOutlet UIButton *PL_ProvidenceregisteredButton;
@property (weak, nonatomic) IBOutlet UIButton *PL_ProvidenceforgetButton;
@property (weak, nonatomic) IBOutlet UILabel *PL_ProvidencetitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *userProtocolButton;



@end

@implementation PL_ProvidenceLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)setupUI {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"登录代表您已阅读并同意《用户服务协议》"];
    NSRange range3 = [[str string] rangeOfString:@"《"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x666666"] range:range3];
    
    NSRange range4 = [[str string] rangeOfString:@"》"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x666666"] range:range4];
    
    NSRange range2 = [[str string] rangeOfString:@"登录代表您已阅读并同意"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"0x666666"] range:range2];
    self.userProtocolButton.titleLabel.attributedText = str;
    
    NSRange range1 = [[str string] rangeOfString:@"用户服务协议"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range1];
    
    [self.PL_ProvidenceloginButton addTarget:self action:@selector(PL_ProvidenceloginButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.PL_ProvidenceforgetButton addTarget:self action:@selector(PL_ProvidenceforgetButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.PL_ProvidenceregisteredButton addTarget:self action:@selector(PL_ProvidenceregisteredButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.userProtocolButton addTarget:self action:@selector(PL_ProvidenceloginUserProtocolClick) forControlEvents:UIControlEventTouchUpInside];
    self.PL_ProvidencetitleLabel.text = @"Hello!\n欢迎使用惠盈期货";
}



- (void)PL_ProvidenceloginButtonClick {
    NSString *userName = self.PL_ProvidenceuserName.text;
    NSString *password = self.PL_Providencepassword.text;
    
    if (userName.length < 1) {
        [MBProgressHUD showError:@"请输入账号"]; return;
    }
    if (password.length < 1) {
        [MBProgressHUD showError:@"请输入密码"]; return;
    }
    [MBProgressHUD showMessage:@""];
    [PL_ProvidenceHttpRequest post:PL_ProvidenceLOGIN_URL params:@{@"userName": userName,@"userPass":password} complete:^(id result, NSError *error, NSURLSessionDataTask *task) {
        
        if (!error) {
            NSString *message = [NSString stringWithFormat:@"%@",result[@"message"]];
            if (![message isEqualToString:@"登录成功"]) {
                [MBProgressHUD hideHUD];
                [MBProgressHUD showError:message]; return;
            }
            PL_ProvidenceLoginData *data = [PL_ProvidenceLoginData mj_objectWithKeyValues:result];
//            [JPUSHService setAlias:[NSString stringWithFormat:@"%@",data.uid] completion:nil seq:0];
            [PL_ProvidenceLoginManager sharedManager].currentLoginData = data;
            [[PL_ProvidenceHttpRequest netWork] resetSessionRequest:result completion:^{
                [MBProgressHUD hideHUD];
                [UIApplication sharedApplication].keyWindow.rootViewController = [[PL_ProvidenceTabVC alloc] init];
            }];;
        } else {
            [MBProgressHUD hideHUD];
        }
    }];
}

- (void)PL_ProvidenceloginUserProtocolClick {
    PL_ProvidenceWebViewController *webvc = [[PL_ProvidenceWebViewController alloc] init];
    webvc.islocal = YES;
    webvc.gotoURL = [[NSBundle mainBundle] pathForResource:@"PL_Providence_user_protocol" ofType:@"html"];
}

- (void)PL_ProvidenceregisteredButtonClick {
    PL_ProvidenceRegisteredVC *vc = [[PL_ProvidenceRegisteredVC alloc] init];
    vc.modalPresentationStyle = 0;
    vc.title = @"注册";
    vc.type = PL_ProvidenceLoginTypeRegistered;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)PL_ProvidenceforgetButtonClick {
    PL_ProvidenceRegisteredVC *vc = [[PL_ProvidenceRegisteredVC alloc] init];
    vc.modalPresentationStyle = 0;
    vc.title = @"找回密码";
    vc.type = PL_ProvidenceLoginTypeForgetPassword;
    [self presentViewController:vc animated:YES completion:nil];

}

- (IBAction)clickCloseButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
