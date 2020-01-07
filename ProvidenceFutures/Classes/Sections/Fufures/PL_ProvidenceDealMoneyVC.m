//
//  PL_ProvidenceDealMoneyVC.m
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
//2019/9/29.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceDealMoneyVC.h"

@interface PL_ProvidenceDealMoneyVC ()

@property (weak, nonatomic) IBOutlet UITextField *textFiled;
@property (weak, nonatomic) IBOutlet UIButton *subitButton;

@end

@implementation PL_ProvidenceDealMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.subitButton.backgroundColor = kMainColor;
    
    self.navigationItem.title = @"申请积分";
}

- (IBAction)clickSureButton:(id)sender {
    PL_ProvidenceDealData *moneyModel =  k_MoneyManagerModel;
    moneyModel.totalIntegral = [NSString stringWithFormat:@"%ld",[moneyModel.totalIntegral integerValue] + [self.textFiled.text integerValue]];
    k_MoneyManagerModel = moneyModel;
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
