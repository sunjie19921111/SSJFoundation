//
//  PL_ProvidenceLineRSIDrawLogic.m
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


#import "PL_ProvidenceLineRSIDrawLogic.h"
#import "DataCenter.h"


@interface PL_ProvidenceLineRSIDrawLogic ()

/**
 RSI24点的集合
 */
@property (strong, nonatomic) NSMutableArray *rsi24PointArray;

/**
 选中的模型
 */
@property (strong, nonatomic) PL_ProvidenceKLineModel *selectedModel;

/**
 最大值最小值
 */
@property (assign, nonatomic) GLExtremeValue extremeValue;

/**
 每个item的宽度
 */
@property (assign, nonatomic) CGFloat perItemWidth;

/**
 RSI6点的集合
 */
@property (strong, nonatomic) NSMutableArray *rsi6PointArray;

/**
 RSI12点的集合
 */
@property (strong, nonatomic) NSMutableArray *rsi12PointArray;



/**
 平均线宽度
 */
@property (assign, nonatomic) CGFloat lineWidth;

/**
 K线实体线宽度
 */
@property (assign, nonatomic) CGFloat entityLineWidth;


@end

@implementation PL_ProvidenceLineRSIDrawLogic
- (instancetype)initWithDrawLogicIdentifier:(NSString *)identifier {
    if (self = [super initWithDrawLogicIdentifier:identifier]) {
        [self PL_Providenceinitialize];;
    }
    return self;
}



- (void)PL_Providenceinitialize {
    
    ;
    
    self.lineWidth = 1.0f;
    
    NSLog(@"RSI data prepare begin");
    if(![[DataCenter shareCenter] isPrepareForDataType:IndicatorsDataTypeRSI]){
        [[DataCenter shareCenter] prepareDataWithType:IndicatorsDataTypeRSI fromIndex:0];
        NSLog(@"RSI data prepare finish");
    }
}

/**
 根据上下文和绘制区域绘制图形
 */
- (void)drawWithCGContext:(CGContextRef)ctx rect:(CGRect)rect indexPathForVisibleRange:(CGPoint)visibleRange scale:(CGFloat)scale otherArguments:(NSDictionary *)arguments {
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count <= 0) {
        return;
    }
    
    [self PL_ProvidencedrawIndicatorDetailWithRect:rect];
    
    // 根据传入的参数更新最大最小值
    [self PL_ProvidenceupdateExtremeValueWithArguments:arguments];
    
    // 开始和结束的K线下标
    NSInteger beginItemIndex = floor(visibleRange.x);
    NSInteger endItemIndex = ceil(visibleRange.y);
    if (beginItemIndex < 0) {
        beginItemIndex = 0;
    }
    
    
    // 实体线宽度
    self.entityLineWidth = [self.config defaultEntityLineWidth] *scale;
    if (self.entityLineWidth > [self.config maxEntityLineWidth]) {
        self.entityLineWidth = [self.config maxEntityLineWidth];
    }else if(self.entityLineWidth < [self.config minEntityLineWidth]) {
        self.entityLineWidth = [self.config minEntityLineWidth];
    }
    
    // 每个元素的宽度
    self.perItemWidth = (scale * self.config.klineGap) + self.entityLineWidth;
    
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
        //                NSAssert(diffValue > 0.0, @"最大值和最小值差值不能为0");
        return;
    }
    
    [self.rsi6PointArray removeAllObjects];
    [self.rsi12PointArray removeAllObjects];
    [self.rsi24PointArray removeAllObjects];
    
    // 计算绘图的x值
    CGFloat drawX = - (self.perItemWidth * (visibleRange.x - beginItemIndex));
    
    for (NSInteger a = beginItemIndex; a <= endItemIndex; a ++) {
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        // 中心x值
        CGFloat centerX = drawX + (self.perItemWidth / 2.0);
        
        // RSI6的点
        CGFloat rsi6PointY = rect.size.height * (1.0f - (tempModel.rsi6 - self.extremeValue.minValue) / diffValue) + rect.origin.y ;
        NSValue *rsi6PointValue = [NSValue valueWithCGPoint:CGPointMake(centerX, rsi6PointY)];
        [self.rsi6PointArray addObject:rsi6PointValue];
        
        
        // RSI12的点
        CGFloat rsi12PointY = rect.size.height * (1.0f - (tempModel.rsi12 - self.extremeValue.minValue) / diffValue) + rect.origin.y ;
        NSValue *rsi12PointValue = [NSValue valueWithCGPoint:CGPointMake(centerX, rsi12PointY)];
        
        [self.rsi12PointArray addObject:rsi12PointValue];
        
        // RSI24的点
        CGFloat rsi24PointY = rect.size.height * (1.0f - (tempModel.rsi24 - self.extremeValue.minValue) / diffValue) + rect.origin.y ;
        NSValue *rsi24PointValue = [NSValue valueWithCGPoint:CGPointMake(centerX, rsi24PointY)];
        
        [self.rsi24PointArray addObject:rsi24PointValue];
        
        drawX += self.perItemWidth;
    }
    
    // ris6
    [self PL_ProvidencedrawLineWithPointArray:self.rsi6PointArray atContent:ctx color:[self.config ma5Color].CGColor];
    
    // rsi12
    [self PL_ProvidencedrawLineWithPointArray:self.rsi12PointArray atContent:ctx color:[self.config ma10Color].CGColor];
    
    // rsi24
    [self PL_ProvidencedrawLineWithPointArray:self.rsi24PointArray atContent:ctx color:[self.config ma30Color].CGColor];
}

/**
 根据传入的点的集合绘制线段
 
 @param pointArray 点的集合
 @param ctx 绘图上下文
 */
- (void)PL_ProvidencedrawLineWithPointArray:(NSArray *)pointArray atContent:(CGContextRef)ctx color:(CGColorRef)color {
    
    // 设置画笔宽度
    CGContextSetLineWidth(ctx, self.lineWidth);
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(ctx, color);
    for (int a = 0; a < pointArray.count; a ++) {
        NSValue *value = pointArray[a];
        CGPoint tempPoint = [value CGPointValue];
        
        if (a == 0) {
            CGContextMoveToPoint(ctx, tempPoint.x, tempPoint.y);
        }else {
            CGContextAddLineToPoint(ctx, tempPoint.x, tempPoint.y);
        }
    }
    
    CGContextStrokePath(ctx);
}


/**
 根据传入的参数更新最大最小值
 
 @param argu 传入的参数
 */
- (void)PL_ProvidenceupdateExtremeValueWithArguments:(NSDictionary *)argu {
    
    if(argu && [argu isKindOfClass:[NSDictionary class]]) {
        
        NSValue *tempExtremeValue = [argu objectForKey:KlineViewToPL_ProvidenceLineBGDrawLogicExtremeValueKey];
        GLExtremeValue value = [tempExtremeValue PL_ProvidenceextremeValue];
        self.extremeValue = value;
        self.selectedModel = [argu objectForKey:KlineViewReticleSelectedModelKey];
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
    double minValue = MAXFLOAT;
    
    for (NSInteger a = beginIndex; a <= endIndex; a ++) {
        
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        if (tempModel) {
            
            if (tempModel.rsi6 > maxValue) {
                maxValue = tempModel.rsi6;
            }
            if(tempModel.rsi6 < minValue) {
                minValue = tempModel.rsi6;
            }
            
            if (tempModel.rsi12 > maxValue) {
                maxValue = tempModel.rsi12;
            }
            if(tempModel.rsi12 < minValue) {
                minValue = tempModel.rsi12;
            }
            
            if (tempModel.rsi24 > maxValue) {
                maxValue = tempModel.rsi24;
            }
            if(tempModel.rsi24 < minValue) {
                minValue = tempModel.rsi24;
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

// 绘制上方的详情视图
- (void)PL_ProvidencedrawIndicatorDetailWithRect:(CGRect)rect {
    
    if (self.selectedModel) {
        
        NSString *indicatorName = @"RSI(6,12,24)  ";
        
        NSString *rsi_6 = [NSString stringWithFormat:@"RSI1:%@ ",[@(self.selectedModel.rsi6) PL_ProvidencenumberToStringWithDecimalsLimit:6]];
        
        NSString *rsi_12 = [NSString stringWithFormat:@"RSI2:%@ ",[@(self.selectedModel.rsi12) PL_ProvidencenumberToStringWithDecimalsLimit:6]];
        
        NSString *rsi_24 = [NSString stringWithFormat:@"RSI3:%@",[@(self.selectedModel.rsi24) PL_ProvidencenumberToStringWithDecimalsLimit:6]];
        
        NSAttributedString *rsi_6_Att = [[NSAttributedString alloc] initWithString:rsi_6 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[self.config ma5Color]}];
        
        NSAttributedString *rsi_12_Att = [[NSAttributedString alloc] initWithString:rsi_12 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[self.config ma10Color]}];
        
        NSAttributedString *rsi_24_Att = [[NSAttributedString alloc] initWithString:rsi_24 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[self.config ma30Color]}];
        
        NSMutableAttributedString *mattirbuteStr = [[NSMutableAttributedString alloc] initWithString:indicatorName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"]}];
        
        if (rsi_6_Att) {
            [mattirbuteStr appendAttributedString:rsi_6_Att];
        }
        
        if (rsi_12_Att) {
            [mattirbuteStr appendAttributedString:rsi_12_Att];
        }
        
        if (rsi_24_Att) {
            [mattirbuteStr appendAttributedString:rsi_24_Att];
        }
        
        [mattirbuteStr drawInRect:CGRectMake(rect.origin.x + 5.0, 0, rect.size.width - 5.0, 20.0)];
    }
}




- (NSMutableArray *)rsi6PointArray {
    if (!_rsi6PointArray) {
        _rsi6PointArray = @[].mutableCopy;
    }
    return _rsi6PointArray;
}

- (NSMutableArray *)rsi12PointArray {
    if (!_rsi12PointArray) {
        _rsi12PointArray = @[].mutableCopy;
    }
    return _rsi12PointArray;
}

- (NSMutableArray *)rsi24PointArray {
    if (!_rsi24PointArray) {
        _rsi24PointArray = @[].mutableCopy;
    }
    return _rsi24PointArray;
}

@end
