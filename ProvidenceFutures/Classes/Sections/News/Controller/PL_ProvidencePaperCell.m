//
//  PL_ProvidencePaperCell.m
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

#import "PL_ProvidencePaperCell.h"
#import <UIImageView+WebCache.h>

@interface PL_ProvidencePaperCell ()

@property (nonatomic,strong) IBOutlet UILabel     *newsTitleLabel4;
@property (nonatomic,strong) IBOutlet UILabel     *newsContextLabel4;
@property (nonatomic,strong) IBOutlet  UILabel      *newsTimeLabel4;
@property (nonatomic,strong) IBOutlet UIImageView *newsImg;

@end

@implementation PL_ProvidencePaperCell

#define newsContentFont FontSize_Text_M
#define titleFont  18
#define lineSpace 6
#define textLengthSpace @0.2

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setupUI];
}

- (void)setupUI {

    self.newsTitleLabel4.font = FontSize(titleFont);
    self.newsTitleLabel4.textColor = [UIColor blackColor];
    
    self.newsImg.layer.cornerRadius = 5;
    self.newsImg.layer.masksToBounds = YES;
  
    self.newsTimeLabel4.font = [UIFont systemFontOfSize:12];
    self.newsTimeLabel4.textColor = [UIColor colorWithHexString:@"#666666"];
    self.newsTimeLabel4.numberOfLines = 1;
}

- (void)refreshData:(PL_ProvidencePaperModel *)model {
    self.newsTitleLabel4.text = model.title;
    [self.newsImg sd_setImageWithURL:[NSURL URLWithString:model.image]];
    self.newsTimeLabel4.text = model.date;
}

@end
