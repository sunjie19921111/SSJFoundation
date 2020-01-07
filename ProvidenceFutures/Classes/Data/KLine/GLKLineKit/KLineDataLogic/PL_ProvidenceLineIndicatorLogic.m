//
//  PL_ProvidenceLineIndicatorLogic.m
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

#import "PL_ProvidenceLineIndicatorLogic.h"
#import "DataCenter.h"


@implementation PL_ProvidenceLineIndicatorLogic


#pragma mark - KDJ(9,3,3) 数据计算 ----
/**
 KDJ数据准备方法
 
 @param index 结束的下标
 */
+ (void)prepareDataForKDJFromIndex:(NSInteger)index {
    
    if (index > ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1)) {
        index = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
    }
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count >= 1) {
        for (NSInteger a = index; a < [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count ; a ++) {
            PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
            
            if (a == 0) {
                tempModel.k = 50.0f;
                tempModel.d = 50.0f;
            }else {
                tempModel.rsv9 = [self PL_Providencersv9WithEndIndex:a];
                [self PL_ProvidenceK_D_WithIndex:a];
            }
            
            tempModel.j = (3.0 * tempModel.k) - (2.0 * tempModel.d);
        }
    }
}

#pragma mark - MA(5,10,30) ---

/**
 分段计算MA数据
 MA(5,10,30) 计算方法
 */
+ (void)prepareDataForMAFromIndex:(NSUInteger)index {
    // MA准备数据方法
    if (index >= ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1)) {
        index = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
    }
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count >= 5) {
        
        for (NSInteger a = index; a < [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count; a ++) {
            PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
            if (a >= (5 - 1)) {
                tempModel.ma5 = [self PL_ProvidenceaveragePriceWithCount:5 endIndex:a];
            }
            
            if (a >= (10 - 1)) {
                tempModel.ma10 = [self PL_ProvidenceaveragePriceWithCount:10 endIndex:a];
            }
            
            if (a >= (30 - 1)) {
                tempModel.ma30 = [self PL_ProvidenceaveragePriceWithCount:30 endIndex:a];
            }
        }
    }
}


/**
 计算平均值
 
 @param count 平均数的个数
 @param index 计算平均数结束的下标
 */
+ (double)PL_ProvidenceaveragePriceWithCount:(NSInteger)count endIndex:(NSInteger)index {
    double result = 0.0f;
    
    if (index < (count - 1)) {
        return result;
    }
    
    double sum = 0.0f;
    for (NSInteger a = index; a > (index - count) ; a --) {
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        sum += [tempModel close];
    }
    
    result = sum / (double)count;
    
    return result;
}

#pragma mark - VOLMA(5,10) ---
/**
 准备VOL MA数据
 
 @param index index
 */
+ (void)prepareDataForVolMAFromIndex:(NSInteger)index {
    
    // MA准备数据方法
    if (index >= ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1)) {
        index = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
    }
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count >= 5) {
        
        for (NSInteger a = index; a < [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count; a ++) {
            PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
            if (a >= (5 - 1)) {
                tempModel.volMa5 = [self PL_ProvidenceaverageVolumeWithCount:5 endIndex:a];
            }
            
            if (a >= (10 - 1)) {
                tempModel.volMa10 = [self PL_ProvidenceaverageVolumeWithCount:10 endIndex:a];
            }
        }
    }
}

/**
 成交量平均值算法
 
 @param count 平均数的个数
 @param index 结束时的下标
 */
+ (double)PL_ProvidenceaverageVolumeWithCount:(NSInteger)count endIndex:(NSInteger)index {
    
    double result = 0.0f;
    
    if (index < (count - 1)) {
        return result;
    }
    
    double sum = 0.0f;
    for (NSInteger a = index; a > (index - count) ; a --) {
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        sum += [tempModel volume];
    }
    
    result = sum / (double)count;
    return result;
}

#pragma mark - BOLL(20,2) ---

/**
 BOLL数据准备方法
 
 @param index 开始计算的下标
 */
+ (void)prepareDataForBOLLFromIndex:(NSInteger)index {
    // BOLL准备方法
    if (index >= ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1)) {
        index = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
    }
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count >= 20) {
        
        for (NSInteger a = index; a < [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count; a ++) {
            PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
            if (a >= (20 - 1)) {
                tempModel.ma20 = [self PL_ProvidenceaveragePriceWithCount:20 endIndex:a];
                
                tempModel.boll_up = tempModel.ma20 + (2.0 * [self PL_Providencestd20WithCount:20 endIndex:a]);
                tempModel.boll_low = tempModel.ma20 - (2.0 * [self PL_Providencestd20WithCount:20 endIndex:a]);
            }
        }
    }
}


/**
 std(close , 20)
 
 @param count 求和的个数
 @param index 结束的index
 @return 计算后的std(close , 20)
 */
+ (double)PL_Providencestd20WithCount:(NSInteger)count endIndex:(NSInteger)index {
    double result = 0.0f;
    
    if (index < (count - 1)) {
        return result;
    }
    
    double sum = 0.0f;
    double ma20 = 0.0f;
    for (NSInteger a = index; a > (index - count) ; a --) {
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        if (!ma20) {
            ma20 = tempModel.ma20;
        }
        sum += pow(([tempModel close] - ma20),2);
    }
    // 开平方
    result = sqrt((sum / (double)count));
    
    return result;
}

#pragma mark - MACD(12,26,9) -----

/**
 MACD数据准备方法
 
 @param index 开始计算的下标
 */
+ (void)prepareDataForMACDFromIndex:(NSInteger)index {
    
    if (index >= ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1)) {
        index = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
    }
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count >= 1) {
        
        for (NSInteger a = index; a < [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count; a ++) {
            PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
            // 计算EMA12,EMA26
            [self PL_ProvidenceexpmaWithIndex:a];
            // DIF
            tempModel.dif = tempModel.ema12 - tempModel.ema26;
            // DEA
            [self PL_ProvidencedeaWithArgu:9 endIndex:a];
            // MACD柱线
            tempModel.macd = 2.0 * (tempModel.dif - tempModel.dea);
        }
    }
}


/**
 计算EMA的算法
 
 @param index 需要计算的下标
 */
+ (void)PL_ProvidenceexpmaWithIndex:(NSInteger)index {
    
    PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[index];
    
    if (index == 0) {
        
        // 第一日的ema12为收盘价
        tempModel.ema12 = tempModel.close;
        tempModel.ema26 = tempModel.close;
        
    }else if(!tempModel.ema12 || !tempModel.ema26) {
        
        PL_ProvidenceKLineModel *lastModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[index - 1];
        
        if (lastModel.ema12 && lastModel.ema26) {
            tempModel.ema12 = (2.0/13.0) * (tempModel.close - lastModel.ema12) + lastModel.ema12;
            tempModel.ema26 = (2.0/27.0) * (tempModel.close - lastModel.ema26) + lastModel.ema26;
            
        }else {
            
            [self PL_ProvidenceexpmaWithIndex:index - 1];
            
            tempModel.ema12 = (2.0/13.0) * (tempModel.close - lastModel.ema12) + lastModel.ema12;
            tempModel.ema26 = (2.0/27.0) * (tempModel.close - lastModel.ema26) + lastModel.ema26;
        }
    }
}


/**
 DIF的EMA(DEA)
 
 @param argu 计算平均值的平滑参数
 @param index 结束时的index
 */
+ (void)PL_ProvidencedeaWithArgu:(NSInteger)argu endIndex:(NSInteger)index {
    
    PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[index];
    
    if (index == 0) {
        
        // 第一日的dea为0
        tempModel.dea = 0.0f;
    }else {
        
        PL_ProvidenceKLineModel *lastModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[index - 1];
        
        if (lastModel.dea) {
            tempModel.dea = lastModel.dea * (8.0 / 10.0) + tempModel.dif * (2.0 / 10.0);
        }else {
            
            [self PL_ProvidencedeaWithArgu:argu endIndex:(index - 1)];
            tempModel.dea = lastModel.dea * (8.0 / 10.0) + tempModel.dif * (2.0 / 10.0);
        }
    }
}


/**
 计算RSV
 
 @param endindex 结束的下标
 @return 计算后的RSV9
 */
+ (double)PL_Providencersv9WithEndIndex:(NSInteger)endindex {
    double result = 0.0f;
    double low9 = MAXFLOAT;
    double high9 = - MAXFLOAT;
    double close = 0.0f;
    
    NSInteger startIndex = endindex - (9 - 1);
    if (startIndex < 0) {
        startIndex = 0;
    }
    
    for (NSInteger a = endindex; a >= startIndex; a --) {
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
        
        if (tempModel.low < low9) {
            low9 = tempModel.low;
        }
        
        if (tempModel.high > high9) {
            high9 = tempModel.high;
        }
        
        if (a == endindex) {
            close = tempModel.close;
        }
    }
    
    result = (close - low9) / (high9 - low9) * 100.0;
    
    return isnan(result) ? 0 : result;
}


/**
 计算K值和D值
 
 @param index 需要计算的模型的下标
 */
+ (void)PL_ProvidenceK_D_WithIndex:(NSInteger)index {
    
    PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[index];
    PL_ProvidenceKLineModel *lastModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[index - 1];
    
    tempModel.k = ((2.0 * lastModel.k) + tempModel.rsv9) / 3.0;
    tempModel.d = ((2.0 * lastModel.d) + tempModel.k) / 3.0;
}

#pragma mark - RSI(6,12,24) 数据计算 ----

/**
 RSI数据准备方法
 
 @param index 开始的下标
 */
+ (void)prepareDataForRSIFromIndex:(NSInteger)index {
    
    // MA准备数据方法
    if (index >= ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1)) {
        index = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
    }
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count >= 5) {
        
        for (NSInteger a = index; a < [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count; a ++) {
            PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[a];
            if(a >= 1) {
                // 计算RS
                [self PL_ProvidencersAtIndex:a];
                // 计算RSI
                tempModel.rsi6 = 100.0 - (100.0 / (1.0 + tempModel.up_avg_6 / tempModel.dn_avg_6));
                
                tempModel.rsi12 = 100.0 - (100.0 / (1.0 + tempModel.up_avg_12 / tempModel.dn_avg_12));
                
                tempModel.rsi24 = 100.0 - (100.0 / (1.0 + tempModel.up_avg_24 / tempModel.dn_avg_24));
                
            }
        }
    }
}


/**
 根据传入的参数计算RS
 
 @param atIndex 需要计算的下标
 */
+ (void)PL_ProvidencersAtIndex:(NSInteger)atIndex {
    
    PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[atIndex];
    PL_ProvidenceKLineModel *lastModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[atIndex - 1];
    
    double diff = tempModel.close - lastModel.close;
    double up = fmax(0.0, diff);
    double dn = fabs(fmin(0.0, diff));
    
    if (atIndex == 1) {
        
        tempModel.up_avg_6 = up / 6.0;
        tempModel.up_avg_12 = up / 12.0;
        tempModel.up_avg_24 = up / 24.0;
        
        tempModel.dn_avg_6 = dn / 6.0;
        tempModel.dn_avg_12 = dn / 12.0;
        tempModel.dn_avg_24 = dn / 24.0;
        
    }else {
        
        tempModel.up_avg_6 = (up / 6.0) + ((lastModel.up_avg_6 * 5.0) / 6.0);
        tempModel.up_avg_12 = (up / 12.0) + ((lastModel.up_avg_12 * 11.0) / 12.0);
        tempModel.up_avg_24 = (up / 24.0) + ((lastModel.up_avg_24 * 23.0) / 24.0);
        
        tempModel.dn_avg_6 = (dn / 6.0) + ((lastModel.dn_avg_6 * 5.0) / 6.0);
        tempModel.dn_avg_12 = (dn / 12.0) + ((lastModel.dn_avg_12 * 11.0) / 12.0);
        tempModel.dn_avg_24 = (dn / 24.0) + ((lastModel.dn_avg_24 * 23.0) / 24.0);
        
    }
}


@end
