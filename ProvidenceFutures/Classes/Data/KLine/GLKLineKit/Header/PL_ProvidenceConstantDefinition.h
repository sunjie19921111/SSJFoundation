//
//  PL_ProvidenceConstantDefinition.h
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

/* 一些常量定义 */

#ifndef PL_ProvidenceConstantDefinition_h
#define PL_ProvidenceConstantDefinition_h
#import <UIKit/UIKit.h>

#pragma mark - 最大最小值的结构体 ----👇👇--begin----
// 最值结构体定义
struct GLExtremeValue {
    double minValue;
    double maxValue;
};
typedef struct CG_BOXABLE GLExtremeValue GLExtremeValue;

// 最值都是0的结构体
CG_EXTERN GLExtremeValue const GLExtremeValueZero;

// 定义创建结构体方法
CG_INLINE GLExtremeValue GLExtremeValueMake(double minValue, double maxValue);

CG_INLINE GLExtremeValue GLExtremeValueMake(double minValue, double maxValue)
{
    GLExtremeValue e; e.minValue = minValue; e.maxValue = maxValue; return e;
}

// 定义并实现比较两个最值结构体的方法
CG_EXTERN bool GLExtremeValueEqualToExtremeValue(GLExtremeValue value1, GLExtremeValue value2);
CG_INLINE bool
__GLExtremeValueEqualToExtremeValue(GLExtremeValue value1, GLExtremeValue value2)
{
    return value1.minValue == value2.minValue && value1.maxValue == value2.maxValue;
}
#define GLExtremeValueEqualToExtremeValue __GLExtremeValueEqualToExtremeValue

#pragma mark -- 最大最小值的结构体 ----👆👆--end----



#pragma mark - block 定义 -----------------
/* 更新最大最小值的block */
typedef void (^UpdateExtremeValueBlock)(NSString *identifier , double minValue,double maxValue);


#pragma mark - 一些Key的定义 ---------------
/* 在字典中保存时对应的Key */
UIKIT_EXTERN NSString *const updateExtremeValueBlockAtDictionaryKey;

/* K线绘图算法默认的Identifier */
UIKIT_EXTERN NSString *const PL_ProvidenceLineDrawLogicDefaultIdentifier;

/* K线背景绘图算法默认的Identifier */
UIKIT_EXTERN NSString *const PL_ProvidenceLineBGDrawLogicDefaultIdentifier;

/* k线视图传入背景绘图算法的最大最小值的key */
UIKIT_EXTERN NSString *const KlineViewToPL_ProvidenceLineBGDrawLogicExtremeValueKey;

/* 十字线选中的model的key */
UIKIT_EXTERN NSString *const KlineViewReticleSelectedModelKey;

#endif /* ConstantDefinition_h */
