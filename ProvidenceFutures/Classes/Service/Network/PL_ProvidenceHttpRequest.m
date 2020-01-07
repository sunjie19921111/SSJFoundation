//
// PL_ProvidenceHttpRequest.m
//  ThinkThink_oc
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// apple  on 2019/8/8.
//  Copyright © 2019 apple . All rights reserved.
//

#import "PL_ProvidenceHttpRequest.h"
#import "PL_ProvidenceLoginManager.h"
#import "NSString+PL_Providence.h"
#import "MFNetworkManager.h"




@interface PL_ProvidenceHttpRequest()

@property (nonatomic, strong) dispatch_queue_t queue;

@end

@implementation PL_ProvidenceHttpRequest


- (void)updateSession {
    PL_ProvidenceLoginData *data = [PL_ProvidenceLoginManager sharedManager].currentLoginData;
    if (data) {
        NSArray *urls = PL_ProvidenceSESSION_URLS;
        dispatch_group_t group = dispatch_group_create();
        [urls enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            dispatch_group_enter(group);
//            [self GET:obj parameters:[data mj_keyValues] completion:^(NSError * _Nonnull error, id  _Nonnull responseObject) {
//                dispatch_group_leave(group);
//               [[PL_ProvidenceLoginManager sharedManager] configCookie];
//            }];
            [MFNETWROK get:obj params:[data mj_keyValues] success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
                 dispatch_group_leave(group);
                [[PL_ProvidenceLoginManager sharedManager] configCookie];
            } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {

            }];
        }];
//        dispatch_group_notify(group,[PL_ProvidenceHttpRequest netWork].queue, ^{
//            NSLog(@"更新session");
//        });
    }
}



- (void)resetSessionRequest:(id)userInfo completion:(void (^)(void))completion {
    
    NSArray *urlArray = PL_ProvidenceSESSION_URLS;
    __block BOOL loginSuccess = YES;
    dispatch_group_t requestGroup = dispatch_group_create();
    [urlArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        dispatch_group_enter(requestGroup);
        [MFNETWROK get:obj params:userInfo success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
            dispatch_group_leave(requestGroup);
            NSLog(@"=====session:%@",result);
        } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
            loginSuccess = NO;
            dispatch_group_leave(requestGroup);
            NSLog(@"=====session:%@",error);
        }];
 
    }];
    dispatch_group_notify(requestGroup, dispatch_get_main_queue(), ^{
        
        [PL_ProvidenceLoginManager sharedManager].configCookie;
        if (completion) {
            completion();
        }
    });
}



- (void)updadeCode {
    [MFNETWROK post:PL_ProvidenceCHECK_CODE_SURE params:nil success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {

    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {

    }];
}

+ (void)post:(NSString *)urlString params:(id)params complete:(complete)complete {
    
    [MFNETWROK post:urlString params:params success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
        complete(result,nil,task);
    } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
        complete(nil,error,task);
    }];
}

+ (void)getWithURL:(NSString *)urlString params:(id)parameter completion:(void (^)(NSError * _Nonnull, id _Nonnull))completion {
    if (completion) {
        [MFNETWROK get:urlString params:parameter success:^(id result, NSInteger statusCode, NSURLSessionDataTask *task) {
            if (statusCode == 200) {
                completion(nil,result);
            }
        } failure:^(NSError *error, NSInteger statusCode, NSURLSessionDataTask *task) {
            completion(error,nil);
        }];
//        [self GET:urlString parameters:parameter completion:completion];
    }
}


+ (instancetype)netWork {
    static PL_ProvidenceHttpRequest *network = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [PL_ProvidenceHttpRequest new];
    });
    return network;
}


@end
