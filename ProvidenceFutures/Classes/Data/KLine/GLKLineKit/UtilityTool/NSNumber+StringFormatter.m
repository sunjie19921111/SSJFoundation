//
//  NSNumber+StringFormatter.m
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

#import "NSNumber+StringFormatter.h"

@implementation NSNumber (StringFormatter)

/**
 根据传入的小数位数返回相应的字符串
 
 @param limit 小数位数限制,如果传入的值 < 0,默认小数位数为8
 @return 指定小数位数的字符串
 */
- (NSString *_Nullable)PL_ProvidencenumberToStringWithDecimalsLimit:(NSInteger)limit {

    if(limit < 0) {
        limit = 8;
    }
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.maximumFractionDigits = limit;
    formatter.minimumFractionDigits = limit;
    formatter.minimumIntegerDigits = 1;
    NSString *result = [formatter stringFromNumber:self];
    return result ? : @"";
}

@end
