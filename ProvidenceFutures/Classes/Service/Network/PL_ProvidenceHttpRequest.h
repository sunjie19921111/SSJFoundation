//
// PL_ProvidenceHttpRequest.h
//  ThinkThink_oc
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// apple  on 2019/8/8.
//  Copyright © 2019 apple . All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^complete) (id result, NSError *error, NSURLSessionDataTask *task);

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHttpRequest : NSObject

+ (instancetype)netWork;
- (void)updateSession;
- (void)updadeCode;
- (void)resetSessionRequest:(id)userInfo completion:(void (^)(void))completion;

+ (void)getWithURL:(NSString *)urlString params:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion;
+ (void)post:(NSString *)urlString params:(id)params complete:(complete)complete;
+ (void)downLoad:(NSString *)url complete:(void(^)(NSString *filePath,NSError *error))complete;

@end

NS_ASSUME_NONNULL_END
