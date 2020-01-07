//
//  PL_ProvidenceLineDataLogic.h
//  KLineDemo
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//  //
//
//  Created by Journey on 2019/11/30.
//
//.
//




/* K线视图手势事件变化的逻辑处理 */
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PL_ProvidenceZSHKLineView.h"


@protocol PL_ProvidenceLineDataLogicProtocol <NSObject>
@required

#pragma mark - K线绘图相关 ---
/**
 可见区域已经改变

 @param visibleRange 改变后的可见区域
 @param scale 当前的scale
 */
- (void)visibleRangeDidChanged:(CGPoint)visibleRange scale:(CGFloat)scale;

#pragma mark - 十字线相关 ----

/**
 十字线的显示状态
 
 @param isShow 是否显示
 */
- (void)reticleIsShow:(BOOL)isShow;





@optional

/**
 KLineView 上触点移动的回调方法(十字线移动)
 
 @param view 触点起始的View
 @param point point 点击的点
 @param index index 当前触点所在item的下标
 */
- (void)klineView:(PL_ProvidenceZSHKLineView *)view didMoveToPoint:(CGPoint)point selectedItemIndex:(NSInteger)index;

@end

@interface PL_ProvidenceLineDataLogic : NSObject

#pragma mark - 禁用方法 --

- (instancetype)init NS_UNAVAILABLE;

/**
 添加代理
 
 @param delegate 遵循<PL_ProvidenceLineDataLogicProtocol>协议的代理
 支持多代理模式，但是要记得移除，否则会造成多次调用
 */
- (void)addDelegate:(id<PL_ProvidenceLineDataLogicProtocol>_Nonnull)delegate;

/**
 移除代理
 
 @param delegate 遵循<PL_ProvidenceLineDataLogicProtocol>协议的代理
 */
- (void)removeDelegate:(id<PL_ProvidenceLineDataLogicProtocol>_Nonnull)delegate;

/**
 初始化方法
 备注：初始化时要传入初始化时的visibleRange,否则计算有错误
 @param visibleRange 当前的visibleRange
 @param perItemWidth 默认的元素宽度
 */
- (instancetype)initWithVisibleRange:(CGPoint)visibleRange perItemWidth:(CGFloat)perItemWidth NS_DESIGNATED_INITIALIZER;

/**
 当前显示的范围
 */
@property (readonly, assign, nonatomic) CGPoint visibleRange;

/**
 最小显示K线数量
 */
@property (assign, nonatomic) NSInteger minKlineCount;

/**
 因为一些其他原因更新当前显示的区域，比如视图的frame变化
 */
- (void)updateVisibleRange:(CGPoint)visibleRange;

/**
 根据偏移量计算当前可显示的区域

 算法：  offsetItem = offsetX / perItemWidth;
        newVisibleRange = {x + offsetItem , y + offsetItem};
 
 @param offsetX 偏移量
 @param perItemWidth 每个元素的宽度
 */
- (void)updateVisibleRangeWithOffsetX:(CGFloat)offsetX perItemWidth:(CGFloat)perItemWidth;

/**
 根据缩放中心点位置计算当前可显示的区域
 
 算法：  itemCount = ((y - x) * perItemWidth1 / perItemWidth2);
        new_x = (itemCount * centerPercent) + x;
        new_y = new_x + itemCount;
 
 @param percent 缩放中心点在k线图的位置 (0.0f ~ 1.0f)
 @param perItemWidth 每个元素的宽度
 @param scale 当前缩放比例
 */
- (void)updateVisibleRangeWithZoomCenterPercent:(CGFloat)percent perItemWidth:(CGFloat)perItemWidth scale:(CGFloat)scale;

#pragma mark - 十字线相关 ----

/**
 KLineView的点击手势 (将要出现十字线)

 @param view KLineView
 @param point 触点的位置
 @param perItemWidth 当前的Item宽度
 */
- (void)beginTapKLineView:(PL_ProvidenceZSHKLineView *)view touchPoint:(CGPoint)point perItemWidth:(CGFloat)perItemWidth;

/**
 手指在KLineView上移动 (十字线将要移动)

 @param view KLineView
 @param point 触点的位置
 @param perItemWidth 当前的item宽度
 */
- (void)moveTouchAtKLineView:(PL_ProvidenceZSHKLineView *)view touchPoint:(CGPoint)point perItemWidth:(CGFloat)perItemWidth;

/**
 取消当前的显示状态 (十字线将要隐藏)

 @param view KLineView
 @param point 触点的位置
 @param perItemWidth 当前的Item宽度
 */
- (void)removeTouchAtKLineView:(PL_ProvidenceZSHKLineView *)view touchPoint:(CGPoint)point perItemWidth:(CGFloat)perItemWidth;


@end
