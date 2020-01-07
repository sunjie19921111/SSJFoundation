//
//  PL_ProvidenceConstantDefinition.m
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

#import "PL_ProvidenceConstantDefinition.h"



/* K线绘图算法默认的Identifier */
NSString *const PL_ProvidenceLineDrawLogicDefaultIdentifier = @"PL_ProvidenceLineDrawLogicDefaultIdentifier";
/* K线背景绘图算法默认的Identifier */
NSString *const PL_ProvidenceLineBGDrawLogicDefaultIdentifier = @"PL_ProvidenceLineBGDrawLogicDefaultIdentifier";
/* k线视图传入背景绘图算法的最大最小值的key */
NSString *const KlineViewToPL_ProvidenceLineBGDrawLogicExtremeValueKey = @"KlineViewToPL_ProvidenceLineBGDrawLogicExtremeValueKey";
/* 十字线选中的model的key */
NSString  *const KlineViewReticleSelectedModelKey = @"KlineViewReticleSelectedModelKey";
/* 在字典中保存时对应的Key */
NSString *const updateExtremeValueBlockAtDictionaryKey = @"updateExtremeValueBlockAtDictionaryKey";


GLExtremeValue const GLExtremeValueZero = {0,0};
