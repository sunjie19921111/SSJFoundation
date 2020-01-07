//
//  PL_ProvidenceSettingAgreeVC.m
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

#import "PL_ProvidenceSettingAgreeVC.h"
#import <WebKit/WebKit.h>
#import "PL_ProvidenceWebViewController.h"

@interface PL_ProvidenceSettingAgreeVC ()

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation PL_ProvidenceSettingAgreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"用户协议";
    
    PL_ProvidenceWebViewController *webvc = [[PL_ProvidenceWebViewController alloc] init];
    webvc.islocal = YES;
    webvc.gotoURL = [[NSBundle mainBundle] pathForResource:@"PL_Providence_user_protocol" ofType:@"html"];
    [self addChildViewController:webvc];
    [self.view addSubview:webvc.view];

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
