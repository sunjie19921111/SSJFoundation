//
//  UIView+PL_Providence.h
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
//.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (PL_Providence)

@property (nonatomic) CGFloat left;

/**
 * Shortcut for frame.origin.y
 *
 * Sets frame.origin.y = top
 */
@property (nonatomic) CGFloat top;

/**
 * Shortcut for frame.origin.x + frame.size.width
 *
 * Sets frame.origin.x = right - frame.size.width
 */
@property (nonatomic) CGFloat right;

/**
 * Shortcut for frame.origin.y + frame.size.height
 *
 * Sets frame.origin.y = bottom - frame.size.height
 */
@property (nonatomic) CGFloat bottom;

/**
 * Shortcut for frame.size.width
 *
 * Sets frame.size.width = width
 */
@property (nonatomic) CGFloat width;

/**
 * Shortcut for frame.size.height
 *
 * Sets frame.size.height = height
 */
@property (nonatomic) CGFloat height;

/**
 * Shortcut for center.x
 *
 * Sets center.x = centerX
 */
@property (nonatomic) CGFloat centerX;

/**
 * Shortcut for center.y
 *
 * Sets center.y = centerY
 */
@property (nonatomic) CGFloat centerY;
/**
 * Shortcut for frame.origin
 */
@property (nonatomic) CGPoint origin;

/**
 * Shortcut for frame.size
 */
@property (nonatomic) CGSize size;

//找到自己的vc
- (UIViewController *)viewController;


@end


@interface UIView (NTESPresent)

//弹出一个类似present效果的窗口
- (void)presentView:(UIView*)view animated:(BOOL)animated complete:(void(^)(void)) complete;

//获取一个view上正在被present的view
- (UIView *)presentedView;

- (void)dismissPresentedView:(BOOL)animated complete:(void(^)(void)) complete;

//这个是被present的窗口本身的方法
//如果自己是被present出来的，消失掉
- (void)hideSelf:(BOOL)animated complete:(void(^)(void)) complete;

/**
 loading 视图
 */
@property (nullable, readwrite, strong, nonatomic) UIActivityIndicatorView *loadingView;

/**
 开始动画
 */
- (void)startAnimating;

/**
 开始动画
 
 @param offset 动画距离中心点的偏移量
 */
- (void)startAnimatingWithOffset:(CGPoint)offset;

/**
 开始动画
 
 @param center loading图的中心点
 */
- (void)startAnimatingWithCenter:(CGPoint)center;

/**
 开始动画
 
 @param offset 动画距离中心点的偏移量
 @param style loading动画的样式
 */
- (void)startAnimatingWithOffset:(CGPoint)offset activityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style;

/**
 开始动画
 
 @param center 动画中心点
 @param style loading动画的样式
 */
- (void)startAnimatingWithCenter:(CGPoint)center activityIndicatorViewStyle:(UIActivityIndicatorViewStyle)style;

/**
 结束动画
 */
- (void)stopAnimating;


@end

NS_ASSUME_NONNULL_END
