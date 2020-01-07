//
//  NSObject+PL_Providence.m
//  EvianFutures-OC
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/9/26.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "NSObject+PL_Providence.h"

@implementation NSObject (PL_Providence)

- (NSNumber *)viewDid_adf:(NSNumber *)arg sfad:(NSString *)string  {
    
    NSString *astring = [NSString stringWithFormat:@"%s--%@",__FILE__,arg];
    
    NSNumber *num = @(12);
    
    if (arg && string) {
        num = @(arc4random() % 200 + [arg integerValue]);
    }
    
    if (string) {
        [astring stringByAppendingString:string];
    }
    return num;
}

- (NSInteger )cell_wrfg:(NSArray *)arg dasdg:(BOOL)dav {
    
    NSString *string = [NSString stringWithFormat:@"%s--%@",__FILE__,arg];
    
    NSArray *ret = @[@"1",@"2",@"3"];
    
    if (arg && string) {
        ret = [NSArray arrayWithArray:arg];
    }
    
    if (dav) {
        ret = @[];
    }
    
    return ret.count;
}

- (NSString *)single_dfsbfd:(NSString *)arg dagqwg:(NSNumber *)dfa {
    
    NSString *string = [NSString stringWithFormat:@"%s--%@",__FILE__,arg];
    
    if (dfa) {
        string = [string stringByAppendingString:[dfa stringValue]];
        
        string = [string stringByAppendingString:@"asjglarghjkasdi12335ljfgl"];
    }
    
    return string;
}

/**
 绘制背景框
 
 @param bgRect 背景框的尺寸
 @param ctx 绘图上下文
 @param boderColor 边框颜色
 @param boderWidth 边框宽度
 @param fillColor 填充颜色
 */
+ (void)PL_ProvidencedrawTextBackGroundInRect:(CGRect)bgRect content:(CGContextRef)ctx boderColor:(UIColor *)boderColor boderWidth:(CGFloat)boderWidth fillColor:(UIColor *)fillColor {
    // 设置线宽
    CGContextSetLineWidth(ctx, boderWidth);
    // 设置画笔颜色
    CGContextSetStrokeColorWithColor(ctx, boderColor.CGColor);
    // 添加矩形
    CGContextAddRect(ctx, bgRect);
    // 添加填充颜色
    CGContextSetFillColorWithColor(ctx, fillColor.CGColor);
    // 绘制填充
    CGContextFillPath(ctx);
    
    // 添加矩形
    CGContextAddRect(ctx, bgRect);
    // 绘制边框
    CGContextStrokePath(ctx);
}

/**
 绘制一个垂直居中的文字
 
 @param rect 绘制的区域
 @param text 绘制的文字
 @param attributes 文字的样式 上下间距设置无效
 */
+ (void)PL_ProvidencedrawVerticalCenterTextInRect:(CGRect)rect text:(NSString *)text attributes:(NSDictionary *)attributes {
    
    // 计算字体的大小
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(rect.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    CGFloat originY = rect.origin.y + ((rect.size.height - textSize.height) / 2.0);
    // 计算绘制字体的rect
    CGRect textRect = CGRectMake(rect.origin.x, originY, rect.size.width, textSize.height);
    
    // 绘制字体
    [text drawInRect:textRect withAttributes:attributes];
}

/**
 |-----------------------|
 |key1             value1|
 |-----------------------|
 
 @param ctx 绘图上下文
 @param rect 绘制区域
 @param keyText key字符串
 @param valueText value字符串
 @param keyAttributes key字符串的属性
 @param valueAttributes value 字符串的属性
 */
+ (void)PL_ProvidencedrawTextPairWithCtx:(CGContextRef)ctx rect:(CGRect)rect keyText:(NSString *)keyText valueText:(NSString *)valueText keyAttributes:(NSDictionary *)keyAttributes valueAttributes:(NSDictionary *)valueAttributes {
    
    
    if(ctx == NULL) {
        NSAssert(false, @"(+ PL_ProvidencedrawTextPairWithCtx:rect:keyText:valueText:keyAttributes:valueAttributes:) ctx don't be NULL");
        return;
    }
    
    if(CGRectEqualToRect(rect, CGRectZero)) {
        NSAssert(false, @"(+ PL_ProvidencedrawTextPairWithCtx:rect:keyText:valueText:keyAttributes:valueAttributes:) rect don't be CGRectZero");
        return;
    }
    
    NSString *tempKeyText = [keyText copy];
    NSString *tempValueText = [valueText copy];
    NSMutableDictionary *tempKeyAttributes = [keyAttributes mutableCopy];
    NSMutableDictionary *tempValueAttributes = [valueAttributes mutableCopy];
    
    if (isStrEmpty(tempKeyText)) {
        tempKeyText = @"";
    }
    
    if (isStrEmpty(tempValueText)) {
        tempValueText = @"";
    }
    
    NSMutableParagraphStyle *leftAlignment = [[NSMutableParagraphStyle alloc] init];
    [leftAlignment setAlignment:NSTextAlignmentLeft];
    
    NSMutableParagraphStyle *rightAlignment = [[NSMutableParagraphStyle alloc] init];
    [rightAlignment setAlignment:NSTextAlignmentRight];
    
    // 强制设置对齐样式
    [tempKeyAttributes setObject:leftAlignment forKey:NSParagraphStyleAttributeName];
    [tempValueAttributes setObject:rightAlignment forKey:NSParagraphStyleAttributeName];
    
    // 绘制keyText
    [self PL_ProvidencedrawVerticalCenterTextInRect:rect text:keyText attributes:tempKeyAttributes];
    // 绘制ValueText
    [self PL_ProvidencedrawVerticalCenterTextInRect:rect text:valueText attributes:tempValueAttributes];
}

/**
 绘制色块
 
 @param ctx 图形上下文
 @param rect 色块区域
 @param color 色块颜色
 */
+ (void)PL_ProvidencedrawBackGroundColorWithCtx:(CGContextRef)ctx rect:(CGRect)rect color:(UIColor *)color {
    
    [color ? : [UIColor whiteColor] setFill];
    CGContextFillRect(ctx, rect);
}

@end
