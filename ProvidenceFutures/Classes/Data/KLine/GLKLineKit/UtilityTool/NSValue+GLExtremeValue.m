//
//  NSValue+GLExtremeValue.m
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

#import "NSValue+GLExtremeValue.h"

@implementation NSValue (GLExtremeValue)

/**
 为GLExtremeValue结构体生成NSValue对象的便捷方法
 
 @param value 结构体值
 @return 包装后的NSValue对象
 */
+ (instancetype)PL_ProvidencevaluewithGLExtremeValue:(GLExtremeValue)value {
    // 返回包装后的NSValue 对象
    return [NSValue value:&value withObjCType:@encode(GLExtremeValue)];
}


/**
 从NSValue对象中取出GLExtremeValue结构体
 */
- (GLExtremeValue)PL_ProvidenceextremeValue {
    // 初始化结构体
    GLExtremeValue extremeValue;
    // 给结构体赋值
    if (@available(iOS 11.0, *)) {
        // iOS 11以后推荐用此方法
        [self getValue:&extremeValue size:sizeof(GLExtremeValue)];
    } else {
        // 此方法在将来可能会被废弃
        [self getValue:&extremeValue];
    }
    return extremeValue;
}


@end
