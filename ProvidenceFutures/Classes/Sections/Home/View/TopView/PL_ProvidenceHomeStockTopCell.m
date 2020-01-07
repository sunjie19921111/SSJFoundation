//
//  PL_ProvidenceHomeStockTopCell.m
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
//2019/9/27.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceHomeStockTopCell.h"

@interface PL_ProvidenceHomeStockTopCell ()

@property (weak, nonatomic) IBOutlet UILabel *mainTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *desTitleLabel;

@end

@implementation PL_ProvidenceHomeStockTopCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    _mainTitleLabel.textColor = [UIColor blackColor];
    _mainTitleLabel.font = UiFontIPH(30);
    _subTitleLabel.textColor = [UIColor redColor];
    _subTitleLabel.font = [UIFont boldSystemFontOfSize:IPHONEWIDTH(38)];
    _desTitleLabel.textColor = [UIColor colorWithRed:243/255.0 green:104/255.0 blue:25/255.0 alpha:1/1.0];
    _desTitleLabel.font = UiFontIPH(23);
}

- (void)refreshData:(PL_ProvidenceHomeStockTopModel *)model {
    _mainTitleLabel.text = model.name;
    _subTitleLabel.text = model.high_pri;
    _desTitleLabel.text = [NSString stringWithFormat:@"%@[%@%%]",model.increase,model.incre_per];
}

@end
