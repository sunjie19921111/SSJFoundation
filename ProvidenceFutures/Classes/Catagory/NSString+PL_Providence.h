//
//  NSString+PL_Providence.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (PL_Providence)

+ (NSString*)encodeBase64String:(NSString *)input;

+ (NSString*)decodeBase64String:(NSString *)input;

+ (NSString*)encodeBase64Data:(NSData *)data;

+ (NSString*)decodeBase64Data:(NSData *)data;


+ (NSString *)localStringFromDate:(NSDate *)Date;

- (NSString *)MD5Digest;

+ (NSDate *)PL_ProvidencegetTodayStartStamp;

- (NSString *)pathInDocumentDirectory;

+ (NSString *)localStringFromUTCDate:(NSDate *)UTCDate;
+ (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate;

+ (NSString * _Nullable)PL_ProvidencefixNumString:(NSString * _Nonnull)numString minDecimalsLimit:(NSInteger)minDecimal maxDecimalsLimit:(NSInteger)maxDecimal;

- (NSDecimalNumber *)PL_ProvidencedigitalValue;

+ (NSString * _Nullable)PL_ProvidenceconvertTimeStamp:(NSTimeInterval)timeStamp toFormatter:(NSString *)formatterString;

+ (NSString * _Nullable)PL_ProvidenceconvertToDisplayStringWithOriginNum:(NSString * _Nonnull)numString decimalsLimit:(NSInteger)decimal prefix:(NSString *_Nullable)prefix suffix:(NSString * _Nullable)suffix;

- (NSAttributedString *)PL_ProvidencecreateAttributedStringWithFont:(UIFont * _Nullable)font textColor:(UIColor *_Nullable)color;


@end

NS_ASSUME_NONNULL_END
