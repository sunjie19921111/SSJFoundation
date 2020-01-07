//
//  PL_ProvidenceVerticalView.h
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
/* 十字线垂直线 */

#import <UIKit/UIKit.h>

@interface PL_ProvidenceVerticalView : UIView


/**
 更新文字

 @param text 文字
 */
- (void)updateText:(NSString *)text;

/**
 更新文字区域中心点的x

 @param textCenterX 文字区域的中心点x值
 */
- (void)updateTextCenterX:(CGFloat)textCenterX;

/**
 更新文字
 
 @param text 文字
 @param textCenterX 文字区域的中心点x值
 */
- (void)updateText:(NSString *)text textCenterX:(CGFloat)textCenterX;
/**
 文字是否需要边框
 默认显示边框
 */
@property (assign, nonatomic) BOOL isShowBorder;

/**
 文字颜色
 */
@property (strong, nonatomic) UIColor *textColor;




@end
