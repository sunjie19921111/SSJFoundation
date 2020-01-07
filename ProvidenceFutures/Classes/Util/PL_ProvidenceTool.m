//
//  PL_ProvidenceTool.m
//  hs
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// PXJ on 15/4/23.
//  Copyright (c) 2015年 cainiu. All rights reserved.
//

#import "PL_ProvidenceTool.h"

@implementation PL_ProvidenceTool
+ (NSString *)dealPointString:(NSString *)string;
{
    if ([string rangeOfString:@"."].location ==NSNotFound) {
        return string;
    }
    NSString * s = nil;
    NSInteger offset = string.length - 1;
    while (offset)
    {
        s = [string substringWithRange:NSMakeRange(offset, 1)];
        if ([s isEqualToString:@"0"])
        {
            offset--;
        }else if([s isEqualToString:@"."]){
            offset++;
            break;
        }else{
            break;
        }
    }
    NSString * outNumber = [string substringToIndex:offset+1];
    NSLog(@"PL_ProvidenceTool, outNumber:%@", outNumber);
    return outNumber;
}

// 根据图片url获取图片尺寸
+(CGSize)getImageSizeWithURL:(id)imageURL
{
    NSURL* URL = nil;
    if([imageURL isKindOfClass:[NSURL class]]){
        URL = imageURL;
    }
    if([imageURL isKindOfClass:[NSString class]]){
        URL = [NSURL URLWithString:imageURL];
    }
    if(URL == nil)
        return CGSizeZero;                  // url不正确返回CGSizeZero
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
    
    CGSize size = CGSizeZero;
    if([pathExtendsion isEqualToString:@"png"]){
        size =  [self getPNGImageSizeWithRequest:request];
    }
    else if([pathExtendsion isEqual:@"gif"])
    {
        size =  [self getGIFImageSizeWithRequest:request];
    }
    else{
        size = [self getJPGImageSizeWithRequest:request];
    }
    if(CGSizeEqualToSize(CGSizeZero, size))                    // 如果获取文件头信息失败,发送异步请求请求原图
    {
        NSData* data = [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:URL] returningResponse:nil error:nil];
        UIImage* image = [UIImage imageWithData:data];
        if(image)
        {
            size = image.size;
        }
    }
    return size;
}

+(NSString *)nullTrimString:(id)aID{
    if (aID != nil && ![aID isKindOfClass:[NSNull class]] && ![[NSString stringWithFormat:@"%@",aID] isEqualToString:@"(null)"]) {
        return [NSString stringWithFormat:@"%@",aID];
    }
    else{
        return @"";
    }
}

+(BOOL)nullTrim:(id)aID{
    if (aID != nil && ![aID isKindOfClass:[NSNull class]] && ![[NSString stringWithFormat:@"%@",aID] isEqualToString:@"(null)"] && ![[NSString stringWithFormat:@"%@",aID] isEqualToString:@"<null>"]) {
        return YES;
    }
    else{
        return NO;
    }
}
//  获取PNG图片的大小
+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 8)
    {
        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        [data getBytes:&w3 range:NSMakeRange(2, 1)];
        [data getBytes:&w4 range:NSMakeRange(3, 1)];
        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
        [data getBytes:&h1 range:NSMakeRange(4, 1)];
        [data getBytes:&h2 range:NSMakeRange(5, 1)];
        [data getBytes:&h3 range:NSMakeRange(6, 1)];
        [data getBytes:&h4 range:NSMakeRange(7, 1)];
        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取gif图片的大小
+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if(data.length == 4)
    {
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0, 1)];
        [data getBytes:&w2 range:NSMakeRange(1, 1)];
        short w = w1 + (w2 << 8);
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(2, 1)];
        [data getBytes:&h2 range:NSMakeRange(3, 1)];
        short h = h1 + (h2 << 8);
        return CGSizeMake(w, h);
    }
    return CGSizeZero;
}
//  获取jpg图片的大小
+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
{
    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    if ([data length] <= 0x58) {
        return CGSizeZero;
    }
    
    if ([data length] < 210) {// 肯定只有一个DQT字段
        short w1 = 0, w2 = 0;
        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
        short w = (w1 << 8) + w2;
        short h1 = 0, h2 = 0;
        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
        short h = (h1 << 8) + h2;
        return CGSizeMake(w, h);
    } else {
        short word = 0x0;
        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
        if (word == 0xdb) {
            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
            if (word == 0xdb) {// 两个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            } else {// 一个DQT字段
                short w1 = 0, w2 = 0;
                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
                short w = (w1 << 8) + w2;
                short h1 = 0, h2 = 0;
                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
                short h = (h1 << 8) + h2;
                return CGSizeMake(w, h);
            }
        } else {
            return CGSizeZero;
        }
    }
}
+ (UIImage *)imageFromColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}


+ (NSString *)addHttp:(NSString *)urlStr;{
    if ([urlStr rangeOfString:@"http"].location !=NSNotFound){
    }else{
        urlStr = [NSString stringWithFormat:@"%@%@",K_HTTP,urlStr];
    }
    return urlStr;
}

+ (NSMutableDictionary *)getParams:(NSString *)aParamsStr{
    NSMutableDictionary *paramsDic = [NSMutableDictionary dictionaryWithCapacity:0];
    NSArray *carveArray = [aParamsStr componentsSeparatedByString:@"&"];
    for (int i = 0; i < carveArray.count; i++) {
        NSArray *array =[carveArray[i] componentsSeparatedByString:@"="];
        if (array.count >= 2) {
            if (array.count==2) {
                [paramsDic setObject:array[1] forKey:array[0]];
            }else{
                NSString * value = array[1];
                for ( int i=2; i<array.count; i++) {
                    value = [NSString stringWithFormat:@"%@=%@",value,array[i]];
                }
                [paramsDic setObject:value forKey:array[0]];
            }
        }
    }
    return paramsDic;
}


#pragma mark - InterpolatedUIImage=因为生成的二维码是一个CIImage，我们直接转换成UIImage的话大小不好控制，所以使用下面方法返回需要大小的UIImage
+ (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size {
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    // create a bitmap image that we'll draw into a bitmap context at the desired size;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    // Create an image with the contents of our bitmap
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // Cleanup
    UIImage *qrImage = [UIImage imageWithCGImage:scaledImage];
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    CGImageRelease(scaledImage);
    CGColorSpaceRelease(cs);
    return qrImage;
}

#pragma mark - QRCodeGenerator--首先是二维码的生成，使用CIFilter很简单，直接传入生成二维码的字符串即可
+ (CIImage *)createQRForString:(NSString *)qrString {
    // Need to convert the string to a UTF-8 encoded NSData object
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // Create the filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // Set the message content and error-correction level
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // Send the image back
    return qrFilter.outputImage;
}




#pragma mark UIImageView加圆形边框

+(UIImageView*)imageCutView:(UIImageView*)imgV cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth color:(UIColor*)color;
{

    imgV.layer.cornerRadius = cornerRadius;
    imgV.layer.masksToBounds = YES;
    imgV.layer.borderWidth = borderWidth;
    imgV.layer.borderColor = color.CGColor;
    return imgV;
}

#pragma mark 获得随机数)
+(NSString *)randomGet
{
    
    int num = arc4random()%9999;
    return [NSString stringWithFormat:@"%d",num];
}
#pragma mark 转换json字符串
+(NSString *)toJSON:(id)aParam
{
    NSData   *jsonData=[NSJSONSerialization dataWithJSONObject:aParam options:NSJSONWritingPrettyPrinted error:nil];
    NSString *jsonStr=[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}
#pragma mark 字符串转字典
+(NSDictionary *)dicWithJSonStr:(NSString *)jsonString
{
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
     NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    return dic;
    
}

+(id )objectWithJSonStr:(NSString *)jsonString
{
    NSData * jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    id sender = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:nil];
    return sender;
    
}
+ (NSString *)judgeStr:(id)str
{
    NSString *str1 = [NSString stringWithFormat:@"%@",str];
    if ([str1 isEqualToString:@"<null>"]||[str1 isEqualToString:@"(null)"]) {
        return @"";
    }
    else
    {
        return [PL_ProvidenceTool isNullString:str1] != 0?@"":str1;
    }
}
+ (BOOL)isNullString:(NSString *)string
{
    if(string == nil){
        return YES;
    }
    
    if ((NSNull *)string == [NSNull null]) {
        return YES;
    }
    
    string = [string stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([string length] == 0){
        return YES;
    }
    return NO;
}
#pragma mark 判断期货单位
+ (NSString*)unitWithCurrency:(NSString*)currency
{

    NSString * unit;
        if ([currency isEqualToString:@"USD"])//美元
        {
            unit = @"美元";
            
        }else if([currency isEqualToString:@"CNY"])//人民币
        {
            unit = @"元";
            
        }else if([currency isEqualToString:@"SGD"])//新加坡币
        {
            unit = @"元";
            
        }else if([currency isEqualToString:@"HKD"])//港元
        {
            unit = @"港元";
            
        }else{
        unit = @"美元";
        }
    return unit;
}
#pragma mark 金额加‘，’
//传入整数类型的数值
+(NSString *)countNumChangeformat:(NSString *)num
{
    int count = 0;
    long long int a = num.longLongValue;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *string = [NSMutableString stringWithString:num];
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3)
    {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    return newstring;
}

#pragma mark 传入小数位为num位的数值  (1) aStr: 传入字符串 （2）num: 小数位数

+(NSString *)addSign:(NSString *)aStr num:(int)num
{
    
    NSString *point;
    NSString *money;
    if (num==0) {
        return [PL_ProvidenceTool countNumChangeformat:aStr];
    }else{
        if (aStr.floatValue ==0) {
            aStr = @"0.00";
            return aStr;
        }
        
        point =[aStr substringFromIndex:aStr.length-num-1];
        money =[aStr substringToIndex:aStr.length-num-1];
        return [[PL_ProvidenceTool countNumChangeformat:money] stringByAppendingString:point];
    }
}


/**
 *根据小数位数整理字符串加三位分割符“，”
 */
+(NSString *)rangeFloatString:(NSString*)floatString withDecimalPlaces:(int)decimalPlaces;
{
    NSString * floatStr;
    float value = floatString.doubleValue;
    NSString * str = @"";
    if (value>=100000||value<=-100000) {
        str = @"万";
        floatString = [NSString stringWithFormat:@"%f",floatString.doubleValue/10000];
    }
    
    switch (decimalPlaces) {
        case 0:
        {
            floatStr = [NSString stringWithFormat:@"%.0f",floatString.doubleValue];
        }
            break;
        case 1:
        {
            floatStr = [NSString stringWithFormat:@"%.1f",floatString.doubleValue];
        }
            break;
        case 2:
        {
            floatStr = [NSString stringWithFormat:@"%.2f",floatString.doubleValue];
        }
            break;
        case 3:
        {
            floatStr = [NSString stringWithFormat:@"%.3f",floatString.doubleValue];
        }
            break;
        case 4:
        {
            floatStr = [NSString stringWithFormat:@"%.4f",floatString.doubleValue];
        }
            break;
        case 5:
        {
            floatStr = [NSString stringWithFormat:@"%.5f",floatString.doubleValue];
        }
            break;
        case 6:
        {
            floatStr = [NSString stringWithFormat:@"%.6f",floatString.doubleValue];
        }
            break;
        case 7:
        {
            floatStr = [NSString stringWithFormat:@"%.7f",floatString.doubleValue];
        }
            break;
        case 8:
        {
            floatStr = [NSString stringWithFormat:@"%.8f",floatString.doubleValue];
        }
            break;
        default:
            break;
    }
    floatStr = [PL_ProvidenceTool addSign:floatStr num:decimalPlaces];
    return [floatStr stringByAppendingString:str];
}


/**
 * 根据小数位数整理字符串 不加三位分割符
 */
+(NSString *)rangeNumString:(NSString*)floatString withDecimalPlaces:(int)decimalPlaces;
{
    NSString * floatStr;
//    float value = floatString.doubleValue;
//    NSString * str = @"";
//    if (value>=100000||value<=-100000) {
//        str = @"万";
//        floatString = [NSString stringWithFormat:@"%f",floatString.floatValue/10000];
//    }
    
    switch (decimalPlaces) {
        case 0:
        {
            floatStr = [NSString stringWithFormat:@"%.0f",floatString.doubleValue];
        }
            break;
        case 1:
        {
            floatStr = [NSString stringWithFormat:@"%.1f",floatString.doubleValue];
        }
            break;
        case 2:
        {
            floatStr = [NSString stringWithFormat:@"%.2f",floatString.doubleValue];
        }
            break;
        case 3:
        {
            floatStr = [NSString stringWithFormat:@"%.3f",floatString.doubleValue];
        }
            break;
        case 4:
        {
            floatStr = [NSString stringWithFormat:@"%.4f",floatString.doubleValue];
        }
            break;
        case 5:
        {
            floatStr = [NSString stringWithFormat:@"%.5f",floatString.doubleValue];
        }
            break;
        case 6:
        {
            floatStr = [NSString stringWithFormat:@"%.6f",floatString.doubleValue];
        }
            break;
        case 7:
        {
            floatStr = [NSString stringWithFormat:@"%.7f",floatString.doubleValue];
        }
            break;
        case 8:
        {
            floatStr = [NSString stringWithFormat:@"%.8f",floatString.doubleValue];
        }
            break;
        default:
            break;
    }
    return floatStr;
}

#pragma mark 转换时间格式，（1）intTime 要转化的格式 （2）intFormat 原格式   （3）要转换的格式  @"yyyy-MM-dd HH:mm:ss"

+(NSString *)timeTransform:(NSString*)intTime intFormat:(NSString*)intFormat  toFormat:(NSString*)toFormat
{
    //字符串转时间
    NSDateFormatter * dateFormatter =  [PL_ProvidenceDateManager sharedInstance].dateFormatter;
    [dateFormatter setDateFormat:intFormat];
    NSDate * timeDate = [dateFormatter dateFromString:intTime];
    [dateFormatter setDateFormat:toFormat];
    NSString * toTime = [dateFormatter stringFromDate:timeDate];
    
//    NSDateFormatter * intF = [[NSDateFormatter alloc]init];
//    [intF setDateFormat:intFormat];
    
//    NSDateFormatter * toF = [[NSDateFormatter alloc] init];
//    [toF setDateFormat:toFormat];
//    
////    NSDate * timeDate = [intF dateFromString:intTime];
//    NSString * toTime = [toF stringFromDate:timeDate];
    
    return toTime;

}

#pragma mark 计算时间

+(NSString *)timeDifferNowdate:(NSDate*)newDate oldTime:(NSString*)oldTime
{
    ;
    NSDateFormatter * dm = [PL_ProvidenceDateManager sharedInstance].dateFormatter;
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [dm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * oldDate = [dm dateFromString:oldTime];
    long dd = (long)[newDate timeIntervalSince1970] - [oldDate timeIntervalSince1970];
    NSString *timeString=@"";
    if (dd/300<1)
    {
        timeString=[NSString stringWithFormat:@"刚刚"];
    }else
    if (dd/3600<1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/60];
        timeString=[NSString stringWithFormat:@"%@分钟前", timeString];
    }else
    if (dd/3600>=1&&dd/86400<1)
    {
        timeString = [NSString stringWithFormat:@"%ld", dd/3600];
        timeString=[NSString stringWithFormat:@"%@小时前", timeString];
    }else
    if (dd/86400>=1)
    {
        
       [dm setDateFormat:@"yyyy-MM-dd"];
        timeString = [dm stringFromDate:oldDate];
    }
    
    
    return timeString;
}
//返回分钟差
+ (NSInteger)countTimeWithNewTime:(NSString *)newTime lastDate:(NSString *)lastTime
{
    NSDateFormatter * forMatter = [PL_ProvidenceDateManager sharedInstance].dateFormatter;
    [forMatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate * newDate = [forMatter dateFromString:newTime];
    NSDate * lastDate = [forMatter dateFromString:lastTime];

    long dd = (long)[newDate timeIntervalSince1970] - [lastDate timeIntervalSince1970];
    return (NSInteger)dd;
}

//返回天数
+ (int)timeSysTime:(NSString *)sysTime createTime:(NSString*)createTime
{

    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    [dm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter * ds = [[NSDateFormatter alloc]init];
    [ds setDateFormat:@"yyyy-MM-dd"];
    NSDate * sysDate = [dm dateFromString:sysTime];
    NSString * sysStr = [ds stringFromDate:sysDate];
    sysStr = [NSString stringWithFormat:@"%@ 00:00:00",sysStr];
    sysDate = [dm dateFromString:sysStr];
    
    NSDate * createDate = [dm dateFromString:createTime];
    NSString * createStr = [ds stringFromDate:createDate];
    createStr = [NSString stringWithFormat:@"%@ 00:00:00",createStr];
    createDate=[dm dateFromString:createStr];
    
     long dd = (long)[sysDate timeIntervalSince1970] - [createDate timeIntervalSince1970];
    if (dd/86400>=1) {
        
    }
    return (int)dd/86400;
}


//返回相差天数
+ (int)timeSysDateStr:(NSString *)sysTime createDateStr:(NSString*)createTime
{
    
    
    NSDateFormatter * dm = [[NSDateFormatter alloc]init];
    [dm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDateFormatter * ds = [[NSDateFormatter alloc]init];
    [ds setDateFormat:@"yyyy-MM-dd"];
    NSDate * sysDate = [ds dateFromString:sysTime];
    NSString * sysStr = [ds stringFromDate:sysDate];
    sysStr = [NSString stringWithFormat:@"%@ 00:00:00",sysStr];
    sysDate = [dm dateFromString:sysStr];
    
    NSDate * createDate = [ds dateFromString:createTime];
    NSString * createStr = [ds stringFromDate:createDate];
    createStr = [NSString stringWithFormat:@"%@ 00:00:00",createStr];
    createDate=[dm dateFromString:createStr];
    
    long dd = (long)[sysDate timeIntervalSince1970] - [createDate timeIntervalSince1970];
    if (dd/86400>=1) {
        
    }
    return (int)dd/86400;
}




+ (NSString*)numberOfDaysFromTodayByTime:(NSDate *)newDate timeStringFormat:(NSString *)oldTime
{
    
    
    //(NSInteger)numberOfDaysFromTodayByTime:(NSString *)time timeStringFormat:(NSString *)format
    NSDateFormatter * dm = [PL_ProvidenceDateManager sharedInstance].dateFormatter;
    //指定输出的格式   这里格式必须是和上面定义字符串的格式相同，否则输出空
    [dm setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate * oldDate = [dm dateFromString:oldTime];
    long dd = (long)[newDate timeIntervalSince1970] - [oldDate timeIntervalSince1970];
    NSString *timeString=[oldTime componentsSeparatedByString:@" "][0];
    if (dd/86400<1)
    {
        timeString=@"今天";
    }//    NSLog(@"=====%@",timeString);
    return timeString;
}
//给UILabel设置行间距和字间距
+(NSDictionary *)setTextLineSpaceWithString:(NSString*)str withFont:(UIFont*)font withLineSpace:(CGFloat)lineSpace withTextlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing{

    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace; //设置行间距
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    //设置字间距 NSKernAttributeName:@1.5f
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle,
                          NSKernAttributeName:textlengthSpace
                          };
//    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:str attributes:dic];
//    label.attributedText = attributeStr;
    return dic;
}



#pragma mark - 根据字符串计算字符串宽度
+ (CGFloat)calculateTheHightOfText:(NSString *)text height:(CGFloat)height font:(UIFont*)font
{
    CGFloat width = 0.0;
    NSDictionary *dicParam = @{NSFontAttributeName:font};
    CGRect rect = [text  boundingRectWithSize:CGSizeMake(0, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:dicParam context:nil];
    
    width = rect.size.width;
    
    dicParam = nil;
    return width;
}

#pragma mark -计算UILabel的高度(带有行间距的情况)
+ (CGFloat)getSpaceLabelHeight:(NSString*)str withFont:(UIFont*)font withLineSpace:(CGFloat)lineSpace size:(CGSize)textSize textlengthSpace:(NSNumber *)textlengthSpace paragraphSpacing:(CGFloat)paragraphSpacing{
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpace;
    paraStyle.paragraphSpacing = paragraphSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle,
                          NSKernAttributeName:textlengthSpace
                          };
    CGSize size = [str boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
    return size.height;
}

#pragma mark - 根据字符串计算字符串的高度和宽度
+ (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize
{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attrs context:nil].size;
}

+(NSMutableAttributedString *)addDeleteLineWithString:(NSString*)string;
{
    NSMutableAttributedString *attri = [[NSMutableAttributedString alloc] initWithString:string];
    [attri addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, string.length)];
    return attri;
}
+(NSMutableAttributedString *)addDeleteLineWithAttributedString:(NSMutableAttributedString*)attributedString;
{
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle) range:NSMakeRange(0, attributedString.string.length)];
    return attributedString;
}

//属性字符串字号
+(NSMutableAttributedString *)multiplicityText:(NSString *)aStr from:(int)fontFrom to:(int)fontTo font:(float)aFont
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:aStr];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:aFont] range:NSMakeRange(fontFrom, fontTo)];
    
    return str;
}

//属性字符串字号
+(NSMutableAttributedString *)mulFontText:(NSAttributedString *)mulStr from:(int)fontFrom to:(int)fontTo font:(float)aFont
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:mulStr];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:aFont] range:NSMakeRange(fontFrom, fontTo)];
    
    return str;
}



//属性字符串颜色
+(NSMutableAttributedString *)multiplicityText:(NSString *)aStr from:(int)colorFrom to:(int)colorTo color:(UIColor *)color
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:aStr];
    
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(colorFrom,colorTo)];
    
    return str;
}
//属性字符串颜色传入可变字符串；
+(NSMutableAttributedString *)multableText:(NSAttributedString *)mutableStr from:(int)colorFrom to:(int)colorTo color:(UIColor *)color;
{
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithAttributedString:mutableStr];
    
    [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(colorFrom,colorTo)];
    return str;
}


+(NSMutableAttributedString *)mutableFontAndColorText:(NSString *)aStr
                                                 from:(int)fontFrom
                                                   to:(int)fontTo
                                                 font:(float)Font
                                                 from:(int)colorFrom
                                                   to:(int)colorTo
                                                color:(UIColor *)Color
{
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:aStr];
    
    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:Font] range:NSMakeRange(fontFrom, fontTo)];
    
    NSMutableAttributedString * mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
    [mulStr addAttribute:NSForegroundColorAttributeName value:Color range:NSMakeRange(colorFrom, colorTo)];
    
    
    
    
    return mulStr;
    
}
//时间转字符串

+ (NSString *)stringFromDate:(NSDate *)date{
    
    NSDateFormatter *dateFormatter = [PL_ProvidenceDateManager sharedInstance].dateFormatter;
    
    
    
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    
    
    return destDateString;
    
}

+ (BOOL)checkTel:(NSString *)str
{
    
    
    
    //1[0-9]{10}
    
    //^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$
    
    //    NSString *regex = @"[0-9]{11}";
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0-9])|(17[7]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (isMatch == NO) {
        return NO;
    }
    return YES;
    
}
+ (NSString *)switchErrorMessage:(NSString * )str
{
    NSString * errorMessage = nil;
    
    
    NSString *errorStr = str;
    NSScanner *scanner = [NSScanner scannerWithString:errorStr];
    [scanner scanUpToCharactersFromSet:[NSCharacterSet decimalDigitCharacterSet] intoString:nil];
    int number;
    [scanner scanInt:&number];
    
    
    switch (number) {
        case 200:
        {
            errorMessage = @"请求响应成功";
            
        }
            break;
        case 400:
        {
            errorMessage = @"访问被禁止";
            
        }
            break;
        case 401:
        {
            errorMessage = @"登录受限";
            
        }
            break;
        case 404:
        {
            errorMessage = @"资源定位失败";
            
        }
            break;
        case 406:
        {
            errorMessage = @"请求参数有错";
            
        }
            break;
        case 412:
        {
            errorMessage = @"绘画过期";
            
        }
            break;
        case 500:
        {
            errorMessage = @"服务器请求处理失败";
            
        }
            break;
        case 505:
        {
            errorMessage = @"服务器错误";
            
        }
            break;
        case 999:
        {
            errorMessage = @"未知错误";
            
        }
            break;
            
            
        default:
        {
            errorMessage = str;
            
        }
            break;
    }
    
    
    
    
    return errorMessage;
    
    
}

@end
