//
//  PL_ProvidenceLineVolMADrawLogic.m
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

#import "PL_ProvidenceLineVolMADrawLogic.h"
#import "DataCenter.h"

@interface PL_ProvidenceLineVolMADrawLogic ()


/**
 平均线宽度
 */
@property (assign, nonatomic) CGFloat lineWidth;

/**
 K线实体线宽度
 */
@property (assign, nonatomic) CGFloat entityLineWidth;

/**
 MA5点的集合
 */
@property (strong, nonatomic) NSMutableArray *volMa5PointArray;

/**
 MA10点的集合
 */
@property (strong, nonatomic) NSMutableArray *volMa10PointArray;

/**
 最大值最小值
 */
@property (assign, nonatomic) GLExtremeValue extremeValue;

/**
 每个item的宽度
 */
@property (assign, nonatomic) CGFloat perItemWidth;


/**
 选中的模型
 */
@property (strong, nonatomic) PL_ProvidenceKLineModel *selectedModel;
@end

@implementation PL_ProvidenceLineVolMADrawLogic
- (instancetype)initWithDrawLogicIdentifier:(NSString *)identifier {
    if (self = [super initWithDrawLogicIdentifier:identifier]) {
        [self PL_Providenceinitialize];;
    }
    return self;
}



- (void)PL_Providenceinitialize {
    
    ;
    
    self.lineWidth = 1.0f;
    
    NSLog(@"VOLMA data prepare begin");
    if(![[DataCenter shareCenter] isPrepareForDataType:IndicatorsDataTypeVolMA]){
        [[DataCenter shareCenter] prepareDataWithType:IndicatorsDataTypeVolMA fromIndex:0];
        NSLog(@"VOLMA data prepare finish");
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
    
    [self.volMa5PointArray removeAllObjects];
    [self.volMa10PointArray removeAllObjects];
    
    // 计算绘图的x值
    CGFloat drawX = - (self.perItemWidth * (visibleRange.x - beginItemIndex));
    
    for (NSInteger a = beginItemIndex; a <= endItemIndex; a ++) {
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        // 中心x值
        CGFloat centerX = drawX + (self.perItemWidth / 2.0);
        if (tempModel.volMa5 >= 0) {
            // MA5的点
            CGFloat pointY = rect.size.height * (1.0f - (tempModel.volMa5 - self.extremeValue.minValue) / diffValue) + rect.origin.y ;
            NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake(centerX, pointY)];
            
            [self.volMa5PointArray addObject:pointValue];
        }
        
        
        if (tempModel.volMa10 >= 0) {
            // MA10的点
            CGFloat pointY = rect.size.height * (1.0f - (tempModel.volMa10 - self.extremeValue.minValue) / diffValue) + rect.origin.y ;
            NSValue *pointValue = [NSValue valueWithCGPoint:CGPointMake(centerX, pointY)];
            
            [self.volMa10PointArray addObject:pointValue];
        }
        
        drawX += self.perItemWidth;
    }
    
    // ma5
    [self PL_ProvidencedrawLineWithPointArray:self.volMa5PointArray atContent:ctx color:[self.config ma5Color].CGColor];
    
    // ma10
    [self PL_ProvidencedrawLineWithPointArray:self.volMa10PointArray atContent:ctx color:[self.config ma10Color].CGColor];
    
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
    double minValue = 0.0;
    
    for (NSInteger a = beginIndex; a <= endIndex; a ++) {
        
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        if (tempModel) {
            
            if (tempModel.volMa5) {
                if (tempModel.volMa5 > maxValue) {
                    maxValue = tempModel.volMa5;
                }
//                if(tempModel.volMa5 < minValue) {
//                    minValue = tempModel.volMa5;
//                }
            }
            
            if (tempModel.volMa10) {
                if (tempModel.volMa10 > maxValue) {
                    maxValue = tempModel.volMa10;
                }
//                if(tempModel.volMa10 < minValue) {
//                    minValue = tempModel.volMa10;
//                }
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
    
//    minValue = fmin(minValue, self.extremeValue.minValue);
    minValue = 0.0f;        // 从0开始绘制
    maxValue = fmax(maxValue, self.extremeValue.maxValue);
    
    self.extremeValue = GLExtremeValueMake(minValue, maxValue);
}


// 绘制上方的详情视图
- (void)PL_ProvidencedrawIndicatorDetailWithRect:(CGRect)rect {
    
    if (self.selectedModel) {
        
        NSString *indicatorName = @"MA(5,10)  ";
        
        NSString *volString = [NSString stringWithFormat:@"VOL:%@ ",[@(self.selectedModel.volume) stringValue]];
        
        NSString *volMa5String = [NSString stringWithFormat:@"ma5:%@ ",[@(self.selectedModel.volMa5) stringValue]];
        
        NSString *volMa10String = [NSString stringWithFormat:@"ma10:%@",[@(self.selectedModel.volMa10) stringValue]];
        
        NSAttributedString *VOLatt = [[NSAttributedString alloc] initWithString:volString attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[UIColor whiteColor]}];
        
        NSAttributedString *volMa5att = [[NSAttributedString alloc] initWithString:volMa5String attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[self.config ma5Color]}];
        
        NSAttributedString *volMa10att = [[NSAttributedString alloc] initWithString:volMa10String attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[self.config ma10Color]}];
        
        NSMutableAttributedString *mattirbuteStr = [[NSMutableAttributedString alloc] initWithString:indicatorName attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0f],NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0xB4B4B4"]}];
        
        if (VOLatt) {
            [mattirbuteStr appendAttributedString:VOLatt];
        }
        
        if (volMa5att) {
            [mattirbuteStr appendAttributedString:volMa5att];
        }
        
        if (volMa10att) {
            [mattirbuteStr appendAttributedString:volMa10att];
        }
        
        [mattirbuteStr drawInRect:CGRectMake(rect.origin.x + 5.0, 0, rect.size.width - 5.0, 20.0)];
    }
}


- (NSMutableArray *)volMa5PointArray {
    if (!_volMa5PointArray) {
        _volMa5PointArray = @[].mutableCopy;
    }
    return _volMa5PointArray;
}

- (NSMutableArray *)volMa10PointArray {
    if (!_volMa10PointArray) {
        _volMa10PointArray = @[].mutableCopy;
    }
    return _volMa10PointArray;
}


@end
