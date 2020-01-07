//
//  PL_ProvidenceLineMADrawLogic.h
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

/* MA(5,10,30)绘图算法 */

#import "PL_ProvidenceBaseDrawLogic.h"

@interface PL_ProvidenceLineMADrawLogic : PL_ProvidenceBaseDrawLogic

#pragma mark - 下方隐藏各MA线方法主要是为了配合分时图使用，因为一般分时图只会有一根MA线，可以根据需求隐藏不需要的线 ---

/**
 隐藏ma5

 @param hide 是否隐藏，传YES隐藏，默认为NO
 */
- (void)setMa5Hiden:(BOOL)hide;

/**
 隐藏ma10
 
 @param hide 是否隐藏，传YES隐藏，默认为NO
 */
- (void)setMa10Hiden:(BOOL)hide;

/**
 隐藏ma30
 
 @param hide 是否隐藏，传YES隐藏，默认为NO
 */
- (void)setMa30Hiden:(BOOL)hide;

@end
