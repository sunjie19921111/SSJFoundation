//
//  PL_ProvidenceDataUsedEngine.h
//  hs
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// RGZ on 15/10/28.
//  Copyright © 2015年 luckin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PL_ProvidenceDataUsedEngine : NSObject

/*
 aDataArray:两段字符串，第二段字符串改变颜色
 */
+(NSMutableAttributedString *)mutableColorWithDataArray:(NSMutableArray *)aDataArray lastColor:(UIColor*)aColor;

#pragma mark 计算宽高
+ ( CGSize )getStringRectWithString:( NSString *)aString Font:(int)aFont Width:(float)aWidth Height:(float)aHeight;

+(UIWindow *)getWindow;

#pragma mark 小数位转换
+(NSString *)conversionFloatNum:(double)aFloat ExpectFloatNum:(int)aFloatNum;
#pragma mark 时区转换
+(NSDate *)timeZoneChange:(NSDate *)aOldDate;
#pragma mark 属性字符串
+(NSMutableAttributedString *)mutableFontAndColorArray:(NSMutableArray *)aDataArray fontArray:(NSMutableArray *)aFontArray colorArray:(NSMutableArray *)aColorArray;
#pragma mark 删除线属性字符串
+(NSMutableAttributedString *)mutableFontAndColorArrayAddDeleteLine:(NSMutableArray *)aDataArray fontArray:(NSMutableArray *)aFontArray colorArray:(NSMutableArray *)aColorArray;

+(NSMutableAttributedString *)mutableFontArray:(NSMutableArray *)aDataArray fontArray:(NSMutableArray *)aFontArray;



//去空转空String
+(NSString *)nullTrimString:(id)aID;
//去空转期望String
+(NSString *)nullTrimString:(id)aID expectString:(NSString *)aString;
//判断是否为空
+(BOOL)nullTrim:(id)aID;
//json字符串装换成json对象
+ (id)toJsonObjectWithJsonString:(NSString *)jsonStr;
//json对象转换成json字符串
+ (NSString *)toJsonStringWithJsonObject:(id)jsonObject;

//获取IP
+ (NSString *)getIPAddress:(BOOL)preferIPv4;

//Net
+ (NSString *)getNetconnType;
@end
