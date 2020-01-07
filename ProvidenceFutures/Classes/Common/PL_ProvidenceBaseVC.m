//
//  PL_ProvidenceDealManager.m
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

#import "PL_ProvidenceBaseVC.h"
#import "PL_ProvidenceEnptyView.h"

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@interface PL_ProvidenceBaseVC ()

@end

@implementation PL_ProvidenceBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self base_setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)base_setupUI {
    _empeyView = [PL_ProvidenceEnptyView emptyView];
    _empeyView.frame = CGRectMake(0, Nav_topH, ScreenWidth, SCREEN_Height-Nav_topH);
    [self.view addSubview:_empeyView];
}



@end
