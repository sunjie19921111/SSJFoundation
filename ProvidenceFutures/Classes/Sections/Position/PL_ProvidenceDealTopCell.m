//
//  PL_ProvidenceDealTopCell.m
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
//2019/9/28.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceDealTopCell.h"

@interface PL_ProvidenceDealTopCell ()

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;


@end

@implementation PL_ProvidenceDealTopCell


-(void)refreshData:(NSDictionary *)dic {
    if ([dic[@"title"] isEqualToString:@"申请积分"]) {
        self.moneyButton.hidden = NO;
        self.mainLabel.hidden = self.desLabel.hidden = YES;
    } else {
        self.moneyButton.hidden = YES;
        self.mainLabel.hidden = self.desLabel.hidden = NO;
    }
    
    self.mainLabel.text = dic[@"title"];
    self.desLabel.text = dic[@"des"];
}

@end
