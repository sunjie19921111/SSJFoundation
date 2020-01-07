//
//  PL_ProvidenceLineViewConfig.m
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

#import "PL_ProvidenceLineViewConfig.h"

@implementation PL_ProvidenceLineViewConfig


/**
 是否绘制边框
 */
- (BOOL)isHaveBorder {
    
    return YES;
}

/**
 边框宽度
 */
- (CGFloat)borderWidth {
    
    return 0.5f;
}


/**
 实体线的默认宽度
 */
- (CGFloat)defaultEntityLineWidth {
    return 5.0f;
}

/**
 实体线最大宽度
 */
- (CGFloat)maxEntityLineWidth {
    return [self defaultEntityLineWidth] * [self maxPinchScale];
}


/**
 最大的缩放比例
 
 @return 缩放比例最大值
 */
- (CGFloat)maxPinchScale {
    
    return 4.0;
}

/**
 边框颜色
 */
- (UIColor *)borderColor {
    
    return [UIColor colorWithHexString:@"0xB4B4B4"];;
}

/**
 影线宽度
 */
- (CGFloat)hatchLineWidth {

    return 1.0f;
}

/**
 实体线最小宽度
 */
- (CGFloat)minEntityLineWidth {
    
    return [self defaultEntityLineWidth] * [self minPinchScale];
}



/**
 最小的缩放比例
 
 @return 缩放比例的最小值
 */
- (CGFloat)minPinchScale {
    
    return 0.1;
}

/**
 K线之间的间隔宽度
 */
- (CGFloat)klineGap {
    
    return 2.0f;
}

/**
 上涨的颜色
 */
- (UIColor *)risingColor {

//    return HexColor(0x32CE9F);
    return [UIColor colorWithHexString:@"0x50B383"];
}

/**
 下跌的颜色
 */
- (UIColor *)fallingColor {

//    return HexColor(0xF8696B);
    return [UIColor colorWithHexString:@"0xE04A59"];
}

/**
 最小显示k线数量
 */
- (NSInteger)minShowKlineCount {
    
    return 5;
}

/**
 水平分割线的条数
 */
- (NSInteger)horizontalSeparatorCount {
    return 2;
}

/**
 垂直分割线条数
 */
- (NSInteger)verticalSeparatorCount {
    
    return 4;
}

/**
 ma5 线的颜色
 */
- (UIColor *)ma5Color {
    
    return [UIColor colorWithHexString:@"0xB4B4B4"];;
}

/**
 ma10 线的颜色
 */
- (UIColor *)ma10Color {
    return [UIColor colorWithHexString:@"0x195494"];
}

/**
 ma30 线的颜色
 */
- (UIColor *)ma30Color {
    return [UIColor colorWithHexString:@"0xc830ce"];
}

/**
 K线图的内边距
 
 @return 内边距
 */
- (UIEdgeInsets)insertOfKlineView {
    
    CGFloat defaultBorderWidth = [self borderWidth] + 1.0f;
    
    return UIEdgeInsetsMake(defaultBorderWidth, defaultBorderWidth, defaultBorderWidth, defaultBorderWidth);
}

@end
