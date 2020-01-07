//
//  PL_ProvidenceKLineModel.m
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

#import "PL_ProvidenceKLineModel.h"
#import "DataCenter.h"
@implementation PL_ProvidenceKLineModel



/**
 便捷初始化方法
 
 @param dictionary 数据字典
 */
+ (instancetype)createWithDictionary:(NSDictionary *)dictionary {
    
    PL_ProvidenceKLineModel *tempModel = nil;
    
    if (dictionary && [dictionary count] > 0) {
        
        tempModel = [PL_ProvidenceKLineModel new];
        tempModel.stamp = [[dictionary objectForKey:@"tick_at"] doubleValue];
        tempModel.open = [[dictionary objectForKey:@"open_px"] doubleValue];
        tempModel.close = [[dictionary objectForKey:@"close_px"] doubleValue];
        tempModel.high = [[dictionary objectForKey:@"high_px"] doubleValue];
        tempModel.low = [[dictionary objectForKey:@"low_px"] doubleValue];
        tempModel.volume = [[dictionary objectForKey:@"turnover_volume"] doubleValue];
    }
    
    return tempModel;
}

/**
 根据数据数组创建对象
 
 @param dataArray 数据数组
 */
+ (instancetype)createWithArray:(NSArray *)dataArray {
    PL_ProvidenceKLineModel *tempModel = nil;
    
    for (int a = 0; a < dataArray.count; a ++) {
        
        tempModel = [PL_ProvidenceKLineModel new];
        tempModel.open = [dataArray[0] doubleValue];
        tempModel.close = [dataArray[1] doubleValue];
        tempModel.high = [dataArray[2] doubleValue];
        tempModel.low = [dataArray[3] doubleValue];
        tempModel.volume = [dataArray[4] doubleValue];
        tempModel.stamp = [dataArray[5] doubleValue];
    }
    
    return tempModel;
}


@end
