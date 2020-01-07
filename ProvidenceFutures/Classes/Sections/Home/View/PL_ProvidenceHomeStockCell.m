//
//  PL_ProvidenceHomeStockCell.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceHomeStockCell.h"
#import "PL_ProvidenceHomeStockModel.h"
@interface PL_ProvidenceHomeStockCell ()

@property(nonatomic,assign) CGRect subNameFrame;

@property(nonatomic,assign) CGRect subContentFrame;

@property(nonatomic,assign) CGRect subTimeFrame;

@property (strong, nonatomic) UILabel *titleLabel;

@property (strong, nonatomic) UILabel *codeLabel;

@property (strong, nonatomic) UILabel *tradeLabel;

@property (strong, nonatomic) UIButton *priceChangePercent;

@property (strong, nonatomic) UIView *lineView;

@property (strong, nonatomic) PL_ProvidenceHomeStockModel *model;

@property (strong, nonatomic) NSIndexPath *indexPath;

@end

@implementation PL_ProvidenceHomeStockCell


- (UILabel *)tradeLabel {
    if (!_tradeLabel) {
        _tradeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tradeLabel.font = [UIFont fontWithName:fFont size:15.0f];
        _tradeLabel.textColor = [UIColor colorWithHexString:@"0x666666"];
    }
    return _tradeLabel;
}

- (UIButton *)priceChangePercent {
    if (!_priceChangePercent) {
        _priceChangePercent = [[UIButton alloc] initWithFrame:CGRectZero];
//        _priceChangePercent.backgroundColor = [UIColor colorWithHexString:@"0xcccccc"];
        _priceChangePercent.layer.cornerRadius = SCALE_Length(5.0f);
        _priceChangePercent.layer.masksToBounds = YES;
    }
    return _priceChangePercent;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [[UIView alloc] initWithFrame:CGRectZero];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"0xeeeeee"];
    }
    return _lineView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)updateWithDataModel:(PL_ProvidenceHomeStockModel *)model indexPath:(NSIndexPath *)index {
    
    if (model) {
        self.model = model;
    }
    
    if (index) {
        self.indexPath = index;
    }
    
    [self PL_ProvidenceupdateData];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self PL_Providenceinitialize];;
        
        [self PL_ProvidenceconfigUI];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    
    self.titleLabel.text = @"--";
    self.codeLabel.text = @"--";
    self.tradeLabel.text = @"--";
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self.priceChangePercent setTitle:@"-%" forState:UIControlStateNormal];
}

- (void)PL_Providenceinitialize {
    
    self.titleLabel.text = @"--";
    self.codeLabel.text = @"--";
    self.tradeLabel.text = @"--";
    
    [self.priceChangePercent setTitle:@"-%" forState:UIControlStateNormal];
    
    self.backgroundColor = [UIColor whiteColor];
}

- (void)PL_ProvidenceconfigUI {
    
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.codeLabel];
    [self.contentView addSubview:self.tradeLabel];
    [self.contentView addSubview:self.priceChangePercent];
    [self.contentView addSubview:self.lineView];
    
    [self PL_ProvidencelayoutWithMasonry];
}

- (void)PL_ProvidencelayoutWithMasonry {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCALE_Length(10.0f));
        make.top.equalTo(self.contentView.mas_top).offset(SCALE_Length(10.0f));
        make.width.mas_equalTo(SCALE_Length(160.0f));
    }];
    
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCALE_Length(10.0f));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(SCALE_Length(5.0f));
    }];
    
    [self.tradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCALE_Length(180.0f));
        make.centerY.equalTo(self.contentView.mas_centerY);
    }];
    
    [self.priceChangePercent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(SCALE_Length(- 10.0f));
        make.centerY.equalTo(self.contentView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(SCALE_Length(80.0f), SCALE_Length(30.0f)));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(SCALE_Length(10.0f));
        make.right.equalTo(self.contentView.mas_right);
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.height.mas_equalTo(1.0f);
    }];
}

- (void)PL_ProvidenceupdateData {
    
    if (self.model) {
        self.titleLabel.text = self.model.name;
        self.codeLabel.text = self.model.code;
        self.tradeLabel.text = [NSString PL_ProvidencefixNumString:self.model.trade minDecimalsLimit:2 maxDecimalsLimit:2];


        NSString *percent = [NSString PL_ProvidencefixNumString:self.model.changepercent minDecimalsLimit:2 maxDecimalsLimit:2];
        [self.priceChangePercent setTitle:[NSString stringWithFormat:@"%@%%",percent] forState:UIControlStateNormal];
        NSDecimalNumber *change = [self.model.changepercent PL_ProvidencedigitalValue];
        NSComparisonResult result = [change compare:@(0)];
        [self.priceChangePercent setTitleColor:[UIColor colorWithHexString:@"0x333333"] forState:UIControlStateNormal];

        if (result == NSOrderedAscending) {
            // 小于0
            [self.priceChangePercent setBackgroundColor:[UIColor colorWithHexString:@"0xE04A59"]];
        }else if(result == NSOrderedDescending){
            // 大于0
            [self.priceChangePercent setBackgroundColor:[UIColor colorWithHexString:@"0x50B383"]];

        }else {
            [self.priceChangePercent setBackgroundColor:[UIColor colorWithHexString:@"0xcccccc"]];

        }
    }
}

#pragma mark - lazy load --

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.font = [UIFont fontWithName:fFont size:15.0f];
        _titleLabel.textColor = [UIColor colorWithHexString:@"0x333333"];
    }
    return _titleLabel;
}

- (UILabel *)codeLabel {
    if (!_codeLabel) {
        _codeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _codeLabel.font = [UIFont fontWithName:fFont size:12.0f];
        _codeLabel.textColor = [UIColor colorWithHexString:@"0xB4B4B4"];
    }
    return _codeLabel;
}

@end
