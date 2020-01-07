//
//  PL_ProvidenceHomeOptionView.h
//  kkcoin
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// walker on 2018/8/15.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PL_ProvidenceHomeOptionView;

@protocol PL_ProvidenceMainSelectedViewProtocol<NSObject>

@required

- (void)selectedView:(PL_ProvidenceHomeOptionView *)selectedView selectedItemTitle:(NSString *)title indexPath:(NSIndexPath *)indexPath;

@end

@interface PL_ProvidenceHomeOptionView : UIView


- (instancetype)initWithFrame:(CGRect)frame itemsTitles:(NSArray <NSString *>*)titles;

- (void)setItemSelectedState:(BOOL)isSelected atIndexPath:(NSIndexPath *)indexPath;

@property (strong, nonatomic) id <PL_ProvidenceMainSelectedViewProtocol> delegate;



@end
