//
//  KLineViewProtocol.h
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

/* 对KLineView的配置 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@protocol KLineViewProtocol <NSObject>
@required

/**
 最大的缩放比例

 @return 缩放比例最大值
 */
- (CGFloat)maxPinchScale;

/**
 最小的缩放比例

 @return 缩放比例的最小值
 */
- (CGFloat)minPinchScale;

/**
 K线之间的间隔宽度
 */
- (CGFloat)klineGap;


/**
 水平分割线的条数
 */
- (NSInteger)horizontalSeparatorCount;

/**
 垂直分割线条数
 */
- (NSInteger)verticalSeparatorCount;

/**
 ma5 线的颜色
 */
- (UIColor *)ma5Color;

/**
 ma10 线的颜色
 */
- (UIColor *)ma10Color;

/**
 ma30 线的颜色
 */
- (UIColor *)ma30Color;

/**
 K线图的内边距
 
 @return 内边距
 */
- (UIEdgeInsets)insertOfKlineView;

/**
 是否绘制边框
 */
- (BOOL)isHaveBorder;

/**
 边框宽度
 */
- (CGFloat)borderWidth;

/**
 边框颜色
 */
- (UIColor *)borderColor;

/**
 影线宽度
 */
- (CGFloat)hatchLineWidth;

/**
 实体线最小宽度
 */
- (CGFloat)minEntityLineWidth;

/**
 实体线的默认宽度
 */
- (CGFloat)defaultEntityLineWidth;

/**
 实体线最大宽度
 */
- (CGFloat)maxEntityLineWidth;


/**
 上涨的颜色
 */
- (UIColor *)risingColor;

/**
 下跌的颜色
 */
- (UIColor *)fallingColor;

/**
 最小显示k线数量
 */
- (NSInteger)minShowKlineCount;


@end
