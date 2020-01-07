//
//  PL_ProvidenceHomeBannerCell.m
//  ProvidenceFutures
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/12/3.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceHomeBannerCell.h"


@implementation PL_ProvidenceHomeBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    NSArray *images = @[@"iPhone_2.jpeg"];
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, ScreenWidth, 200) imageNamesGroup:images];
    _cycleScrollView.titleLabelTextColor = [UIColor redColor];
    [self.contentView addSubview:self.cycleScrollView];
}

@end
