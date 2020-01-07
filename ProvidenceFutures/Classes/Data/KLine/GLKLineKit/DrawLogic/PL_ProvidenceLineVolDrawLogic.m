//
//  PL_ProvidenceLineVolDrawLogic.m
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
#import "NSNumber+StringFormatter.h"
#import "PL_ProvidenceLineVolDrawLogic.h"
#import "DataCenter.h"

@interface PL_ProvidenceLineVolDrawLogic ()


/**
 K线实体线宽度
 */
@property (assign, nonatomic) CGFloat entityLineWidth;
/**
 最大值最小值
 */
@property (assign, nonatomic) GLExtremeValue extremeValue;

/**
 每个item的宽度
 */
@property (assign, nonatomic) CGFloat perItemWidth;





@end

@implementation PL_ProvidenceLineVolDrawLogic


/**
 根据传入的参数更新最大最小值
 
 @param argu 传入的参数
 */
- (void)PL_ProvidenceupdateExtremeValueWithArguments:(NSDictionary *)argu {
    
    if(argu && [argu isKindOfClass:[NSDictionary class]]) {
        
        NSValue *tempExtremeValue = [argu objectForKey:KlineViewToPL_ProvidenceLineBGDrawLogicExtremeValueKey];
        
        self.extremeValue = [tempExtremeValue PL_ProvidenceextremeValue];
    }
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
    //    double minValue = MAXFLOAT;
    double minValue = 0.0f;
    
    for (NSInteger a = beginIndex; a <= endIndex; a ++) {
        
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        if (tempModel) {
            if (tempModel.volume > maxValue) {
                maxValue = tempModel.volume;
            }
            
            //            if (tempModel.volume < minValue) {
            //                minValue = tempModel.volume;
            //            }
        }
    }
    
    // 调用传入的block，更新视图的最大最小值
    if(arguments) {
        UpdateExtremeValueBlock block = [arguments objectForKey:updateExtremeValueBlockAtDictionaryKey];
        if (block) {
            block(self.drawLogicIdentifier ,minValue,maxValue);
        }
    }
    
//    minValue = fmin(minValue, self.extremeValue.minValue);
    minValue = 0.0f;
    maxValue = fmax(maxValue, self.extremeValue.maxValue);
    
    self.extremeValue = GLExtremeValueMake(minValue, maxValue);
}

- (instancetype)initWithDrawLogicIdentifier:(NSString *)identifier {
    if (self = [super initWithDrawLogicIdentifier:identifier]) {
        [self PL_Providenceinitialize];;
    }
    return self;
}



- (void)PL_Providenceinitialize {
    
    ;
    self.extremeValue = GLExtremeValueZero;
}



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
    
    // 开始和结束的K线下标
    NSInteger beginItemIndex = floor(visibleRange.x);
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
        CGFloat startPointY = rect.size.height * (1.0f - (tempModel.volume - self.extremeValue.minValue) / diffValue) + rect.origin.y ;
        CGFloat endPointY = rect.size.height + rect.origin.y;
        if (startPointY == endPointY) {
            endPointY = startPointY + 1.0f;
        }
        
        // 绘制实体线
        CGContextSetLineWidth(ctx, self.entityLineWidth);
        CGContextMoveToPoint(ctx, centerX, startPointY);
        CGContextAddLineToPoint(ctx, centerX, endPointY);
        CGContextStrokePath(ctx);
        
        drawX += self.perItemWidth;
    }
    
}



@end
