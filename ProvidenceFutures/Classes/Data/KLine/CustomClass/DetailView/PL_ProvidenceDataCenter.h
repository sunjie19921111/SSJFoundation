//
//  PL_ProvidenceDataCenter.h
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
@class DetailDataModel;


NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceDataCenter : UIView

/**
 内边距
 */
@property (assign, nonatomic) UIEdgeInsets insets;

/**
 更新内容

 @param models 内容数组
 */
- (void)updateContentWithDetailModels:(NSArray <DetailDataModel *>*)models;
/**
 height for row
 */
@property (assign, nonatomic) CGFloat rowHeight;

/**
 Text Color
 */
@property (strong, nonatomic) UIColor *textColor;

/**
 text Font
 */
@property (strong, nonatomic) UIFont *textFont;



@end

#pragma mark - 展示数据模型 ---


/**
 ————————————————
 |name1    desc1|
 |name2    desc2|
 ————————————————
 */
@interface DetailDataModel : NSObject

/**
 desc
 */
@property (copy, nonatomic) NSString *desc;

/**
 便利构造器
 */
- (instancetype)initWithName:(NSString *)name desc:(NSString *)desc;


/**
 name
 */
@property (copy, nonatomic) NSString *name;

@end
NS_ASSUME_NONNULL_END

