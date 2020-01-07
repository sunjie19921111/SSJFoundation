//
//  PL_ProvidenceLineIndicatorLogic.h
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


#import <Foundation/Foundation.h>

@interface PL_ProvidenceLineIndicatorLogic : NSObject



/**
 RSI数据准备方法 (6,12,24) (✅)

 @param index 计算开始的下标
 软件绘制平滑处理
 当日上涨平均数 = 前一日涨幅平均数*5/6 + 当日涨幅/6 （若某日下跌时，则当日涨幅记为0）
 
 当日下跌平均数 = 前一日跌幅平均数*5/6 + 当日跌幅/6 （若某日上涨时，则当日跌幅记为0)
 */
+ (void)prepareDataForRSIFromIndex:(NSInteger)index;

/**
 MACD数据准备方法(12,26,9) (✅)

 @param index 计算开始的下标
 */
+ (void)prepareDataForMACDFromIndex:(NSInteger)index;

/**
 KDJ数据准备方法(9,3,3) (✅)
 
 @param index 计算开始的下标
 */
+ (void)prepareDataForKDJFromIndex:(NSInteger)index;

/**
 分段计算MA数据 (✅)
 MA(5,10,30) 计算方法
 */
+ (void)prepareDataForMAFromIndex:(NSUInteger)index;

/**
 准备VOL MA数据(5,10) (✅)
 
 @param index 计算开始的index
 */
+ (void)prepareDataForVolMAFromIndex:(NSInteger)index;

/**
 BOLL数据准备方法(20,2) (✅)
 
 @param index 计算开始的下标
 */
+ (void)prepareDataForBOLLFromIndex:(NSInteger)index;



@end
