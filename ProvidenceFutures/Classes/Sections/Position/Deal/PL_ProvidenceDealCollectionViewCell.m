//
//  PL_ProvidenceDealCollectionViewCell.m
//  EvianFutures-OC
//
//  // Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// THE SOFTWARE. on 2019/9/29.
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// THE SOFTWARE. © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceDealCollectionViewCell.h"

@interface PL_ProvidenceDealCollectionViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;

@end

@implementation PL_ProvidenceDealCollectionViewCell

- (void)refreshData:(PL_ProvidenceDealModel *)model indexRow:(NSInteger)row {
    model.priceNow = [model.priceNow stringByReplacingOccurrencesOfString:@"," withString:@""];
    model.avgPrice = [model.avgPrice stringByReplacingOccurrencesOfString:@"," withString:@""];
    if (row == 0) {
        self.mainTitleLabel.text = @"名称/市值";
        self.subTitleLabel.text = model.name;
        self.desTitleLabel.text = [NSString stringWithFormat:@"%.2f",[model.postion floatValue] * [model.priceNow floatValue]];
    } else if (row == 1) {
        self.mainTitleLabel.text = @"持仓盈亏";
        NSString *postion = [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] - [model.avgPrice doubleValue]) * [model.postion doubleValue]];
        NSString *postionRate = [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] *  [model.postion doubleValue]) / ([model.postion doubleValue] * [model.avgPrice doubleValue]) - 1.00] ;
        self.subTitleLabel.text = postion;
        self.desTitleLabel.text = [NSString stringWithFormat:@"%.2f%%",[postionRate doubleValue] * 100];
    } else if (row == 2) {
        self.mainTitleLabel.text = @"持仓可用";
        self.subTitleLabel.text = model.postion;
        self.desTitleLabel.text = model.postion;;
    } else if (row == 3) {
        self.mainTitleLabel.text = @"成本/现价";
        self.subTitleLabel.text = model.avgPrice;
        self.desTitleLabel.text = [NSString stringWithFormat:@"%.2f",[model.priceNow doubleValue]];
    } else if (row == 4) {
        self.mainTitleLabel.text = @"当日盈亏";
        self.subTitleLabel.text = @"";
        
        NSInteger result = [NSString compareDate:model.time withDate:[NSString localStringFromUTCDate:[NSDate date]]];
        if (result == 0) {
            self.desTitleLabel.text = @"----";
        } else {
            self.desTitleLabel.text =  [NSString stringWithFormat:@"%.2f",([model.priceNow doubleValue] - [model.settlement doubleValue]) * [model.postion doubleValue]];
        }
    } 
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor whiteColor];
}

@end
