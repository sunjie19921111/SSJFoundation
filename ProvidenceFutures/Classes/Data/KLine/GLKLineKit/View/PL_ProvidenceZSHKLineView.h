//
//  KlineView.h
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



#import <UIKit/UIKit.h>
#import "KLineViewProtocol.h"
#import "PL_ProvidenceChartDrawProtocol.h"


@class DataCenter,PL_ProvidenceBaseDrawLogic,PL_ProvidenceLineDataLogic;

/* 重绘时的位置类型 */
typedef enum : NSUInteger {
    ReDrawTypeDefault = 1,      // 重绘并保留当前位置
    ReDrawTypeToTail,           // 重绘并回到尾部
    ReDrawTypeToHead,           // 重绘并回到头部
} ReDrawType;

NS_ASSUME_NONNULL_BEGIN


@interface PL_ProvidenceZSHKLineView : UIView


/**
 添加绘图算法

 @param logic 需要添加的绘图算法
 @return 添加后的绘图算法
 */
- (NSArray <PL_ProvidenceBaseDrawLogic *>* _Nullable)addDrawLogic:(PL_ProvidenceBaseDrawLogic<PL_ProvidenceChartDrawProtocol>*)logic;

/**
 清除所有绘图算法
 
 @return 清除的算法个数
 */
- (NSInteger)removeAllDrawLogic;



/**
 重新绘制
 缩放比例还是按照之前显示的比例
 @param drawType 绘制时采用的类型
 */
- (void)reDrawWithType:(ReDrawType)drawType;

/**
 移除某个绘图算法

 @param identifier 需要移除的绘图算法的标识符
 @return 移除以后的绘图算法集合
 */
- (NSArray <PL_ProvidenceBaseDrawLogic *>* _Nullable)removeDrawLogicWithLogicId:(NSString *)identifier;

/**
 移除某个绘图算法
 
 @param logic 需要移除的绘图算法
 @return 移除以后的绘图算法集合
 */
- (NSArray <PL_ProvidenceBaseDrawLogic *>* _Nullable)removeDrawLogicWithLogic:(PL_ProvidenceBaseDrawLogic<PL_ProvidenceChartDrawProtocol>*)logic;

/**
 根据缩放比例绘制

 @param scale 缩放比例
 */
- (void)reDrawWithScale:(CGFloat)scale;

/**
 数据中心
 */
@property (readonly, weak, nonatomic) DataCenter *dataCenter;

/**
 数据逻辑处理类
 */
@property (readonly, strong, nonatomic) PL_ProvidenceLineDataLogic *dataLogic;

/**
 K线图的配置对象
 默认为PL_ProvidenceLineViewConfig
 如果要自定义，请使用initWithConfig:方法
 */
@property (readonly, strong, nonatomic) NSObject<KLineViewProtocol>*config;

/**
 当前的最值
 */
@property (readonly, assign, nonatomic) GLExtremeValue currentExtremeValue;

/**
 初始化方法

 @param frame 尺寸
 @param customConfig 自定义K线图的配置文件
 */
- (instancetype)initWithFrame:(CGRect)frame config:(NSObject<KLineViewProtocol>* _Nullable)customConfig;

/**
 将当前View的DataLogic更换为指定的DataLogic

 @param dataLogic 指定的dataLogic
 */
- (void)replaceDataLogicWithLogic:(PL_ProvidenceLineDataLogic *)dataLogic;

/**
 是否包含某个指定id的绘图算法

 @param identifier id
 @return 存在返回YES，不存在返回NO
 */
- (BOOL)containsDrawLogicWithIdentifier:(NSString * _Nullable)identifier;




@end
NS_ASSUME_NONNULL_END
