//
//  PL_ProvidenceFullScreenKLineView.h
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

#import <UIKit/UIKit.h>
#import "GLKLineKit.h"

@interface PL_ProvidenceFullScreenKLineView : UIView

/** 当前的主图样式 */
@property (readonly, assign, nonatomic) KLineMainViewType mainViewType;

/** 当前的附图样式 */
@property (readonly, assign, nonatomic) KLineAssistantViewType assistantViewType;

/**
 切换主图样式，默认是K线
 */
- (void)switchKLineMainViewToType:(KLineMainViewType)type;

/**
 切换附图样式，默认是VOL+MA
 */
- (void)switchKlineAssistantViewToType:(KLineAssistantViewType)type;

/**
 重新绘制
 缩放比例还是按照之前显示的比例
 @param drawType 绘制时采用的类型
 */
- (void)reloadKlineViewWithType:(ReDrawType)drawType;
/**
 数据中心
 */
@property (strong, nonatomic) DataCenter *dataCenter;

/**
 K线主图
 */
@property (strong, nonatomic) PL_ProvidenceZSHKLineView *kLineMainView;



@end
