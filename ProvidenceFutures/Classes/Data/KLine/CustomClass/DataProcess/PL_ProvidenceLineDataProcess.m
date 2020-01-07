//
//  PL_ProvidenceLineDataProcess.m
//  GLKLineKit
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
//  Copyright © 2018年 walker. All rights reserved.
//

#import "PL_ProvidenceLineDataProcess.h"
#import "GLKLineKit.h"

@implementation PL_ProvidenceLineDataProcess


/**
 检测两个时间戳是否一致
 
 @param firstStamp 第一个时间戳
 @param secondStamp 第二个时间戳
 @return 是否相同
 */
+ (BOOL)checkoutIsInSameTimeSectionWithFirstTime:(NSTimeInterval)firstStamp secondTime:(NSTimeInterval)secondStamp {
    
    BOOL isSame = NO;
    
    if (firstStamp == secondStamp) {
        isSame = YES;
    }
    return isSame;
}

/**
 将k线json转换为模型数组
 
 @param jsonData json数据
 @return 模型数组
 */
+ (NSMutableArray * _Nullable)convertToPL_ProvidenceHSFKLineModelArrayWithJsonData:(NSData * _Nonnull)jsonData {
    NSMutableArray *resultArray = @[].mutableCopy;
    // 设置前置的下标
    BOOL isNeedRestIndex = NO;
    __block NSInteger lastIndex = 0;
    if([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count) {
        isNeedRestIndex = NO;
        lastIndex = [(PL_ProvidenceKLineModel *)[[DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray lastObject] index];
    }else {
        isNeedRestIndex = YES;
    }
    // 解析
    NSError *error = nil;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    
    if (!error) {
        // 解析成功
       // NSLog(@"数据量：%lu,%@",(unsigned long)jsonArray.count,jsonArray);
        if(jsonArray.count >= 6 && ![[jsonArray firstObject] isKindOfClass:[NSArray class]]) {
            jsonArray = @[jsonArray];
        }
        
        [jsonArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            PL_ProvidenceKLineModel *tempModel = [PL_ProvidenceKLineModel createWithArray:obj];
            if (tempModel) {
                
                tempModel.index = lastIndex + idx;
                [resultArray addObject:tempModel];
            }
        }];
    }
    return resultArray;
}

@end
