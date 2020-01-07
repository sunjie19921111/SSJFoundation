//
//  PL_ProvidenceLoginManager.m
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

#import "PL_ProvidenceLoginManager.h"

#define NIMToken         @"token"
#define NIMUserName      @"username"
#define NIMPhone         @"phone"
#define NIMPassword      @"Password"
#define NIMSign          @"sign"
#define NIMAccount       @"account"


@interface PL_ProvidenceLoginData ()<NSCoding>

@end

@implementation PL_ProvidenceLoginData

- (void)setPassword:(NSString *)password {
    _password = password;
    _isLogin = _password.length;
}

MJCodingImplementation;

@end


@interface PL_ProvidenceLoginManager ()

@property (nonatomic,copy)  NSString    *filepath;

@end

@implementation PL_ProvidenceLoginManager

- (instancetype)initWithPath:(NSString *)filepath{
    if (self = [super init]) {
        _filepath = filepath;
        [self readData];
    }
    return self;
}

+ (instancetype)sharedManager
{
    static PL_ProvidenceLoginManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filepath = [path stringByAppendingPathComponent:@"nim_sdk_PL_Providencelogin_data"];
        instance = [[PL_ProvidenceLoginManager alloc] initWithPath:filepath];
    });
    return instance;
}



- (void)setCurrentLoginData:(PL_ProvidenceLoginData *)currentLoginData
{
    _currentLoginData = currentLoginData;
    [self saveData];
}

//从文件中读取和保存用户名密码,建议上层开发对这个地方做加密,DEMO只为了做示范,所以没加密
- (void)readData
{
    NSString *filepath = [self filepath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath])
    {
        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
        _currentLoginData = [object isKindOfClass:[PL_ProvidenceLoginData class]] ? object : nil;
    }
}

- (void)saveData
{
    NSData *data = [NSData data];
    if (_currentLoginData)
    {
        data = [NSKeyedArchiver archivedDataWithRootObject:_currentLoginData];
    }
    [data writeToFile:[self filepath] atomically:YES];
}



- (void)configCookie {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull cookie, NSUInteger idx, BOOL * _Nonnull stop) {
        NSMutableDictionary *properties = [[cookie properties] mutableCopy];
        //将cookie过期时间设置为一年后
        NSDate *expiresDate = [NSDate dateWithTimeIntervalSinceNow:3600*24*30*12];
        properties[NSHTTPCookieExpires] = expiresDate;
        //删除Cookies的discard字段，应用退出，会话结束的时候继续保留Cookies
        [properties removeObjectForKey:NSHTTPCookieDiscard];
        //重新设置改动后的Cookies
        [cookieStorage setCookie:[NSHTTPCookie cookieWithProperties:properties]];
    }];
}

- (void)cleanCookie {
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    [cookieStorage.cookies enumerateObjectsUsingBlock:^(NSHTTPCookie * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [cookieStorage deleteCookie:obj];
    }];
}



@end
