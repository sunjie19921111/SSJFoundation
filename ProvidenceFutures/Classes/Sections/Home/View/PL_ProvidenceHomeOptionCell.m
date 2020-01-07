//
//  PL_ProvidenceHomeOptionCell.m
//  kkcoin
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// walker on 2018/8/15.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "PL_ProvidenceHomeOptionCell.h"

@implementation PL_ProvidenceHomeOptionCell

- (void)prepareForReuse {
    self.cellLabel.text = @"";
    [self setIsSelected:NO];
}

#pragma mark - 私有方法 --

- (void)PL_Providenceinitialize {
    self.contentView.backgroundColor = [UIColor darkGrayColor];
    
}

- (void)PL_ProvidenceconfigUI {
    
    [self.contentView addSubview:self.cellLabel];
    
    [self PL_ProvidencelayoutWithMasonry];
}

- (void)PL_ProvidencelayoutWithMasonry {
    
    [self.cellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left);
        make.right.equalTo(self.contentView.mas_right);
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom);
    }];
}

#pragma mark - 公共方法 --

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    
    if (_isSelected) {
        
        _cellLabel.layer.borderColor = [UIColor colorWithHexString:@"0x4299FF"].CGColor;
        _cellLabel.textColor = [UIColor colorWithHexString:@"0x4299FF"];
    }else {
        
        _cellLabel.layer.borderColor = [UIColor colorWithHexString:@"0xeeeeee"].CGColor;
        _cellLabel.textColor = [UIColor colorWithHexString:@"0xB4B4B4"];
    }
}

#pragma mark - 懒加载 --

- (UILabel *)cellLabel {
    if(!_cellLabel) {
        _cellLabel = [[UILabel alloc] init];
        _cellLabel.userInteractionEnabled = YES;
        _cellLabel.backgroundColor = [UIColor colorWithHexString:@"0xF8F8F8"];
        _cellLabel.textColor = [UIColor colorWithHexString:@"0xB4B4B4"];
        _cellLabel.textAlignment = NSTextAlignmentCenter;
        _cellLabel.font = [UIFont PL_ProvidencesystemFontOfSize:15.0f];
        _cellLabel.layer.borderColor = [UIColor colorWithHexString:@"0xeeeeee"].CGColor;
        _cellLabel.layer.borderWidth = 1.0f;
    }
    return _cellLabel;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self PL_Providenceinitialize];;
        
        [self PL_ProvidenceconfigUI];
    }
    return self;
}


@end
