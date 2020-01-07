//
//  PL_ProvidenceLineVolViewConfig.m
//  GLKLineKit
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
//  Copyright © 2018年 walker. All rights reserved.
//

#import "PL_ProvidenceLineVolViewConfig.h"

@implementation PL_ProvidenceLineVolViewConfig



/**
 上涨的颜色
 */
- (UIColor *)risingColor {
    
    return [UIColor colorWithHexString:@"0x50B383"];
}

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
 边框颜色
 */
- (UIColor *)borderColor {
    
    return [UIColor colorWithHexString:@"0xB4B4B4"];;
}


/**
 水平分割线的条数
 */
- (NSInteger)horizontalSeparatorCount {
    return 1;
}

/**
 垂直分割线条数
 */
- (NSInteger)verticalSeparatorCount {
    
    return 4;
}


/**
 下跌的颜色
 */
- (UIColor *)fallingColor {
    
    return [UIColor colorWithHexString:@"0xE04A59"];
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
