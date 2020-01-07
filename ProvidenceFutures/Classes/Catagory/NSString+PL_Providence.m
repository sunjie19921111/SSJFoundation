//
//  NSString+PL_Providence.m
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
//.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "NSString+PL_Providence.h"
#import <CommonCrypto/CommonDigest.h>
#import "GTMBase64.h"

static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=";

@implementation NSString (PL_Providence)

+ (NSString*)encodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64String:(NSString * )input {
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)encodeBase64Data:(NSData *)data {
    data = [GTMBase64 encodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

+ (NSString*)decodeBase64Data:(NSData *)data {
    data = [GTMBase64 decodeData:data];
    NSString *base64String = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return base64String;
}

- (NSString *)MD5Digest
{
    const char* input = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(input, (CC_LONG)strlen(input), result);
    
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    
    return digest;
}

/**
 修复数字字符串的小数位数限制
 
 @param numString 数字字符串
 @param minDecimal 最小小数位数限制
 @param maxDecimal 最大小数位数限制
 */
+ (NSString * _Nullable)PL_ProvidencefixNumString:(NSString * _Nonnull)numString minDecimalsLimit:(NSInteger)minDecimal maxDecimalsLimit:(NSInteger)maxDecimal; {
    
    // 判断合法性
    if ([numString isEqualToString:@"NaN"] || [numString isEqualToString:@"nan"] || [numString isEqualToString:@"NAN"] || numString.length <= 0) {
        numString = @"0";
    }
    
    NSNumber *tempNum = [numString PL_ProvidencedigitalValue];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans_CN"];
    
    // 设置数字样式为小数
    formatter.numberStyle = NSNumberFormatterNoStyle;
    // 最小整数位数为1
    formatter.minimumIntegerDigits = 1;
    // 设置进位模式
    formatter.roundingMode = kCFNumberFormatterRoundDown;
    // 设置最小小数位数限制
    if (minDecimal >= 0) {
        formatter.minimumFractionDigits = minDecimal;
    }
    // 设置最大小数位数限制
    if (maxDecimal >= 0) {
        formatter.minimumFractionDigits = maxDecimal;
    }
    
    // 从上述格式生成数字对应字符串
    NSString *result = [formatter stringFromNumber:tempNum];
    
    return result ? : @"";
}

/* 将字符串转换为小数对象 */
- (NSDecimalNumber *)PL_ProvidencedigitalValue {
    
    NSDecimalNumber *decimalNum = nil;
    
    if (!isStrEmpty(self) && [self isKindOfClass:[NSString class]]) {
        decimalNum = [[NSDecimalNumber alloc] initWithString:self];
    }
    
    return decimalNum;
}

+ (NSString * _Nullable)PL_ProvidenceconvertTimeStamp:(NSTimeInterval)timeStamp toFormatter:(NSString *)formatterString {
    
    NSString *result = @"";
    // 生成NSDate对象
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    // 生成日期格式对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    // 设置格式
    if (formatterString && formatterString.length >= 1) {
        [dateFormatter setDateFormat:formatterString];
    }
    // 根据格式导出日期
    result = [dateFormatter stringFromDate:date];
    return result;
}

+ (NSString * _Nullable)PL_ProvidenceconvertToDisplayStringWithOriginNum:(NSString * _Nonnull)numString decimalsLimit:(NSInteger)decimal prefix:(NSString *_Nullable)prefix suffix:(NSString * _Nullable)suffix {
    // 判断合法性
    if ([numString isEqualToString:@"NaN"] || [numString isEqualToString:@"nan"] || [numString isEqualToString:@"NAN"] || numString.length <= 0) {
        numString = @"0";
    }
    
    NSNumber *tempNum = [numString PL_ProvidencedigitalValue];;
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans_CN"];
    // 设置数字样式为小数
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    // 最小整数位数为1
    formatter.minimumIntegerDigits = 1;
    // 设置整数分割位数
    [formatter setGroupingSize:3];
    // 设置进位模式
    formatter.roundingMode = kCFNumberFormatterRoundDown;
    // 最多小数位数为8
    formatter.maximumFractionDigits = 8;
    
    // 设置小数位数限制
    if (decimal >= 0) {
        formatter.minimumFractionDigits = decimal;
        formatter.maximumFractionDigits = decimal;
    }
    
    // 设置前缀
    if(prefix && prefix.length >= 1) {
        formatter.positivePrefix = prefix;
    }
    
    //    // 设置后缀(此种方法小数负数失效)
    //    if (suffix && suffix.length >= 1) {
    //        formatter.positiveSuffix = suffix;
    //    }
    
    // 从上述格式生成数字对应字符串
    NSString *result = [formatter stringFromNumber:tempNum];
    
    if (suffix && suffix.length >= 1) {
        result = [result stringByAppendingString:suffix];
    }
    
    return result ? : @"";
}



+ (NSString *)localStringFromUTCDate:(NSDate *)UTCDate {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:tz];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString* result=[dateFormatter stringFromDate:UTCDate];
    return result;
}

+ (NSString *)localStringFromDate:(NSDate *)Date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    NSTimeZone *tz = [NSTimeZone defaultTimeZone];
    [dateFormatter setTimeZone:tz];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString* result=[dateFormatter stringFromDate:Date];
    return result;
}

+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate{
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    
    [dateformater setDateFormat:@"yyyy-MM-dd"];
    
    NSDate*dta = [[NSDate alloc]init];
    
    NSDate*dtb = [[NSDate alloc]init];

    dta = [dateformater dateFromString:aDate];
    
    dtb = [dateformater dateFromString:bDate];
    
    NSComparisonResult result = [dta compare:dtb];
    
    
    
    if (result == NSOrderedDescending) {
        
        //指定时间 已过期
        
        return 1;
        
    }else if(result ==NSOrderedAscending){
        
        //指定时间 没过期
        
        return-1;
        
    } else {
        
        //刚好时间一样.
        
        return 0;
        
    }
    
    
    
}

/**
 获得今天开始的时间戳
 
 @return 今天0点的时间戳
 */
+ (NSDate *)PL_ProvidencegetTodayStartStamp {
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *todayCom = [calendar components:(NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay) fromDate:[NSDate date]];
    
    NSDate *todayDate = [calendar dateFromComponents:todayCom];
    
    return todayDate;
}

/**
 将当前字符串根据条件生成一个简单的属性字符串
 
 @param font 字体
 @param color 字体颜色
 @return 属性字符串
 */
- (NSAttributedString *)PL_ProvidencecreateAttributedStringWithFont:(UIFont * _Nullable)font textColor:(UIColor *_Nullable)color {
    
    NSString *tempStr = isStrEmpty(self) ? @"" : [self copy];
    UIFont *tempFont = font ? : [UIFont systemFontOfSize:17.0f];
    UIColor *tempColor = color ? : [UIColor blackColor];
    
    return [[NSAttributedString alloc] initWithString:tempStr attributes:@{NSFontAttributeName:tempFont,NSForegroundColorAttributeName:tempColor}];
}

+ (NSString*)pathForDocumentDirectory {
    static NSString* documentPath = nil;
    if (documentPath == nil) {
        NSArray* paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask,
                                                             YES);
        documentPath = [paths objectAtIndex:0];
    }
    return documentPath;
}

- (NSString *)pathInDocumentDirectory {
    return [[[self class] pathForDocumentDirectory] stringByAppendingPathComponent:self];
}

@end
