//
//  PL_ProvidenceSettingTickVC.m
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

#import "PL_ProvidenceSettingTickVC.h"

@interface PL_ProvidenceSettingTickVC ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;


@end

@implementation PL_ProvidenceSettingTickVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.textView.layer.cornerRadius = 10;
    self.textView.layer.masksToBounds = YES;
    
    self.textView.layer.borderColor = [UIColor colorWithHexString:@"#999999"].CGColor;
    self.textView.layer.borderWidth = 1;
    
    self.textView.placeholder = @"请输入意见反馈";
    
    self.saveButton.backgroundColor = kMainColor;
    
    [self.saveButton addTarget:self action:@selector(clickSaveButton) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickSaveButton {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.15 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.navigationController popViewControllerAnimated:YES];
    });
}

@end
