//
//  PL_ProvidenceDealTopCell.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceDealTopCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *moneyButton;

- (void)refreshData:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
