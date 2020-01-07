//
//  PL_ProvidenceBaseListView.h
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeBaseView : UIView

- (void)updateIdentifier:(NSString *)identifier NS_REQUIRES_SUPER;

- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

- (instancetype)init NS_UNAVAILABLE;


- (void)reloadNewData NS_REQUIRES_SUPER;


@property (readonly, strong, nonatomic) NSString *identifier;

- (instancetype)initWithFrame:(CGRect)frame identifier:(NSString *)identifier NS_REQUIRES_SUPER;

@end

NS_ASSUME_NONNULL_END
