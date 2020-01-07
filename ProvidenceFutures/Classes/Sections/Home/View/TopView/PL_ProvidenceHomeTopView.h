//
//  PL_ProvidenceHomeTopView.h
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

#import <UIKit/UIKit.h>



@protocol HomeTopViewClickCellDelegate <NSObject>

- (void)topViewClickdidSelectItemAtIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeTopView : UIView

@property (nonatomic, weak) id<HomeTopViewClickCellDelegate>delegate;

- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
