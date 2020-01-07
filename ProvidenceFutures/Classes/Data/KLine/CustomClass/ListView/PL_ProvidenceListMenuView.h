//
//  PL_ProvidenceListMenuView.h
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
NS_ASSUME_NONNULL_BEGIN

@class PL_ProvidenceListMenuView;

@protocol PL_ProvidenceListMenuViewProtocol <NSObject>

@optional

/**
 每个分区的高度

 @param section 分区数
 */
- (CGFloat)PL_ProvidenceListMenuView:(PL_ProvidenceListMenuView *)view heightForSectionHeaderViewAtSection:(NSInteger)section;

/**
 分区区头视图

 @param section 分区位置
 */
- (UIView *)PL_ProvidenceListMenuView:(PL_ProvidenceListMenuView *)view sectionHeaderViewAtSection:(NSInteger)section;
/**
 被选中的选项

 @param view 选项列表视图
 @param indexPath 选择的位置
 @param title 选项的标题
 */
- (void)PL_ProvidenceListMenuView:(PL_ProvidenceListMenuView *)view didSelectedAtIndexPath:(NSIndexPath *)indexPath itemTitle:(NSString *)title;

/**
 选项的标题集合

 @param view 选项列表视图
 */
- (NSArray *)itemTitlesAtPL_ProvidenceListMenuView:(PL_ProvidenceListMenuView *)view;


/**
 根据位置设置分区头标题

 @param section 分区位置
 */
- (NSString *)PL_ProvidenceListMenuView:(PL_ProvidenceListMenuView *)view sectionTitleAtSection:(NSInteger)section;



@end

/**
 简单列表视图
 */
@interface PL_ProvidenceListMenuView : UIView


/**
 初始化方法

 @param frame 尺寸
 @param identifier 标识符
 */
- (instancetype)initWithFrame:(CGRect)frame identifier:(NSString *)identifier NS_DESIGNATED_INITIALIZER;

/**
 更新标识符

 @param identifier 标识符
 */
- (void)updateIdentifier:(NSString *)identifier;

/**
 刷新源数据
 */
- (void)reloadListData;

/** 视图的唯一标识符 */
@property (readonly, copy, nonatomic) NSString *identifier;

/** 字体对象 */
@property (strong, nonatomic) UIFont *textFont;

/** 字体颜色 */
@property (strong, nonatomic) UIColor *textColor;

/** 字体对齐方式 */
@property (assign, nonatomic) NSTextAlignment textAlignment;

/** cell 高度 */
@property (assign, nonatomic) CGFloat heightForRow;

/** 代理 */
@property (weak, nonatomic) id<PL_ProvidenceListMenuViewProtocol> delegate;

/** 是否有分割线 */
@property (assign, nonatomic) BOOL isShowSeparator;



/**
 设置选中样式

 @param isSelected 是否选中
 @param indexPath 设置的选项的位置
 @param clean   是否清除当前分区的其他选项选中状态
 */
- (void)setSelectedState:(BOOL)isSelected forIndexPath:(NSIndexPath *)indexPath cleanOtherItemCurrentSection:(BOOL)clean;

/**
 清除选中状态
 */
- (void)cleanSelectedState;

/**
 展示小红点
 
 @param index 下标
 */
- (void)showBadgeWithIndex:(NSIndexPath *)index;

/**
 清除小红点
 
 @param index 下标
 */
- (void)clearBadgeWithIndex:(NSIndexPath *)index;


#pragma mark - 禁用的方法 ---

/**
 初始化方法请使用 initWithFrame:identifier:方法初始化
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 初始化方法请使用 initWithFrame:identifier:方法初始化
 */
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

/**
 初始化方法请使用 initWithFrame:identifier:方法初始化
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end


#pragma mark - 菜单标题cell -----
@interface PL_ProvidenceListMenuViewCell : UITableViewCell

/**
 TitleLabel
 */
@property (readonly, strong, nonatomic) UILabel *titleLabel;

/**
 是否显示分割线
 */
@property (assign, nonatomic) BOOL isShowSeparator;

@end
NS_ASSUME_NONNULL_END
