//
//  DataCenterProtocol.h
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

/* 数据中心的协议 */

#import <Foundation/Foundation.h>
@class DataCenter;
@protocol DataCenterProtocol <NSObject>

/**
 数据已经刷新

 @param dataCenter 数据中心
 @param modelArray 刷新后的数据
 */
- (void)dataCenter:(DataCenter *)dataCenter didReload:(NSArray *)modelArray;

/**
 数据已经被清空
 
 @param dataCenter 数据中心
 */
- (void)dataDidCleanAtDataCenter:(DataCenter *)dataCenter;
/**
 在尾部添加了最新数据

 @param dataCenter 数据中心
 @param modelArray 添加后的数据
 */
- (void)dataCenter:(DataCenter *)dataCenter didAddNewDataInTail:(NSArray *)modelArray;

/**
 在头部添加了数据
 
 @param dataCenter 数据中心
 @param modelArray 添加后的数据
 */
- (void)dataCenter:(DataCenter *)dataCenter didAddNewDataInHead:(NSArray *)modelArray;



@end
