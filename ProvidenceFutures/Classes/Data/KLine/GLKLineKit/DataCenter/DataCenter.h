//
//  DataCenter.h
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




/* 数据中心 */

#import <Foundation/Foundation.h>
#import "DataCenterProtocol.h"
#import "PL_ProvidenceConstantDefinition.h"
#import "PL_ProvidenceKLineModel.h"
NS_ASSUME_NONNULL_BEGIN

/**
 是否合并模型的block
 
 @param firstModel 前一个model
 @param secondModel 后一个model
 @return YES:需要合并(后一个model替换前一个) NO:不需要合并
 */
typedef BOOL(^IsMergeModelBlock)(PL_ProvidenceKLineModel *firstModel , PL_ProvidenceKLineModel *secondModel);




/* 对指标数据处理时选择的指标类型 */
typedef enum : NSUInteger {
    IndicatorsDataTypeNone = 1,         // 无处理，只有高，开，低，收，时间，量等初始数据，不进行其他数据的计算
    IndicatorsDataTypeMA,               // 价格MA(5,10,30)
    IndicatorsDataTypeVolMA,            // 成交量MA(5,10)
    IndicatorsDataTypeBOLL,             // BOLL
    IndicatorsDataTypeMACD,             // MACD
    IndicatorsDataTypeKDJ,              // KDJ
    IndicatorsDataTypeRSI,              // RSI
} IndicatorsDataType;



@interface DataCenter : NSObject

#pragma mark - 处理数据相关方法 ----

/**
 小数位数限制
 */
@property (assign, nonatomic) NSInteger decimalsLimit;

/** 是否是第一次加载数据 */
@property (assign, nonatomic) BOOL isFirstLoad;

/**
 某个类型指标数据是否已经准备好
 
 @param dataType 指标数据类型
 @return 准备好返回YES，未准备好返回NO
 */
- (BOOL)isPrepareForDataType:(IndicatorsDataType)dataType;

/**
 分段准备指定指标类型数据
 
 @param dataType 数据类型
 @param index 开始的下标，一直到结束
 */
- (void)prepareDataWithType:(IndicatorsDataType)dataType fromIndex:(NSUInteger)index;

/**
 取消所有指标类型数据的准备状态,下次绘制时会重新计算
 备注：慎用，否则会有性能问题，内部已经做好了处理逻辑，所以如果没有问题尽量不要取消准备状态
 */
- (void)unPrepareAllIndicatorsDataState;

/**
 将某种指标数据的准备状态取消,下次绘制时会重新计算
 
 @param dataType 指标数据状态
 备注：慎用，否则会有性能问题，内部已经做好了处理逻辑，所以如果没有问题尽量不要取消准备状态
 */
- (void)unPrepareIndicatorsDataStateWithDataType:(IndicatorsDataType)dataType;
/**
 PL_ProvidenceHSFKLineModelArray
 */
@property (readonly, strong, nonatomic) NSMutableArray *PL_ProvidenceHSFKLineModelArray;



/**
 初始化单例
 
 @return 数据中心单例
 */
+ (instancetype)shareCenter;

/**
 添加代理
 
 @param delegate 遵循<DataCenterProtocol>协议的代理
 支持多代理模式，但是要记得移除，否则会造成多次调用
 */
- (void)addDelegate:(id<DataCenterProtocol>_Nonnull)delegate;

/**
 移除代理
 
 @param delegate 遵循<DataCenterProtocol>协议的代理
 */
- (void)removeDelegate:(id<DataCenterProtocol>_Nonnull)delegate;

#pragma mark - 原始数据操作方法 ----
/**
 清空数据
 */
- (void)cleanData;

/**
 刷新数据
 
 @param dataArray 刷新数据
 */
- (void)reloadDataWithArray:(NSArray * _Nullable)dataArray withDecimalsLimit:(NSInteger)decimalsLimit;

/**
 追加数据,不对数据进行处理
 
 @param moreDataArray 追加的数据
 */
- (void)addMoreDataWithArray:(NSArray * _Nullable)moreDataArray;

/**
 追加数据
 
 @param moreDataArray 需要追加的数据
 @param mergeCheckBlock 对追加的数据进行去重合并处理的block
 */
- (void)addMoreDataWithArray:(NSArray * _Nullable)moreDataArray isMergeModel:(IsMergeModelBlock)mergeCheckBlock;

/**
 根据模型得到当前所处的位置(⚠️ 准确性不高，不推荐使用)
 
 @param model 模型
 返回-1 说明没找到这个模型
 */
- (NSInteger)getIndexWithPL_ProvidenceHSFKLineModel:(PL_ProvidenceKLineModel *)model;


@end
NS_ASSUME_NONNULL_END
