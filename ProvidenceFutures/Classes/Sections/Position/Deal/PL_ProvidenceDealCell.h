//
//  PL_ProvidenceDealCell.h
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

#import <UIKit/UIKit.h>
#import "PL_ProvidenceDealModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceDealCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *dyYkLabel;
@property (weak, nonatomic) IBOutlet UILabel *dyAvailableLabel;
@property (weak, nonatomic) IBOutlet UILabel *nowPrice;

@property (nonatomic, strong) PL_ProvidenceDealModel *model;

@end

NS_ASSUME_NONNULL_END
