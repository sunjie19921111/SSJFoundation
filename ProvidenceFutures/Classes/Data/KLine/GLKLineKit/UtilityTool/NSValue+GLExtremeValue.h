//
//  NSValue+GLExtremeValue.h
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
#import "PL_ProvidenceConstantDefinition.h"



@interface NSValue (GLExtremeValue)

/**
 从NSValue对象中取出GLExtremeValue结构体
 */
@property (readonly) GLExtremeValue PL_ProvidenceextremeValue;
/**
 为GLExtremeValue结构体生成NSValue对象的便捷方法

 @param value 结构体值
 @return 包装后的NSValue对象
 */
+ (instancetype)PL_ProvidencevaluewithGLExtremeValue:(GLExtremeValue)value;

@end
