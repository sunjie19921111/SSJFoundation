//
//  PL_ProvidenceDataUsedEngine.m
//  hs
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// RGZ on 15/10/28.
//  Copyright © 2015年 luckin. All rights reserved.
//

#import "PL_ProvidenceDataUsedEngine.h"

//#import "NetReachability.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <net/if.h>
#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
#define IOS_VPN         @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation PL_ProvidenceDataUsedEngine

#pragma mark Net

+ (NSString *)getNetconnType{
    
    NSString *netconnType = @"";
    
//    NetReachability *reach = [NetReachability reachabilityWithHostName:@"www.apple.com"];
//
//    switch ([reach currentReachabilityStatus]) {
//        case NotReachable:// 没有网络
//        {
//
//            netconnType = @"no network";
//        }
//            break;
//
//        case ReachableViaWiFi:// Wifi
//        {
//            netconnType = @"Wifi";
//        }
//            break;
//
//        case ReachableViaWWAN:// 手机自带网络
//        {
//            // 获取手机网络类型
//            CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
//
//            NSString *currentStatus = info.currentRadioAccessTechnology;
//
//            if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyGPRS"]) {
//
//                netconnType = @"GPRS";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyEdge"]) {
//
//                netconnType = @"2.75G EDGE";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyWCDMA"]){
//
//                netconnType = @"3G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSDPA"]){
//
//                netconnType = @"3.5G HSDPA";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyHSUPA"]){
//
//                netconnType = @"3.5G HSUPA";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMA1x"]){
//
//                netconnType = @"2G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORev0"]){
//
//                netconnType = @"3G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevA"]){
//
//                netconnType = @"3G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyCDMAEVDORevB"]){
//
//                netconnType = @"3G";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyeHRPD"]){
//
//                netconnType = @"HRPD";
//            }else if ([currentStatus isEqualToString:@"CTRadioAccessTechnologyLTE"]){
//
//                netconnType = @"4G";
//            }
//        }
//            break;
//
//        default:
//            break;
//    }
    
    return netconnType;
}


#pragma mark 小数位转换

+(NSString *)conversionFloatNum:(double)aFloat ExpectFloatNum:(int)aFloatNum{
    NSString  *resultStr = @"";
    if (aFloatNum == 0) {
        resultStr = [NSString stringWithFormat:@"%.0f",aFloat];
    }
    else if (aFloatNum == 1){
        resultStr = [NSString stringWithFormat:@"%.1f",aFloat];
    }
    else if (aFloatNum == 2){
        resultStr = [NSString stringWithFormat:@"%.2f",aFloat];
    }
    else if (aFloatNum == 3){
        resultStr = [NSString stringWithFormat:@"%.3f",aFloat];
    }
    else if (aFloatNum == 4){
        resultStr = [NSString stringWithFormat:@"%.4f",aFloat];
    }
    else if (aFloatNum == 5){
        resultStr = [NSString stringWithFormat:@"%.5f",aFloat];
    }
    else if (aFloatNum == 6){
        resultStr = [NSString stringWithFormat:@"%.6f",aFloat];
    }
    else if (aFloatNum == 7){
        resultStr = [NSString stringWithFormat:@"%.7f",aFloat];
    }
    else if (aFloatNum == 8){
        resultStr = [NSString stringWithFormat:@"%.8f",aFloat];
    }
    return resultStr;
}

+(NSDate *)timeZoneChange:(NSDate *)aOldDate{
    NSTimeZone *zoneCurrent = [NSTimeZone systemTimeZone];
    NSInteger intervalCurrentFront = [zoneCurrent secondsFromGMTForDate: aOldDate];
    NSDate *newDate = [aOldDate  dateByAddingTimeInterval: intervalCurrentFront];
    return newDate;
}

//DataArray:str     fontArray:string      colorArray:redColor whiteColor
+(NSMutableAttributedString *)mutableFontAndColorArrayAddDeleteLine:(NSMutableArray *)aDataArray fontArray:(NSMutableArray *)aFontArray colorArray:(NSMutableArray *)aColorArray
{
    NSMutableAttributedString * mulStr;
    
    if ((aFontArray != nil && aFontArray.count > 0) && (aColorArray != nil && aColorArray.count > 0)) {
        NSString    *allStr = @"";
        for (int i = 0; i < aDataArray.count; i++) {
            allStr = [allStr stringByAppendingString:aDataArray[i]];
        }
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allStr];
        for (int i = 0; i < aDataArray.count; i++) {
            
            int font = [aFontArray[i] intValue];
            
            UIColor* color= nil;
            NSArray *floatArray = [aColorArray[i] componentsSeparatedByString:@"/"];
            color = [UIColor colorWithRed:[floatArray[0] floatValue]/255.0 green:[floatArray[1] floatValue]/255.0 blue:[floatArray[2] floatValue]/255.0 alpha:[floatArray[3] floatValue]];
            
            if(i == 0){
                
                int from = 0;
                
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:font] range:NSMakeRange(from, [aDataArray[i] length])];
                [str addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(from, [aDataArray[i] length])];
                
                [str addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(from,[aDataArray[i] length])];
                
                mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
                [mulStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                str = [[NSMutableAttributedString alloc] initWithAttributedString:mulStr];;
            }
            else{
                int from = 0;
                
                for (int j = 0; j <= i-1 ; j++) {
                    from += [aDataArray[j] length];
                }
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:font] range:NSMakeRange(from, [aDataArray[i] length])];
                
                mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
                [mulStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                str = [[NSMutableAttributedString alloc] initWithAttributedString:mulStr];;
            }
        }
    }
    else if (aFontArray != nil && aFontArray.count > 0){
        NSString    *allStr = @"";
        for (int i = 0; i < aDataArray.count; i++) {
            allStr = [allStr stringByAppendingString:aDataArray[i]];
        }
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allStr];
        for (int i = 0; i < aDataArray.count-1; i++) {
            
            int font = [aFontArray[i] intValue];
            
            if(i == 0){
                int from = 0;
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:font] range:NSMakeRange(from, [aDataArray[i] length])];
            }
            else{
                int from = 0;
                for (int j = 0; j <= i-1 ; j++) {
                    from += [aDataArray[j] length];
                }
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:font] range:NSMakeRange(from, [aDataArray[i] length])];
            }
        }
    }
    else if (aColorArray != nil && aColorArray.count > 0){
        NSString    *allStr = @"";
        for (int i = 0; i < aDataArray.count; i++) {
            allStr = [allStr stringByAppendingString:aDataArray[i]];
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allStr];
        for (int i = 0; i < aDataArray.count-1; i++) {
            UIColor* color= nil;
            NSArray *floatArray = [aColorArray[i] componentsSeparatedByString:@"/"];
            color = [UIColor colorWithRed:[floatArray[0] floatValue]/255.0 green:[floatArray[1] floatValue]/255.0 blue:[floatArray[2] floatValue]/255.0 alpha:[floatArray[3] floatValue]];
            
            if(i == 0){
                int from = 0;
                [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
                
                str = [[NSMutableAttributedString alloc] initWithAttributedString:mulStr];;
            }
            else{
                int from = 0;
                for (int j = 0; j <= i-1 ; j++) {
                    from += [aDataArray[j] length];
                }
                [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
                [mulStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                str = [[NSMutableAttributedString alloc] initWithAttributedString:mulStr];;
            }
        }
    }
    return mulStr;
}

//DataArray:str     fontArray:string      colorArray:redColor whiteColor
+(NSMutableAttributedString *)mutableFontAndColorArray:(NSMutableArray *)aDataArray fontArray:(NSMutableArray *)aFontArray colorArray:(NSMutableArray *)aColorArray
{
    NSMutableAttributedString * mulStr;
    
    if ((aFontArray != nil && aFontArray.count > 0) && (aColorArray != nil && aColorArray.count > 0)) {
        NSString    *allStr = @"";
        for (int i = 0; i < aDataArray.count; i++) {
            allStr = [allStr stringByAppendingString:aDataArray[i]];
        }
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allStr];
        for (int i = 0; i < aDataArray.count-1; i++) {
            
            int font = [aFontArray[i] intValue];
            
            UIColor* color= nil;
            NSArray *floatArray = [aColorArray[i] componentsSeparatedByString:@"/"];
            color = [UIColor colorWithRed:[floatArray[0] floatValue]/255.0 green:[floatArray[1] floatValue]/255.0 blue:[floatArray[2] floatValue]/255.0 alpha:[floatArray[3] floatValue]];
            
            if(i == 0){
                
                int from = 0;
                
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:font] range:NSMakeRange(from, [aDataArray[i] length])];
                
                mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
                [mulStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                str = [[NSMutableAttributedString alloc] initWithAttributedString:mulStr];;
            }
            else{
                int from = 0;
                
                for (int j = 0; j <= i-1 ; j++) {
                    from += [aDataArray[j] length];
                }
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:font] range:NSMakeRange(from, [aDataArray[i] length])];
                
                mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
                [mulStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                str = [[NSMutableAttributedString alloc] initWithAttributedString:mulStr];;
            }
        }
    }
    else if (aFontArray != nil && aFontArray.count > 0){
        NSString    *allStr = @"";
        for (int i = 0; i < aDataArray.count; i++) {
            allStr = [allStr stringByAppendingString:aDataArray[i]];
        }
        
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allStr];
        for (int i = 0; i < aDataArray.count-1; i++) {
            
            int font = [aFontArray[i] intValue];
            
            if(i == 0){
                int from = 0;
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:font] range:NSMakeRange(from, [aDataArray[i] length])];
            }
            else{
                int from = 0;
                for (int j = 0; j <= i-1 ; j++) {
                    from += [aDataArray[j] length];
                }
                [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:font] range:NSMakeRange(from, [aDataArray[i] length])];
            }
        }
    }
    else if (aColorArray != nil && aColorArray.count > 0){
        NSString    *allStr = @"";
        for (int i = 0; i < aDataArray.count; i++) {
            allStr = [allStr stringByAppendingString:aDataArray[i]];
        }
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:allStr];
        for (int i = 0; i < aDataArray.count-1; i++) {
            UIColor* color= nil;
            NSArray *floatArray = [aColorArray[i] componentsSeparatedByString:@"/"];
            color = [UIColor colorWithRed:[floatArray[0] floatValue]/255.0 green:[floatArray[1] floatValue]/255.0 blue:[floatArray[2] floatValue]/255.0 alpha:[floatArray[3] floatValue]];
            
            if(i == 0){
                int from = 0;
                [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
                
                str = [[NSMutableAttributedString alloc] initWithAttributedString:mulStr];;
            }
            else{
                int from = 0;
                for (int j = 0; j <= i-1 ; j++) {
                    from += [aDataArray[j] length];
                }
                [str addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                mulStr = [[NSMutableAttributedString alloc] initWithAttributedString:str];
                [mulStr addAttribute:NSForegroundColorAttributeName value:color range:NSMakeRange(from, [aDataArray[i] length])];
                
                str = [[NSMutableAttributedString alloc] initWithAttributedString:mulStr];;
            }
        }
    }
    return mulStr;
}

+(NSMutableAttributedString *)mutableFontArray:(NSMutableArray *)aDataArray fontArray:(NSMutableArray *)aFontArray{
    
    NSMutableAttributedString *str      = nil;
    NSMutableAttributedString *mulStr   = nil;
    NSString                  *allStr   = @"";
    for (int i = 0; i < aDataArray.count; i++) {
        allStr = [NSString stringWithFormat:@"%@%@",allStr,aDataArray[i]];
    }
    str = [[NSMutableAttributedString alloc]initWithString:allStr];
    
    for (int i = 0; i < aDataArray.count; i++) {
        if (i != 0) {
            str = [[NSMutableAttributedString alloc]initWithAttributedString:mulStr];
        }
        int from = 0;
        int to   = (int)[aDataArray[0] length];
        if (i-1 >= 0) {
            from = 0;
            to   = (int)[aDataArray[i] length];
            for (int j = 0; j < i; j++) {
                from += (int)[aDataArray[j] length];
            }
        }
        [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica" size:[aFontArray[i] intValue]] range:NSMakeRange(from, to)];
        mulStr = [[NSMutableAttributedString alloc]initWithAttributedString:str];
    }
    return str;
}

/*
    aDataArray:两段字符串，第二段字符串改变颜色
*/
+(NSMutableAttributedString *)mutableColorWithDataArray:(NSMutableArray *)aDataArray lastColor:(UIColor *)aColor{
    NSString *allStr = [NSString stringWithFormat:@"%@%@",aDataArray.firstObject,aDataArray.lastObject];
    NSMutableAttributedString *mulStr = [[NSMutableAttributedString alloc]initWithString:allStr];
    [mulStr addAttribute:NSForegroundColorAttributeName value:aColor range:NSMakeRange([aDataArray.firstObject length], [aDataArray.lastObject length])];
    return mulStr;
}

+ ( CGSize )getStringRectWithString:( NSString *)aString Font:(int)aFont Width:(float)aWidth Height:(float)aHeight
{
    CGRect rect;
//    NSAttributedString * atrString = [[ NSAttributedString alloc ]  initWithString :aString];
//    NSRange  range =  NSMakeRange ( 0 , atrString. length );
//    NSDictionary * dic = [atrString  attributesAtIndex : 0   effectiveRange :&range];
//    size=[aString boundingRectWithSize:CGSizeMake(aWidth, aHeight)
//                               options:NSStringDrawingUsesLineFragmentOrigin
//                            attributes:dic
//                               context:nil].size;
//    size = [aString sizeWithFont:[UIFont systemFontOfSize:aFont] constrainedToSize:CGSizeMake(aWidth, aHeight) lineBreakMode:UILineBreakModeWordWrap];
    rect = [aString boundingRectWithSize:CGSizeMake(aWidth, aHeight) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:aFont]} context:nil];
    
    CGSize size = rect.size;
    
    
    return   size;
}

+(UIWindow *)getWindow{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSArray * array = [[UIApplication sharedApplication] windows];
    if (array.count >= 2) {
        window = [array objectAtIndex:1];
    }
    
    return window;
}

+(NSString *)nullTrimString:(id)aID{
    if (aID != nil && ![aID isKindOfClass:[NSNull class]] && ![[NSString stringWithFormat:@"%@",aID] isEqualToString:@"(null)"]) {
        return [NSString stringWithFormat:@"%@",aID];
    }
    else{
        return @"";
    }
}

+(NSString *)nullTrimString:(id)aID expectString:(NSString *)aString{
    if (aID != nil && ![aID isKindOfClass:[NSNull class]] && ![[NSString stringWithFormat:@"%@",aID] isEqualToString:@"(null)"]) {
        return [NSString stringWithFormat:@"%@",aID];
    }
    else{
        return aString;
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

//json字符串装换成json对象
+ (id)toJsonObjectWithJsonString:(NSString *)jsonStr
{
    NSData* data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError* error = nil;
    if (data == nil) {
        return nil;
    }
    id result = [NSJSONSerialization JSONObjectWithData:data
                                                options:kNilOptions
                                                  error:&error];
    //如果解析过程出错，显示错误
    if (error != nil) {
//        NSString *errCode = [NSString stringWithFormat:@"%ld",(long)error.code];
//        NSString *errMsg = [NSString stringWithFormat:@"解析出错，检查json格式: %@",error.localizedDescription];
//        NSArray *array = [NSArray arrayWithObjects:errCode,errMsg,nil];
        return nil;
    }
    return result;
}

//json对象转换成json字符串
+ (NSString *)toJsonStringWithJsonObject:(id)jsonObject{
    NSData *result = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                     options:kNilOptions
                                                       error:nil];
    return [[NSString alloc] initWithData:result
                                 encoding:NSUTF8StringEncoding];
}


#pragma mark IP

+ (NSString *)getIPAddress:(BOOL)preferIPv4
{
    NSArray *searchArray = preferIPv4 ?
    @[ IOS_VPN @"/" IP_ADDR_IPv4, IOS_VPN @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6 ] :
    @[ IOS_VPN @"/" IP_ADDR_IPv6, IOS_VPN @"/" IP_ADDR_IPv4, IOS_WIFI @"/" IP_ADDR_IPv6, IOS_WIFI @"/" IP_ADDR_IPv4, IOS_CELLULAR @"/" IP_ADDR_IPv6, IOS_CELLULAR @"/" IP_ADDR_IPv4 ] ;
    
    NSDictionary * addresses = [PL_ProvidenceDataUsedEngine getIPAddresses];
    __block NSString *address;
    [searchArray enumerateObjectsUsingBlock:^(NSString *key, NSUInteger idx, BOOL *stop)
     {
         address = addresses[key];
         //筛选出IP地址格式
         if([PL_ProvidenceDataUsedEngine isValidatIP:address]) *stop = YES;
     } ];
    return address ? address : @"0.0.0.0";
}
+ (BOOL)isValidatIP:(NSString *)ipAddress {
    if (ipAddress.length == 0) {
        return NO;
    }
    NSString *urlRegEx = @"^([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])\\."
    "([01]?\\d\\d?|2[0-4]\\d|25[0-5])$";
    
    NSError *error;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:urlRegEx options:0 error:&error];
    
    if (regex != nil) {
        NSTextCheckingResult *firstMatch=[regex firstMatchInString:ipAddress options:0 range:NSMakeRange(0, [ipAddress length])];
        
        if (firstMatch) {
            NSRange resultRange = [firstMatch rangeAtIndex:0];
            NSString *result=[ipAddress substringWithRange:resultRange];
            //输出结果
            NSLog(@"输出结果: %@",result);
            return YES;
        }
    }
    return NO;
}
+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}


@end
