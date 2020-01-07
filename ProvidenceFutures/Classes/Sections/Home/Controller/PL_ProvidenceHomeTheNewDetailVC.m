//
//  PL_ProvidenceHomeTheNewDetailVC.m
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
//2019/11/8.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceHomeTheNewDetailVC.h"
#import <SDWebImage.h>

@interface PL_ProvidenceHomeTheNewDetailVC ()

@property (nonatomic, strong) UITextView *PL_ProvidencetextView;
@property (nonatomic, strong) UIImageView *PL_Providenceimg;

@end

@implementation PL_ProvidenceHomeTheNewDetailVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupUI];
    [self getInfo];
}

- (void)getInfo {
    [PL_ProvidenceHttpRequest getWithURL:@"http://149.28.12.15:8080/gp/manual/get_one" params:@{@"m_id":self.m_id} completion:^(NSError *error, id responseObject) {
        if (!error) {
            self.PL_ProvidencetextView.text = responseObject[@"retData"][@"content"];
            [self.PL_Providenceimg sd_setImageWithURL:[NSURL URLWithString:responseObject[@"retData"][@"img"]]];
        }
    }];
}

- (void)setupUI {
    
    _PL_Providenceimg = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10 + Nav_topH, ScreenWidth - 20, (ScreenWidth - 20) * 9 / 16)];
    [self.view addSubview:_PL_Providenceimg];
    
    _PL_ProvidencetextView = [[UITextView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(_PL_Providenceimg.frame) + 10, ScreenWidth-20, self.view.height - CGRectGetMaxY(_PL_Providenceimg.frame) - 10)];
    _PL_ProvidencetextView.font = [UIFont systemFontOfSize:16];
//    _textView.numberOfLines = 0;
    _PL_ProvidencetextView.textColor = [UIColor colorWithHexString:@"#333333"];
    [self.view addSubview:_PL_ProvidencetextView];
    
}



@end
