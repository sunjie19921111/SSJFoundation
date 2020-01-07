//
//  PL_ProvidenceSimpleKLineVolView.m
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


#import "PL_ProvidenceVerticalView.h"
#import "PL_ProvidenceLineVolViewConfig.h"
#import "PL_ProvidenceLineDrawLogic.h"
#import "PL_ProvidenceLineTimeDrawLogic.h"
#import "PL_ProvidenceLineBGDrawLogic.h"
#import "PL_ProvidenceLineMADrawLogic.h"
#import "PL_ProvidenceLineVolDrawLogic.h"
#import "PL_ProvidenceLineVolMADrawLogic.h"
#import <Masonry/Masonry.h>
#import "PL_ProvidenceSimpleKLineVolView.h"
#import "NSNumber+StringFormatter.h"
#import "PL_ProvidenceDataCenter.h"
#import "PL_ProvidenceHorizontalView.h"


@interface PL_ProvidenceSimpleKLineVolView ()<PL_ProvidenceLineDataLogicProtocol,DataCenterProtocol>
/** mainViewConfig */



/**
 十字线的竖线视图
 */
@property (strong, nonatomic) UIView *verticalLineView;

/**
 十字线的水平文字显示视图
 */
@property (strong, nonatomic) PL_ProvidenceHorizontalView *horizontalTextView;

/**
 十字线的水平线视图
 */
@property (strong, nonatomic) UIView *horizontalLineView;

/**
 详情视图
 */
@property (strong, nonatomic) PL_ProvidenceDataCenter *detailView;
@property (strong, nonatomic) PL_ProvidenceLineViewConfig *mainViewConfig;
@property (strong, nonatomic) PL_ProvidenceLineVolViewConfig *volViewConfig;

/** 当前的主图样式 */
@property (assign, nonatomic) KLineMainViewType mainViewType;

/** 当前显示的区域 */
@property (assign, nonatomic) CGPoint currentVisibleRange;

/** 每个item的宽度 */
@property (assign, nonatomic) CGFloat perItemWidth;

/** 时间绘制的点的集合 */
@property (strong, nonatomic) NSMutableArray *timePointArray;
@property (strong, nonatomic) PL_ProvidenceVerticalView *verticalTextView;

@end

@implementation PL_ProvidenceSimpleKLineVolView

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self PL_Providenceinitialize];;
        
        [self PL_ProvidenceconfigUI];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    if ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count <= 0) {
        return;
    }
    
    // 绘制时间
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    // 开始和结束的K线下标
    NSInteger beginItemIndex = floor(self.currentVisibleRange.x);
    NSInteger endItemIndex = ceil(self.currentVisibleRange.y);
    
    // 每个时间之间的间隔K线条数
    NSInteger timeGapCount = (endItemIndex - beginItemIndex) / 4;
    // 每个时间之间的间隔宽度
    CGFloat timeGapWidth = self.kLineMainView.frame.size.width / 4.0;
    
    if (beginItemIndex < 0) {
        beginItemIndex = 0;
    }
    // 修正最后一个元素下标，防止数组越界
    if (endItemIndex >= [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count) {
        endItemIndex = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
    }
    
    [self.timePointArray removeAllObjects];
    // 要绘制的时间的下标
    NSInteger drawIndex = endItemIndex;
    // 要绘制的时间区域的中心X坐标
    CGFloat drawCenterX = rect.size.width - ((self.currentVisibleRange.y - drawIndex) * self.perItemWidth);
    // point.x:表示要绘制的时间的下标，y:表示这个时间绘制区域的中心X
    CGPoint drawPoint = CGPointMake(drawIndex, drawCenterX);
    
    [self.timePointArray addObject:@(drawPoint)];
    
    if(ceil(self.currentVisibleRange.y) <= ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1) && self.currentVisibleRange.x > 0) {
        // 不能看到最后一根K线
        while (drawIndex >= beginItemIndex && drawIndex >= 0) {
            
            drawIndex = drawIndex - (timeGapWidth / self.perItemWidth);
            drawCenterX -= timeGapWidth;
            
            drawPoint = CGPointMake(drawIndex, drawCenterX);
            [self.timePointArray addObject:@(drawPoint)];
        }
        
    }else {
        // 可以看到最后一根K线
        
        while (drawCenterX > 0 && drawIndex > 0) {
            
            if(drawIndex <= timeGapCount) {
                drawCenterX -= self.perItemWidth * drawIndex;
                drawIndex = 0;
            }else {
                drawIndex -= timeGapCount;
                drawCenterX -= self.perItemWidth * timeGapCount;
            }
            
            drawPoint = CGPointMake(drawIndex, drawCenterX);
            [self.timePointArray addObject:@(drawPoint)];
        }
    }
    
    // 绘制时间
    [self PL_ProvidencedrawTimeWithContent:ctx];
}



/**
 绘制文字
 
 @param ctx 上下文
 @param rect 文字绘制区域
 */
- (void)PL_ProvidencedrawText:(NSString *)text content:(CGContextRef)ctx textRect:(CGRect)rect {
    // 左边坐标修正
    if (rect.origin.x < 0 && self.currentVisibleRange.y <= ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1)) {
        rect.origin.x = 0;
    }
    
    
    // 居中
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.alignment = NSTextAlignmentCenter;
    // 属性：字体，颜色，居中
    NSDictionary *attributes = @{
                                 NSFontAttributeName:[UIFont PL_ProvidencesystemFontOfSize:12.0f],       // 字体
                                 NSForegroundColorAttributeName:[UIColor colorWithHexString:@"0x666666"],   // 字体颜色
                                 NSParagraphStyleAttributeName:style,   // 段落样式
                                 };;
    
    // 计算字体的大小
    CGSize textSize = [text sizeWithAttributes:attributes];
    
    // 右边坐标修正
    if (CGRectGetMaxX(rect) > CGRectGetMaxX(self.kLineMainView.frame)) {
        rect.origin.x = self.frame.size.width - textSize.width;
    }
    
    
    CGFloat originY = rect.origin.y + ((rect.size.height - textSize.height) / 2.0);
    
    // 计算绘制字体的rect
    CGRect textRect = CGRectMake(rect.origin.x, originY , textSize.width , textSize.height );
    
    // 绘制字体
    [text drawInRect:textRect withAttributes:attributes];
}

#pragma mark - 初始化等方法 -------

- (void)PL_Providenceinitialize {
    
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 默认的一个K线的宽度为实体线的宽度与K线之间的间隙的和
    self.perItemWidth = ([self.kLineMainView.config defaultEntityLineWidth] + [self.kLineMainView.config klineGap]) * 1.0;
    // 默认的显示区域
    self.currentVisibleRange = self.kLineMainView.dataLogic.visibleRange;
    // 默认显示K线样式
    self.mainViewType = KLineMainViewTypeKLineWithMA;
    // 添加代理
    [self.kLineMainView.dataLogic addDelegate:self];
    [self.dataCenter addDelegate:self];
}

- (void)PL_ProvidenceconfigUI {
    
    [self addSubview:self.kLineMainView];
    [self addSubview:self.volView];

    [self PL_Providencelayout];
}

- (void)PL_Providencelayout {
    
    [self.kLineMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.height.mas_equalTo(self.mas_height).multipliedBy(0.7);
    }];
    
    [self.volView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.kLineMainView.mas_bottom).offset(20.0f);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
}

#pragma mark - PL_ProvidenceLineDataLogic Delegate ----
// 可见区域改变
- (void)visibleRangeDidChanged:(CGPoint)visibleRange scale:(CGFloat)scale {
    // 保存可见区域
    self.currentVisibleRange = visibleRange;
    // 计算当前的每个元素的宽度
    self.perItemWidth = ([self.kLineMainView.config defaultEntityLineWidth] + [self.kLineMainView.config klineGap]) * scale;
    NSLog(@"visibleRange = %f,%f",visibleRange.x,visibleRange.y);
    // 重绘时间
    [self setNeedsDisplay];
}

// 十字线是否展示
- (void)reticleIsShow:(BOOL)isShow {
    
    if(isShow) {
        [self addSubview:self.detailView];
        [self addSubview:self.verticalLineView];
        [self addSubview:self.verticalTextView];
        [self addSubview:self.horizontalTextView];
        [self addSubview:self.horizontalLineView];
    }else {
        [self.detailView removeFromSuperview];
        [self.verticalLineView removeFromSuperview];
        [self.verticalTextView removeFromSuperview];
        [self.horizontalTextView removeFromSuperview];
        [self.horizontalLineView removeFromSuperview];
    }
}

/**
 KLineView 上触点移动的回调方法(十字线移动)
 
 @param view 触点起始的View
 @param point point 点击的点
 @param index index 当前触点所在item的下标
 */
- (void)klineView:(PL_ProvidenceZSHKLineView *)view didMoveToPoint:(CGPoint)point selectedItemIndex:(NSInteger)index {
    
    if (index >= [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count || index < 0) {
        NSLog(@"下标有误，不能绘制");

        return;
    }
    // 垂直线 -----
    // 根据index获得选中item的中心X坐标
    CGFloat textCenterX = [self PL_ProvidencegetCurrentSelectedItemCenterXWithIndex:index];
    
    if (textCenterX >= self.kLineMainView.frame.size.width) {
        textCenterX = self.kLineMainView.frame.size.width;
    }
    
    PL_ProvidenceKLineModel *tempModel = [[DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray objectAtIndex:index];
    NSString *dateString = [NSString PL_ProvidenceconvertTimeStamp:(tempModel.stamp / 1000) toFormatter:@"yy-MM-dd HH:mm"];
    [self.verticalTextView updateText:dateString textCenterX:textCenterX];
    self.verticalLineView.center = CGPointMake(textCenterX, (self.frame.size.height - 20.f) / 2.0f);
    
    // 水平线 -------
    CGPoint pointAtSuperView = point;
    if (view == self.volView) {
        pointAtSuperView = [view convertPoint:point toView:self];
    }
    
    CGFloat touchY = pointAtSuperView.y;
//    NSLog(@"point At superView = %@",NSStringFromCGPoint(pointAtSuperView));
    // 修正十字线水平文字边界
    if (touchY < 10.0f) {
        self.horizontalTextView.frame = CGRectMake(0, 0, self.frame.size.width, 20.0f);
        self.horizontalLineView.frame = CGRectMake(0, (touchY - 0.5f) >=0 ? (touchY - 0.5f) : 0, self.frame.size.width, 1.0);
        
    }else if(touchY > self.frame.size.height - 10.0f) {
        self.horizontalTextView.frame = CGRectMake(0, self.frame.size.height - 20.0f, self.frame.size.width, 20.0f);
        self.horizontalLineView.frame = CGRectMake(0, (touchY - 0.5f) <= (self.frame.size.height - 1.5f)? (touchY - 0.5f) : self.frame.size.height - 1.5f, self.frame.size.width, 1.0);
        
    }else if(touchY >= (CGRectGetMaxY(self.kLineMainView.frame) - 10.0f) && touchY <= CGRectGetMaxY(self.kLineMainView.frame)) {
        
        self.horizontalTextView.frame = CGRectMake(0, CGRectGetMaxY(self.kLineMainView.frame) - 20.0f, self.frame.size.width, 20.0f);
        self.horizontalLineView.frame = CGRectMake(0, (touchY - 0.5f) >=0 ? (touchY - 0.5f) : 0, self.frame.size.width, 1.0);
        
    }else if(touchY <= (CGRectGetMinY(self.volView.frame) + 10.0f) && touchY >= CGRectGetMinY(self.volView.frame)) {
        self.horizontalTextView.frame = CGRectMake(0, CGRectGetMinY(self.volView.frame), self.frame.size.width, 20.0f);
        self.horizontalLineView.frame = CGRectMake(0, (touchY - 0.5f) >=0 ? (touchY - 0.5f) : 0, self.frame.size.width, 1.0);
        
    }else {
        if (!(touchY > CGRectGetMaxY(self.kLineMainView.frame) && touchY < CGRectGetMinY(self.volView.frame))) {
            self.horizontalTextView.frame = CGRectMake(0, touchY - 10.0f, self.frame.size.width, 20.0f);
            self.horizontalLineView.frame = CGRectMake(0, (touchY - 0.5f) >=0 ? (touchY - 0.5f) : 0, self.frame.size.width, 1.0);
            
        }
    }
    
    if (touchY <= CGRectGetMaxY(self.kLineMainView.frame) && touchY >= 0) {
        
        double currentNum = (self.kLineMainView.currentExtremeValue.maxValue - self.kLineMainView.currentExtremeValue.minValue) * (1.0 - (touchY - [self.kLineMainView.config insertOfKlineView].top) / (CGRectGetHeight(self.kLineMainView.frame) - ([self.kLineMainView.config insertOfKlineView].top + [self.kLineMainView.config insertOfKlineView].bottom))) + self.kLineMainView.currentExtremeValue.minValue;
        
        if (currentNum < self.kLineMainView.currentExtremeValue.minValue) {
            currentNum = self.kLineMainView.currentExtremeValue.minValue;
        }else if(currentNum > self.kLineMainView.currentExtremeValue.maxValue) {
            currentNum = self.kLineMainView.currentExtremeValue.maxValue;
        }
        
        NSString *currentNumString = [@(currentNum) PL_ProvidencenumberToStringWithDecimalsLimit:[DataCenter shareCenter].decimalsLimit];
        [self.horizontalTextView updateText:currentNumString];
    }else if(touchY >= CGRectGetMinY(self.volView.frame) && touchY <= CGRectGetMaxY(self.volView.frame)) {
        
        touchY = touchY - CGRectGetMinY(self.volView.frame);
        double currentNum = (self.volView.currentExtremeValue.maxValue - self.volView.currentExtremeValue.minValue) * (1.0 - (touchY - [self.volView.config insertOfKlineView].top)/ (CGRectGetHeight(self.volView.frame) - ([self.volView.config insertOfKlineView].top + [self.volView.config insertOfKlineView].bottom))) + self.volView.currentExtremeValue.minValue;
        
        if (currentNum < self.volView.currentExtremeValue.minValue) {
            currentNum = self.volView.currentExtremeValue.minValue;
        }else if(currentNum > self.volView.currentExtremeValue.maxValue) {
            currentNum = self.volView.currentExtremeValue.maxValue;
        }
        
        NSString *currentNumString = [NSString stringWithFormat:@"%f",currentNum];
        [self.horizontalTextView updateText:currentNumString];
    }
    
    CGSize horizontalTextSize = [self.horizontalTextView getCurrentTextSize];
    
    if (point.x <= (self.frame.size.width / 2.0)) {
        CGRect newTextRect = self.horizontalTextView.frame;
        newTextRect.origin.x = self.frame.size.width - horizontalTextSize.width;
        self.horizontalTextView.frame = newTextRect;
        
        CGRect newLineRect = self.horizontalLineView.frame;
        newLineRect.origin.x = 0.0f;
        newLineRect.size.width = self.frame.size.width - horizontalTextSize.width;
        self.horizontalLineView.frame = newLineRect;
        // 详情视图
        [self PL_ProvidenceshowDetailViewWithPL_ProvidenceHSFKLineModel:tempModel isLeft:YES];
    }else {
        
        CGRect newLineRect = self.horizontalLineView.frame;
        newLineRect.origin.x = horizontalTextSize.width;
        newLineRect.size.width = self.frame.size.width - horizontalTextSize.width;
        self.horizontalLineView.frame = newLineRect;
        // 详情视图
        [self PL_ProvidenceshowDetailViewWithPL_ProvidenceHSFKLineModel:tempModel isLeft:NO];
    }
}

/**
 数据已经刷新
 
 @param dataCenter 数据中心
 @param modelArray 刷新后的数据
 */
- (void)dataCenter:(DataCenter *)dataCenter didReload:(NSArray *)modelArray {
    // 默认的显示区域
    self.currentVisibleRange = self.kLineMainView.dataLogic.visibleRange;
    [self setNeedsDisplay];
}

/**
 数据已经被清空
 
 @param dataCenter 数据中心
 */
- (void)dataDidCleanAtDataCenter:(DataCenter *)dataCenter {
    // 默认的显示区域
    self.currentVisibleRange = self.kLineMainView.dataLogic.visibleRange;
    [self setNeedsDisplay];
}

/**
 在尾部添加了最新数据
 
 @param dataCenter 数据中心
 @param modelArray 添加后的数据
 */
- (void)dataCenter:(DataCenter *)dataCenter didAddNewDataInTail:(NSArray *)modelArray {
    // 默认的显示区域
    self.currentVisibleRange = self.kLineMainView.dataLogic.visibleRange;
    [self setNeedsDisplay];
}

/**
 在头部添加了数据
 
 @param dataCenter 数据中心
 @param modelArray 添加后的数据
 */
- (void)dataCenter:(DataCenter *)dataCenter didAddNewDataInHead:(NSArray *)modelArray {
    // 默认的显示区域
    self.currentVisibleRange = self.kLineMainView.dataLogic.visibleRange;
    [self setNeedsDisplay];
}

#pragma mark - 公共方法 -----

/**
 切换主图样式
 */
- (void)switchKLineMainViewToType:(KLineMainViewType)type {
    
    if (type && type != self.mainViewType) {
        self.mainViewType = type;
        
        switch (type) {
        
            case KLineMainViewTypeKLine:    // 只有K线
            {
                [self.kLineMainView removeAllDrawLogic];
                
                [self.kLineMainView addDrawLogic:[[PL_ProvidenceLineDrawLogic alloc] initWithDrawLogicIdentifier:@"k_line"]];
                [self.kLineMainView addDrawLogic:[[PL_ProvidenceLineBGDrawLogic alloc] initWithDrawLogicIdentifier:@"main_bg"]];

            }
                break;
                
                
            case KLineMainViewTypeKLineWithMA:  // K线+MA
            {// 主图切为分时蜡烛图
                
                [self.kLineMainView removeAllDrawLogic];
                
                [self.kLineMainView addDrawLogic:[[PL_ProvidenceLineDrawLogic alloc] initWithDrawLogicIdentifier:@"k_line"]];
                [self.kLineMainView addDrawLogic:[[PL_ProvidenceLineMADrawLogic alloc] initWithDrawLogicIdentifier:@"main_ma_5_10_30"]];
                [self.kLineMainView addDrawLogic:[[PL_ProvidenceLineBGDrawLogic alloc] initWithDrawLogicIdentifier:@"main_bg"]];

            }
                break;
                
                case  KLineMainViewTypeTimeLine:    // 只有分时线
            {
                [self.kLineMainView removeAllDrawLogic];
                [self.kLineMainView addDrawLogic:[[PL_ProvidenceLineTimeDrawLogic alloc] initWithDrawLogicIdentifier:@"main_time"]];
                [self.kLineMainView addDrawLogic:[[PL_ProvidenceLineBGDrawLogic alloc] initWithDrawLogicIdentifier:@"main_bg"]];

            }
                break;
                
                
            case KLineMainViewTypeTimeLineWithMA:   // 分时线+MA
            {  // 主图样式切换为分时图
                
                [self.kLineMainView removeAllDrawLogic];
                [self.kLineMainView addDrawLogic:[[PL_ProvidenceLineTimeDrawLogic alloc] initWithDrawLogicIdentifier:@"main_time"]];
                PL_ProvidenceLineMADrawLogic *timeMA = [[PL_ProvidenceLineMADrawLogic alloc] initWithDrawLogicIdentifier:@"main_time_ma_30"];
                [timeMA setMa5Hiden:YES];
                [timeMA setMa10Hiden:YES];
                [self.kLineMainView addDrawLogic:timeMA];
                [self.kLineMainView addDrawLogic:[[PL_ProvidenceLineBGDrawLogic alloc] initWithDrawLogicIdentifier:@"main_bg"]];

            }
                break;
                
            default:
                break;
        }
    }
}

/**
 重新绘制
 缩放比例还是按照之前显示的比例
 @param drawType 绘制时采用的类型
 */
- (void)reDrawWithType:(ReDrawType)drawType {
    
    if (_kLineMainView) {
        [self.kLineMainView reDrawWithType:drawType];
    }
    
    if (_volView) {
        [self.volView reDrawWithType:drawType];
    }
}

#pragma mark - 私有方法 -------

/**
 根据下标获得特定的元素的中心x坐标
 
 @param index 下标
 */
- (CGFloat)PL_ProvidencegetCurrentSelectedItemCenterXWithIndex:(NSInteger)index {
    CGFloat centerX = 0.0f;
    centerX = (index - self.currentVisibleRange.x + 0.5) * self.perItemWidth;
    return centerX;
}

- (void)PL_ProvidenceshowDetailViewWithPL_ProvidenceHSFKLineModel:(PL_ProvidenceKLineModel *)model isLeft:(BOOL)isLeft {
    
    if (!model) {
        return;
    }
    
    // 时间
    DetailDataModel *timeModel = [[DetailDataModel alloc] initWithName:@"日期" desc:[NSString PL_ProvidenceconvertTimeStamp:(model.stamp / 1000) toFormatter:@"yy-MM-dd hh:mm"]];
    // 开
    DetailDataModel *openModel = [[DetailDataModel alloc] initWithName:@"开" desc:[@(model.open) PL_ProvidencenumberToStringWithDecimalsLimit:self.kLineMainView.dataCenter.decimalsLimit]];
    // 高
    DetailDataModel *highModel = [[DetailDataModel alloc] initWithName:@"高" desc:[@(model.high) PL_ProvidencenumberToStringWithDecimalsLimit:self.kLineMainView.dataCenter.decimalsLimit]];
    
    // 低
    DetailDataModel *lowModel = [[DetailDataModel alloc] initWithName:@"低" desc:[@(model.low) PL_ProvidencenumberToStringWithDecimalsLimit:self.kLineMainView.dataCenter.decimalsLimit]];
    
    // 收
    DetailDataModel *closeModel = [[DetailDataModel alloc] initWithName:@"收" desc:[@(model.close) PL_ProvidencenumberToStringWithDecimalsLimit:self.kLineMainView.dataCenter.decimalsLimit]];
    
    // 量
    DetailDataModel *volModel = [[DetailDataModel alloc] initWithName:@"量" desc:[@(model.volume) stringValue]];
    
    [self.detailView updateContentWithDetailModels:@[timeModel,openModel,highModel,lowModel,closeModel,volModel]];
    
    CGRect newFrame = self.detailView.frame;
    if (isLeft) {
        newFrame.origin.x = self.frame.size.width - newFrame.size.width;
    }else {
        newFrame.origin.x = 0.0f;
    }
    
    self.detailView.frame = newFrame;
}

#pragma mark - 懒加载 ---------

- (PL_ProvidenceZSHKLineView *)kLineMainView {
    if (!_kLineMainView) {
        _kLineMainView = [[PL_ProvidenceZSHKLineView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.height - 20.0f) * 7.0/10.0) config:self.mainViewConfig];
        _kLineMainView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
        // 添加绘图算法
        [_kLineMainView addDrawLogic:[[PL_ProvidenceLineDrawLogic alloc] initWithDrawLogicIdentifier:@"k_line"]];
        [_kLineMainView addDrawLogic:[[PL_ProvidenceLineBGDrawLogic alloc] initWithDrawLogicIdentifier:@"main_bg"]];
        [_kLineMainView addDrawLogic:[[PL_ProvidenceLineMADrawLogic alloc] initWithDrawLogicIdentifier:@"main_ma_5_10_30"]];
    }
    return _kLineMainView;
}

- (PL_ProvidenceZSHKLineView *)volView {
    if (!_volView) {
        _volView = [[PL_ProvidenceZSHKLineView alloc] initWithFrame:CGRectMake(0, (CGRectGetMaxY(self.kLineMainView.frame) + 20.0f), self.frame.size.width, ((self.frame.size.height - 20.0f) * 3.0/10.0)) config:self.volViewConfig];
        _volView.backgroundColor = [UIColor colorWithHexString:@"0xffffff"];
        // 替换逻辑处理对象为主图逻辑处理对象
        [_volView replaceDataLogicWithLogic:self.kLineMainView.dataLogic];
        
        // 添加绘图算法
        [_volView addDrawLogic:[[PL_ProvidenceLineVolDrawLogic alloc] initWithDrawLogicIdentifier:@"vol"]];
        [_volView addDrawLogic:[[PL_ProvidenceLineVolMADrawLogic alloc] initWithDrawLogicIdentifier:@"vol_ma"]];
        PL_ProvidenceLineBGDrawLogic *bgLogic = [[PL_ProvidenceLineBGDrawLogic alloc] initWithDrawLogicIdentifier:@"vol_bg"];
        bgLogic.isHideMidDial = YES;
        [_volView addDrawLogic:bgLogic];
    }
    return _volView;
}

- (PL_ProvidenceLineViewConfig *)mainViewConfig {
    if (!_mainViewConfig) {
        _mainViewConfig = [[PL_ProvidenceLineViewConfig alloc] init];
    }
    return _mainViewConfig;
}

- (PL_ProvidenceLineVolViewConfig *)volViewConfig {
    if (!_volViewConfig) {
        _volViewConfig = [[PL_ProvidenceLineVolViewConfig alloc] init];
    }
    return _volViewConfig;
}

- (DataCenter *)dataCenter {
    
    if (!_dataCenter) {
        _dataCenter = [self.kLineMainView dataCenter];
    }
    return _dataCenter;
}

- (NSMutableArray *)timePointArray {
    if (!_timePointArray) {
        _timePointArray = [[NSMutableArray alloc] init];
    }
    return _timePointArray;
}

- (PL_ProvidenceVerticalView *)verticalTextView {
    if (!_verticalTextView) {
        _verticalTextView = [[PL_ProvidenceVerticalView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 20.0f, self.frame.size.width, 20.0f)];
        _verticalTextView.userInteractionEnabled = NO;
    }
    return _verticalTextView;
}

- (UIView *)verticalLineView {
    if (!_verticalLineView) {
        _verticalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1.0f, self.frame.size.height - CGRectGetHeight(self.verticalTextView.frame))];
        [_verticalLineView setBackgroundColor:[UIColor colorWithHexString:@"0x333333"]];
        _horizontalLineView.userInteractionEnabled = NO;

    }
    return _verticalLineView;
}

- (PL_ProvidenceHorizontalView *)horizontalTextView {
    if (!_horizontalTextView) {
        _horizontalTextView = [[PL_ProvidenceHorizontalView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 20.0f)];
        _horizontalTextView.userInteractionEnabled = NO;
    }
    return _horizontalTextView;
}

- (UIView *)horizontalLineView {
    if (!_horizontalLineView) {
        _horizontalLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 1.0f)];
        _horizontalLineView.backgroundColor = [UIColor colorWithHexString:@"0x333333"];
        _horizontalLineView.userInteractionEnabled = NO;
    }
    return _horizontalLineView;
}

- (PL_ProvidenceDataCenter *)detailView {
    if (!_detailView) {
        _detailView = [[PL_ProvidenceDataCenter alloc] initWithFrame:CGRectMake(0, 20.0f, 150.0f, 0.0f)];
    }
    return _detailView;
}



/**
 绘制时间
 
 @param ctx 绘图上下文
 */
- (void)PL_ProvidencedrawTimeWithContent:(CGContextRef)ctx {
    CGFloat originY = CGRectGetMaxY(self.kLineMainView.frame);
    CGFloat width = 50.0f;
    CGFloat height = 20.0f;
    
    for (NSInteger a = 0; a < self.timePointArray.count ; a ++) {
        CGPoint tempPoint = [self.timePointArray[a] CGPointValue];
        if (tempPoint.x < 0) {
            tempPoint.x = 0;
        }else if(tempPoint.x > ([DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1)) {
            tempPoint.x = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray.count - 1;
        }
        PL_ProvidenceKLineModel *tempModel = [DataCenter shareCenter].PL_ProvidenceHSFKLineModelArray[(NSInteger)tempPoint.x];
        NSString *timeString = [NSString PL_ProvidenceconvertTimeStamp:(tempModel.stamp / 1000) toFormatter:@"HH:mm"];
        CGRect textRect = CGRectMake(tempPoint.y - (width / 2.0), originY, width, height);
        [self PL_ProvidencedrawText:timeString content:ctx textRect:textRect];
    }
}

@end
