//
//  PL_ProvidenceBaseDrawLogic.h
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

/**
 此类只是父类，不包含业务逻辑，不可使用
 需要使用此类的子类
 */
#import <Foundation/Foundation.h>
#import "PL_ProvidenceChartDrawProtocol.h"
#import "NSValue+GLExtremeValue.h"
#import "NSNumber+StringFormatter.h"
NS_ASSUME_NONNULL_BEGIN


@interface PL_ProvidenceBaseDrawLogic : NSObject <PL_ProvidenceChartDrawProtocol>

/**
 初始化方法

 @param identifier 绘图算法的标识符
 */
- (instancetype)initWithDrawLogicIdentifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER NS_REQUIRES_SUPER;

/**
 禁用此初始化方法
 请使用 - initWithDrawLogicIdentifier:方法
 */
- (instancetype)init NS_UNAVAILABLE;

/**
当前绘图算法的标识符，用作增删改查的标识
 此处不安全，还需处理
*/
@property (copy, nonatomic) NSString *drawLogicIdentifier;

/**
 配置类对象
 如果是自定义的配置类，一定要传，
 如果不传默认使用的是PL_ProvidenceLineViewConfig
 */
@property (strong, nonatomic) NSObject <KLineViewProtocol> *config;


@end
NS_ASSUME_NONNULL_END
