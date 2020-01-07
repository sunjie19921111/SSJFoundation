//
//  PL_ProvidenceDealManager.m
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
//2019/9/29.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceDealManager.h"



@interface PL_ProvidenceDealManager ()

@property (nonatomic, copy) NSString *filepath;

@end

@implementation PL_ProvidenceDealData

MJCodingImplementation;



- (void)setTotalyk:(NSString *)totalyk {
    _totalyk = totalyk;
    _availableIntegral = [NSString stringWithFormat:@"%ld",_totalIntegral.integerValue-_totalyk.integerValue];
}

- (void)setTotalIntegral:(NSString *)totalIntegral {
    _totalIntegral = totalIntegral;
    _availableIntegral = [NSString stringWithFormat:@"%ld",totalIntegral.integerValue-_totalyk.integerValue];
}



@end

@implementation PL_ProvidenceDealManager

+ (instancetype)sharedManager
{
    static PL_ProvidenceDealManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *filepath = [path stringByAppendingPathComponent:@"PL_Providencemoney_data"];
        instance = [[PL_ProvidenceDealManager alloc] initWithPath:filepath];
    });
    return instance;
}


- (instancetype)initWithPath:(NSString *)filepath
{
    if (self = [super init])
    {
        _filepath = filepath;
        [self readData];
    }
    return self;
}

- (void)start {
    PL_ProvidenceDealData *model = [PL_ProvidenceDealManager sharedManager].currentModel;
    if (model == nil) {
        model = [[PL_ProvidenceDealData alloc] init];
        [PL_ProvidenceDealManager sharedManager].currentModel = model;
    }
   
}


- (void)setCurrentModel:(PL_ProvidenceDealData *)currentModel
{
    _currentModel = currentModel;
    [self saveData];
}

- (void)saveData
{
    NSData *data = [NSData data];
    if (_currentModel)
    {
        data = [NSKeyedArchiver archivedDataWithRootObject:_currentModel];
    }
    [data writeToFile:[self filepath] atomically:YES];
}

//从文件中读取和保存用户名密码,建议上层开发对这个地方做加密,DEMO只为了做示范,所以没加密
- (void)readData
{
    NSString *filepath = [self filepath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filepath])
    {
        id object = [NSKeyedUnarchiver unarchiveObjectWithFile:filepath];
        _currentModel = [object isKindOfClass:[PL_ProvidenceDealData class]] ? object : nil;
    }
}

@end
