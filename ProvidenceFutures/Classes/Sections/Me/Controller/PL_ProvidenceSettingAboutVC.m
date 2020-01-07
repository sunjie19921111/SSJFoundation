//
//  PL_ProvidenceSettingAboutVC.m
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


#import "PL_ProvidenceSettingAboutVC.h"

@interface PL_ProvidenceSettingAboutVC ()

@property (weak, nonatomic) IBOutlet UIImageView *pf_img;
@property (weak, nonatomic) IBOutlet UILabel *pf_versionLabel;

@property (weak, nonatomic) IBOutlet UIButton *versionButton;

@end

@implementation PL_ProvidenceSettingAboutVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.pf_versionLabel.text = [NSString stringWithFormat:@"%@",k_AppVersion];
    self.versionButton.backgroundColor = kMainColor;
    
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
