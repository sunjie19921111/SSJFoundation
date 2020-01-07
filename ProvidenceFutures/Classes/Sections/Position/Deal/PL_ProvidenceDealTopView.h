//
//  PL_ProvidenceDealTopView.h
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

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceDealTopView : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *totalValue;
@property (weak, nonatomic) IBOutlet UILabel *dyValue;
@property (weak, nonatomic) IBOutlet UILabel *totalYk;

- (void)refresh;

@end

NS_ASSUME_NONNULL_END
