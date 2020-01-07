//
//  PL_ProvidenceHomeTabControlView.m
//  kkcoin
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// PL_Providenceghostlord on 2018/4/18.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "PL_ProvidenceHomeTabControlView.h"


@interface PL_ProvidenceHomeTabControlView ()

@property (readwrite, strong, nonatomic) NSArray *titles;

@property (strong, nonatomic) NSMutableArray *items;

@property (strong, nonatomic) UIScrollView *contentView;

@property (assign, nonatomic) CGFloat itemWidth;

@property (strong, nonatomic) UIView *cursorView;

@property (readwrite, assign, nonatomic) NSInteger currentIndex;

@end

@implementation PL_ProvidenceHomeTabControlView

// item 默认的tag
#define kBaseItemTag (5679)

#pragma mark - 懒加载 ---------

- (NSMutableArray *)items {
    if (!_items) {
        _items = @[].mutableCopy;
    }
    return _items;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] init];
        _contentView.showsHorizontalScrollIndicator = NO;
    }
    return _contentView;
}

- (UIView *)cursorView {
    if (!_cursorView) {
        _cursorView = [[UIView alloc] init];
        [_cursorView setBackgroundColor:self.cursorColor];
    }
    return _cursorView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self PL_Providenceinitialize];;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titles:(nonnull NSArray *)titles{
    
    if (self = [super initWithFrame:frame]) {
        
        if (titles) {
            self.titles = [titles copy];
        }
        [self PL_Providenceinitialize];;
        [self PL_ProvidenceconfigUI];
        [self PL_ProvidencesetItems];
    }
    return self;
}

#pragma mark - 布局方法  -------

- (void)PL_ProvidenceconfigUI {
    
    [self addSubview:self.contentView];
    if (self.rightView) {
        [self addSubview:self.rightView];
    }
    [self PL_ProvidencelayoutWithFrame];
}

- (void)PL_ProvidencelayoutWithFrame {
    
    if (self.rightView) {
        self.contentView.frame = CGRectMake(0, 0, self.frame.size.width - CGRectGetWidth(self.rightView.frame), self.frame.size.height);
        self.rightView.center = CGPointMake(self.frame.size.width - (self.rightView.frame.size.width / 2.0), self.frame.size.height / 2.0);
        
    }else {
        self.contentView.frame = self.bounds;
    }
}

- (void)PL_ProvidencesetItems {

    if (_contentView) {
        [_contentView removeAllSubViewAndDestroy:YES];
    }

    [self.items removeAllObjects];
    if (self.titles && self.titles.count >= 1) {

        [self PL_ProvidencerefreshItemWidth];

        CGFloat contentWidth = self.titles.count * self.itemWidth;
        self.contentView.contentSize = CGSizeMake(contentWidth > self.contentView.frame.size.width ? contentWidth : self.contentView.frame.size.width, self.contentView.frame.size.height);

        for (int a = 0; a < self.titles.count ; a ++) {
            
            UIButton * tempItem = [self PL_ProvidencegetItemAtIndex:a title:self.titles[a] ? self.titles[a] : @""];
            
            if (tempItem) {
                if (CGRectEqualToRect(tempItem.frame, CGRectZero)) {
                    tempItem.frame = CGRectMake(a * self.itemWidth, 0, self.itemWidth, self.contentView.frame.size.height);
                }
            }
            
            [self.items addObject:tempItem];
            // 添加到contentView
            [self.contentView addSubview:tempItem];
        }
        [self PL_ProvidencesetUpCursor];
    }
}

- (void)PL_ProvidenceitemAction:(UIButton *)item {
    [self PL_ProvidenceitemAction:item disabledDelegate:NO];
}

- (void)PL_ProvidenceitemAction:(UIButton *)item disabledDelegate:(BOOL)isDisabled {
    
    if (item && [self.items containsObject:item]) {
        if (item.tag) {
            NSInteger index = item.tag - kBaseItemTag;
            self.currentIndex = index;
            // 是否可以响应
            BOOL isCanResponse = YES;
            if (_delegate && [_delegate respondsToSelector:@selector(tabContolView:willSeletedItem:index:)]) {
                isCanResponse = [_delegate tabContolView:self willSeletedItem:item index:index];
            }
            if (isCanResponse) {
                if(!isDisabled && _delegate && [_delegate respondsToSelector:@selector(tabControlVeiw:didSelectedItem:index:)]) {
                    [_delegate tabControlVeiw:self didSelectedItem:item index:index];
                }
                [self PL_ProvidenceupdateItemNomalColor:self.nomalColor selectedColor:self.selectedColor];
                [self PL_ProvidenceupdateCursorViewCenterAtIndex:index animated:self.cursorAnimated];
            }
        }
    }
}

- (void)setIsShowCursor:(BOOL)isShowCursor {
    _isShowCursor = isShowCursor;
    [self PL_ProvidencesetUpCursor];
}

- (void)setCursorColor:(UIColor *)cursorColor {
    if(cursorColor && [cursorColor isKindOfClass:[UIColor class]]) {
        _cursorColor = cursorColor;
        self.cursorView.backgroundColor = _cursorColor;
    }
}

- (void)setCursorInset:(UIEdgeInsets)cursorInset {
    if (!UIEdgeInsetsEqualToEdgeInsets(_cursorInset, cursorInset)) {
        _cursorInset = cursorInset;
        [self PL_ProvidencesetItems];
    }
}

- (void)setRightView:(UIView *)rightView {
    if (rightView && !CGRectEqualToRect(CGRectZero, rightView.frame)) {
        _rightView = rightView;
        [self updateLayout];
    }
}

- (void)setNomalColor:(UIColor *)nomalColor {
    if(nomalColor && [nomalColor isKindOfClass:[UIColor class]]) {
        _nomalColor = nomalColor;
        [self PL_ProvidenceupdateItemNomalColor:_nomalColor selectedColor:self.selectedColor];
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor {
    if (selectedColor && [selectedColor isKindOfClass:[UIColor class]]) {
        _selectedColor = selectedColor;
        
        [self PL_ProvidenceupdateItemNomalColor:self.nomalColor selectedColor:_selectedColor];
    }
}

- (void)setBtnFont:(UIFont *)btnFont {
    if(btnFont) {
        _btnFont = btnFont;
        // 更新选项字体
        [self PL_ProvidenceupdateItemFont];
    }
}

#pragma mark - 公共方法 ------

- (void)selectAtIndex:(NSInteger)index disabledDelegate:(BOOL)isDisabled {
    
    if (index < self.titles.count) {
        UIButton *item = self.items[index];
        if (item.enabled) {
            [self PL_ProvidenceitemAction:item disabledDelegate:isDisabled];
        }
    }
}

- (void)selectAtTitle:(NSString *)title {
    if (title && title.length > 0) {
        if ([self.titles containsObject:title]) {
            NSInteger index = [self.titles indexOfObject:title];
            UIButton *item = self.items[index];
            if (item) {
                [self PL_ProvidenceitemAction:item disabledDelegate:NO];
            }
        }
    }
}

- (void)updateTitles:(NSArray *)titles disabledDelegate:(BOOL)isDisabled {
    
    if(titles && titles.count) {
        self.titles = [titles copy];
        
        [self updateLayout];
        
        if (self.currentIndex < self.titles.count && !isDisabled) {
            [self selectAtIndex:self.currentIndex disabledDelegate:NO];
        }
    }
}

- (void)updateTitle:(NSString *)title atIndex:(NSInteger)index {
    
    if (index < self.titles.count && title && title.length > 0) {
        // 更新标题数组
        NSMutableArray *tempTitles = [self.titles mutableCopy];
        [tempTitles replaceObjectAtIndex:index withObject:title];
        self.titles = tempTitles.copy;
        // 更新选项的标题
        UIButton *item = [self.items objectAtIndex:index];
        [item setTitle:title forState:UIControlStateNormal];
    }
}

- (void)updateLayout {
    // 移除所有子视图并置为空
    [self removeAllSubViewAndDestroy:YES];
    
    [self PL_ProvidenceconfigUI];
    
    [self PL_ProvidencesetItems];
}




- (void)PL_Providenceinitialize {

    self.defaultIndex = 0;
    self.isShowCursor = YES;
    self.itemMinWidth = 50.0f;
    self.cursorColor = [UIColor redColor];
    self.cursorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.cursorHeight = 3.0f;
    self.cursorAnimated = YES;
    self.nomalColor = [UIColor whiteColor];
    self.selectedColor = [UIColor blackColor];
}

/**
 更新选项宽度
 */
- (void)PL_ProvidencerefreshItemWidth {
    
    if (self.titles && self.titles.count) {
        
        [self PL_ProvidenceconfigUI];
        
        CGFloat averageWidth = self.contentView.frame.size.width / self.titles.count;
        
        self.itemWidth = averageWidth >= self.itemMinWidth ? averageWidth : self.itemMinWidth;
    }
}

- (UIButton *)PL_ProvidencegetItemAtIndex:(NSInteger)index title:(NSString *)title {
    
    if (isStrEmpty(title)) {
        return nil;
    }
    
    UIButton *item = nil;
    if(_delegate && [_delegate respondsToSelector:@selector(tabContolView:willCreateItemAtIndex:title:)]) {
        // 用户自定义的按钮
        item = [_delegate tabContolView:self willCreateItemAtIndex:index title:title];
    }
    
    if (!item && index < self.items.count) {
        item = [self.items objectAtIndex:index];
    }
    
    if (!item) {
        // 默认按钮
        item = [[UIButton alloc] init];
        [item setTitle:title forState:UIControlStateNormal];
        if (self.btnFont) {
            [item.titleLabel setFont:self.btnFont];
        }else {
            item.titleLabel.font = [UIFont PL_ProvidencesystemFontOfSize:14.0f];
        }
    }
    
    [item setTitleColor:self.nomalColor forState:UIControlStateNormal];
    // 设置事件和tag
    [item addTarget:self action:@selector(PL_ProvidenceitemAction:) forControlEvents:UIControlEventTouchUpInside];
    item.tag = kBaseItemTag + index;
    return item;
}

- (void)PL_ProvidencesetUpCursor {
    
    if (self.isShowCursor && self.items.count >= 1) {
        self.cursorView.frame = CGRectMake(0, self.frame.size.height - self.cursorHeight, self.itemWidth - self.cursorInset.left - self.cursorInset.right, self.cursorHeight - self.cursorInset.top - self.cursorInset.bottom);
        [self.contentView addSubview:self.cursorView];
        if (self.currentIndex > 0 && self.currentIndex < self.titles.count) {
            [self PL_ProvidenceupdateCursorViewCenterAtIndex:self.currentIndex animated:NO];
        }else if (self.defaultIndex < self.titles.count) {
            [self PL_ProvidenceupdateCursorViewCenterAtIndex:self.defaultIndex animated:self.cursorAnimated];
        }else {
            [self PL_ProvidenceupdateCursorViewCenterAtIndex:0 animated:self.cursorAnimated];
        }
        
    }else {
        if (_cursorView) {
            _cursorView.hidden = YES;
            [_cursorView removeFromSuperview];
            _cursorView = nil;
        }
    }
}

- (void)PL_ProvidenceupdateCursorViewCenterAtIndex:(NSInteger)index animated:(BOOL)animated {
    
    if(index >= self.titles.count) {
        return;
    }
    self.currentIndex = index;
    UIButton *item = self.items[index];
    
    CGPoint tempCenter = CGPointMake(item.center.x + ((self.cursorInset.left - self.cursorInset.right) / 2.0), (item.frame.size.height - (self.cursorHeight / 2.0)) - ((self.cursorInset.top - self.cursorInset.bottom) / 2.0));
    __weak typeof(self)weakSelf = self;
    [self PL_ProvidencefixContentViewOffsetWithItem:item index:index completation:^{
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [UIView animateWithDuration:animated ? 0.2 : 0.0 animations:^{
            strongSelf.cursorView.center = tempCenter;
        } completion:^(BOOL finished) {
        }];
    }];
}

- (void)PL_ProvidencefixContentViewOffsetWithItem:(UIButton *)item index:(NSInteger)index completation:(dispatch_block_t)completation {
    
    if(self.contentView.contentSize.width <= self.contentView.frame.size.width) {
        
        if (completation) {
            dispatch_async(dispatch_get_main_queue(), completation);
        }
        
        return;
    }
    
    CGFloat offSetX = item.center.x - (self.contentView.frame.size.width / 2.0);
    
    CGFloat maxOffSetX = self.contentView.contentSize.width - self.contentView.frame.size.width;
    
    if (offSetX > maxOffSetX) {
        offSetX = maxOffSetX;
    }
    
    if (offSetX < 0) {
        offSetX = 0.0f;
    }
    
    [self.contentView setContentOffset:CGPointMake(offSetX, 0) animated:YES];
    
    if (completation) {
        dispatch_async(dispatch_get_main_queue(), completation);
    }
}

- (void)PL_ProvidenceupdateItemNomalColor:(UIColor *)nomalColor selectedColor:(UIColor *)selectedColor {
    
    if (self.items && self.items.count >= 1) {
        
        for (int a = 0 ; a < self.items.count; a ++) {
            UIButton *btn = self.items[a];
            if (a == self.currentIndex) {
                [btn setTitleColor:selectedColor forState:UIControlStateNormal];
                [btn setSelected:YES];
            }else {
                [btn setSelected:NO];
                [btn setTitleColor:nomalColor forState:UIControlStateNormal];
            }
        }
    }
}

- (void)PL_ProvidenceupdateItemFont {
    
    if (self.btnFont) {
        
        for (UIButton *btn in self.items) {
            [btn.titleLabel setFont:self.btnFont];
        }
    }
}


@end

@implementation UIView (RemoveAllSubView)

- (void)removeAllSubViewAndDestroy:(BOOL)isDestroy {
    
    while (self.subviews.count) {
        UIView * tempView = self.subviews.lastObject;
        [tempView removeFromSuperview];
        
        if (isDestroy) {
            tempView = nil;
        }
    }
}
@end
