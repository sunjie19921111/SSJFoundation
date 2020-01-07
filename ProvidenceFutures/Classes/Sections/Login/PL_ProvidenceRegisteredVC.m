//
//  RMS_RegisteredViewController.m
//  ThinkThink_oc
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// apple  on 2019/8/8.
//  Copyright © 2019 apple . All rights reserved.
//

#import "PL_ProvidenceRegisteredVC.h"

@interface PL_ProvidenceRegisteredVC ()


@property (nonatomic, assign) NSInteger time;

@property (nonatomic, strong) NSTimer *timers;
@property (weak, nonatomic) IBOutlet UILabel *PL_ProvidencetitleLabel;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *code;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
@property (weak, nonatomic) IBOutlet UIButton *registeredButton;


@end

@implementation PL_ProvidenceRegisteredVC



- (IBAction)clickRegisteredButton:(UIButton *)sender {
    if (self.type == PL_ProvidenceLoginTypeRegistered) {
        [self loadRegistered];
    } else {
        [self loadForgetPassword];
    }
}

- (IBAction)clickBackButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden = YES;
    [self setupUI];

}



- (void)loadRegistered {
    NSString *code = self.code.text;
    NSString *userName = self.phone.text;
    NSString *password = self.password.text;
    if (code.length != 6) {
        [MBProgressHUD showError:@"请输入正确的验证码"]; return;
    }
    
    if (userName.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号"]; return;
    }
    
    if (password.length < 6) {
        [MBProgressHUD showError:@"请设置6位数以上的密码"]; return;
    }
   
    NSDictionary *parameter = @{
                                @"type" : @(1),
                                @"registerStr" : userName,
                                @"pass" : password,
                                @"code" : code,
                                @"userName" : userName,
                                @"source" : @"5",
                                @"belong" : @"1"
                                };
    [PL_ProvidenceHttpRequest post:PL_ProvidenceREGISTER_URL params:parameter complete:^(id result, NSError *error, NSURLSessionDataTask *task) {
        if (!error) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (void)loadForgetPassword {
    NSString *code = self.code.text;
    NSString *userName = self.phone.text;
    NSString *password = self.password.text;
    if (code.length != 6) {
        [MBProgressHUD showError:@"请输入正确的验证码"]; return;
    }
    
    if (userName.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号"]; return;
    }
    
    if (password.length < 6) {
        [MBProgressHUD showError:@"请设置6位数以上的密码"]; return;
    }
    
    NSDictionary *parameter = @{
                                @"type":@(1),
                                @"registerStr":userName,
                                @"pass":password,
                                @"code":code
                                };
    [PL_ProvidenceHttpRequest post:PL_ProvidenceFIND_PASSWORD_URL  params:parameter complete:^(id result, NSError *error, NSURLSessionDataTask *task) {
        if (!error) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

- (IBAction)loginClickButton:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (IBAction)codeClickButton:(id)sender {
    if (self.phone.text.length != 11) {
        [MBProgressHUD showError:@"请输入正确的手机号码"]; return;
    }
     [self beginTimer];
    NSDictionary *params = @{@"type":@(self.type),@"phoneNum":self.phone.text};
    [PL_ProvidenceHttpRequest post:PL_ProvidenceGET_CHECK_CODE_PHONE params:params complete:^(id result, NSError *error, NSURLSessionDataTask *task) {
        if (!error) {
            [self beginTimer];
        }
    }];
}

- (void)beginTimer {
    self.timers = [NSTimer timerWithTimeInterval:60 target:self selector:@selector(timerAction:) userInfo:nil repeats:YES];

}

- (void)timerInvalidate {
    [self.timers invalidate];
    self.timers = nil;
}

- (void)timerAction:(NSTimer *)timer {
    self.codeButton.enabled = NO;
    [self.codeButton setTitle:[NSString stringWithFormat:@"%ld",self.time] forState:UIControlStateNormal];
    if (self.time == 0) {
        self.codeButton.enabled = YES;
        [self.codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        [self timerInvalidate]; return;
    }
    self.time --;
}

- (void)setupUI {
    self.time = 60;
    
    if (self.type == PL_ProvidenceLoginTypeRegistered) {
        [self.registeredButton setTitle:@"注 册" forState:UIControlStateNormal];
    } else if (self.type == PL_ProvidenceLoginTypeForgetPassword) {
        [self.registeredButton setTitle:@"确 定" forState:UIControlStateNormal];
    }
        self.PL_ProvidencetitleLabel.text = @"Hello!\n欢迎使用亿元期货";
}

@end
