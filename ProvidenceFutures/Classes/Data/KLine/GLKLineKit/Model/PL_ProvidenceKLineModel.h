//
//  PL_ProvidenceKLineModel.h
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

/* K线数据模型，包含指标计算的中间值和最终值 */

#import <Foundation/Foundation.h>

@interface PL_ProvidenceKLineModel : NSObject


/**
 处于当前总数据的下标
 */
@property (assign, nonatomic) NSInteger index;

#pragma mark - 指标属性 ---
// --------- MA(5,10,30)--------
/**
 MA(5)
 */
@property (assign, nonatomic) double ma5;

/**
 MA(10)
 */
@property (assign, nonatomic) double ma10;

/**
 MA(30)
 */
@property (assign, nonatomic) double ma30;

// --------- VOL MA(成交量MA)(5,10)--------
/**
 VolMA(5)
 */
@property (assign, nonatomic) double volMa5;


/**
 6日下跌均值
 */
@property (assign, nonatomic) double dn_avg_6;

/**
 RSI12
 */
@property (assign, nonatomic) double rsi12;

/**
 12日上涨均值
 */
@property (assign, nonatomic) double up_avg_12;

/**
 12日下跌均值
 */
@property (assign, nonatomic) double dn_avg_12;

/**
 RSI24
 */
@property (assign, nonatomic) double rsi24;

/**
 24日上涨均值
 */
@property (assign, nonatomic) double up_avg_24;

/**
 24日下跌均值
 */
@property (assign, nonatomic) double dn_avg_24;

#pragma mark - 便捷方法 ---

/**
 快捷初始化方法
 根据数据数组创建对象

 @param dataArray 数据数组
 */
+ (instancetype)createWithArray:(NSArray *)dataArray;

/**
 high,最高价
 */
@property (assign, nonatomic) double high;

/**
 open,开盘价
 */
@property (assign, nonatomic) double open;

/**
 low,最低价
 */
@property (assign, nonatomic) double low;

/**
 close,收盘价
 */
@property (assign, nonatomic) double close;

/**
 time,时间戳
 */
@property (assign, nonatomic) NSTimeInterval stamp;

/**
 volume,成交量
 */
@property (assign, nonatomic) double volume;


/**
 VolMA(10)
 */
@property (assign, nonatomic) double volMa10;

// --------- BOLL(20,2) -----------
/**
 MID: MA(20)
 */
@property (assign, nonatomic) double ma20;

/**
 UP
 */
@property (assign, nonatomic) double boll_up;

/**
 LOW
 */
@property (assign, nonatomic) double boll_low;

// ------- MACD(12,26,9) -----------
/**
 EMA12
 */
@property (assign, nonatomic) double ema12;

/**
 EMA26
 */
@property (assign, nonatomic) double ema26;

/**
 DIF
 */
@property (assign, nonatomic) double dif;

/**
 DEA
 */
@property (assign, nonatomic) double dea;

/**
 MACD
 */
@property (assign, nonatomic) double macd;

// ------- KDJ(9,3,3) -----------
/**
 RSV(9)
 */
@property (assign, nonatomic) double rsv9;

/**
 K
 */
@property (assign, nonatomic) double k;

/**
 D
 */
@property (assign, nonatomic) double d;

/**
 J
 */
@property (assign, nonatomic) double j;

// ------- RSI(6,12,24) -----------
/**
 RSI6
 */
@property (assign, nonatomic) double rsi6;

/**
 6日上涨均值
 */
@property (assign, nonatomic) double up_avg_6;




///**
// 便捷初始化方法
//
// @param dictionary 数据字典
// */
//+ (instancetype)createWithDictionary:(NSDictionary *)dictionary;
@end
