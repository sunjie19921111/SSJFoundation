//
//  PL_ProvidenceLineDrawLogic.m
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

#import "PL_ProvidenceLineDrawLogic.h"
#import "DataCenter.h"


@interface PL_ProvidenceLineDrawLogic ()


/**
 准备绘制的元素
 */
@property (strong, nonatomic) NSMutableArray *prepareDrawItem;

/**
 实体线宽度
 */
@property (assign, nonatomic) CGFloat entityLineWidth;

/**
 每个item的宽度
 */
@property (assign, nonatomic) CGFloat perItemWidth;

/**
 最大最小值
 */
@property (assign, nonatomic) GLExtremeValue extremeValue;


@end

@implementation PL_ProvidenceLineDrawLogic

/**
 根据上下文和绘制区域绘制图形
 */
- (void)drawWithCGContext:(CGContextRef)ctx rect:(CGRect)rect indexPathForVisibleRange:(CGPoint)visibleRange scale:(CGFloat)scale otherArguments:(NSDictionary *)arguments {
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count <= 0) {
        return;
    }
    
    // 根据传入的参数更新最大最小值
    [self PL_ProvidenceupdateExtremeValueWithArguments:arguments];
    
    // 实体线宽度
    self.entityLineWidth = [self.config defaultEntityLineWidth] *scale;
    if (self.entityLineWidth > [self.config maxEntityLineWidth]) {
        self.entityLineWidth = [self.config maxEntityLineWidth];
    }else if(self.entityLineWidth < [self.config minEntityLineWidth]) {
        self.entityLineWidth = [self.config minEntityLineWidth];
    }
    // 每个元素的宽度
    self.perItemWidth = (scale * [self.config klineGap]) + self.entityLineWidth;
    // 开始和结束的K线下标 floor()小于visibleRange.x的最大整数
    NSInteger beginItemIndex = floor(visibleRange.x);
    // ceil()大于visibleRange.y的最小整数
    NSInteger endItemIndex = ceil(visibleRange.y);
    if (beginItemIndex < 0) {
        beginItemIndex = 0;
    }
    // 修正最后一个元素下标，防止数组越界
    if (endItemIndex >= [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count) {
        endItemIndex = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
    }
    
    // 更新最大最小值
    [self PL_ProvidenceupdateMinAndMaxValueWithBeginIndex:beginItemIndex endIndex:endItemIndex arguments:arguments];
    
    // 最大最小值的差值
    double diffValue = (self.extremeValue.maxValue - self.extremeValue.minValue) > 0.0 ? (self.extremeValue.maxValue - self.extremeValue.minValue) : 0.0;
    
    if (diffValue <= 0.0) {
        // 没有最大最小值的区分
//        NSAssert(diffValue > 0.0, @"最大值和最小值差值不能为0");
        return;
    }
    
    // 计算绘图的x值
    CGFloat drawX = - (self.perItemWidth * (visibleRange.x - beginItemIndex));
    
    for (NSInteger a = beginItemIndex; a <= endItemIndex; a ++) {
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        // 设置涨跌颜色
        CGColorRef color = (tempModel.open - tempModel.close) >= 0 ? [self.config fallingColor].CGColor : [self.config risingColor].CGColor;
        // 设置画笔颜色
        CGContextSetStrokeColorWithColor(ctx, color);
        // 中心x值
        CGFloat centerX = drawX + (self.perItemWidth / 2.0);
        
        // 实体线
        CGFloat openY = rect.size.height * (1.0f - (tempModel.open - self.extremeValue.minValue) / diffValue) + rect.origin.y ;
        CGFloat closeY = rect.size.height * (1.0f - (tempModel.close - self.extremeValue.minValue) / diffValue) + rect.origin.y;
        if (ABS(closeY - openY) <= 1.0f) {
            closeY = openY + 1.0f;
        }
        
        // 影线
        CGFloat highY = rect.size.height * (1.0f - (tempModel.high - self.extremeValue.minValue) / diffValue) + rect.origin.y;
        CGFloat lowY = rect.size.height * (1.0f - (tempModel.low - self.extremeValue.minValue) / diffValue) + rect.origin.y;
        
        // 绘制实体线
        CGContextSetLineWidth(ctx, self.entityLineWidth);
        CGContextMoveToPoint(ctx, centerX, openY);
        CGContextAddLineToPoint(ctx, centerX, closeY);
        CGContextStrokePath(ctx);
        
        // 绘制影线
        CGContextSetLineWidth(ctx, [self.config hatchLineWidth]);
        CGContextMoveToPoint(ctx, centerX, highY);
        CGContextAddLineToPoint(ctx, centerX, lowY);
        CGContextStrokePath(ctx);
        
        drawX += self.perItemWidth;
    }
}

/**
 根据传入的参数更新最大最小值
 
 @param argu 传入的参数
 */
- (void)PL_ProvidenceupdateExtremeValueWithArguments:(NSDictionary *)argu {
    
    if(argu && [argu isKindOfClass:[NSDictionary class]]) {
        
        NSValue *tempExtremeValue = [argu objectForKey:KlineViewToPL_ProvidenceLineBGDrawLogicExtremeValueKey];
        GLExtremeValue tempValue = [tempExtremeValue PL_ProvidenceextremeValue];
        if (GLExtremeValueEqualToExtremeValue(tempValue, GLExtremeValueZero)) {
            self.extremeValue = GLExtremeValueMake(CGFLOAT_MAX, 0.0f);
        }else {
            self.extremeValue = tempValue;
        }
        
    }
}



- (instancetype)initWithDrawLogicIdentifier:(NSString *)identifier {
    if (self = [super initWithDrawLogicIdentifier:identifier]) {
        [self PL_Providenceinitialize];;
    }
    return self;
}



/**
 获得当前显示区域的最大最小值
 */
- (void)PL_ProvidenceupdateMinAndMaxValueWithBeginIndex:(NSInteger)beginIndex endIndex:(NSInteger)endIndex arguments:(NSDictionary *)arguments {
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count <= 0) {
        return;
    }
    
    if (beginIndex < 0) {
        beginIndex = 0;
    }else if(beginIndex >= [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count) {
        beginIndex = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
    }
    
    if (endIndex < beginIndex) {
        endIndex = beginIndex;
    }
    
    double maxValue = 0.0;
    double minValue = MAXFLOAT;
    
    for (NSInteger a = beginIndex; a <= endIndex; a ++) {
        
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        if (tempModel) {
            if (tempModel.high > maxValue) {
                maxValue = tempModel.high;
            }
            
            if (tempModel.low < minValue) {
                minValue = tempModel.low;
            }
        }
    }
    
    // 调用传入的block，更新视图的最大最小值
    if(arguments) {
        UpdateExtremeValueBlock block = [arguments objectForKey:updateExtremeValueBlockAtDictionaryKey];
        if (block) {
            block(self.drawLogicIdentifier ,minValue,maxValue);
        }
    }
    
    minValue = fmin(minValue, self.extremeValue.minValue);
    maxValue = fmax(maxValue, self.extremeValue.maxValue);
    
    self.extremeValue = GLExtremeValueMake(minValue, maxValue);
}



- (void)PL_Providenceinitialize {
    
    ;
    self.extremeValue = GLExtremeValueMake(CGFLOAT_MAX, 0.0);
}

@end
