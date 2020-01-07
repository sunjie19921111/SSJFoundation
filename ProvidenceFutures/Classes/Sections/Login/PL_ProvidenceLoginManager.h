//
//  PL_ProvidenceLoginManager.h
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

@interface PL_ProvidenceLoginData : NSObject


@property (nonatomic, copy) NSString *bankAccount;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *sgin;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *lastSign; //最后打卡时间
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *audio;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *nickname;
@property (nonatomic, assign) BOOL isLogin;

/*

age = 18;
brithDay = "2018-01-01";
canGetCourse = 0;
cellphone = 13800000001;
cityName = "\U77f3\U5bb6\U5e84\U5e02";
departClassVOs = "<null>";
firstLogin = 1;
iconUrl = "https://static.sxmaps.com/image/138000000011566284040683.png";
idCard = 373636363636353605;
identification = "";
imAccid = 525ae1950a924cfba53e0c3c416bb7af;
imToken = f3f34e3325989ad0deb02832bf46cdee;
lastTime = "2019-09-05 04:08:56";
major = "\U6c49\U8bed\U8a00\U6587\U5b66\Uff08\U57fa\U7840\U79d1\U6bb5\Uff09";
majorId = 36;
provinceName = "\U6cb3\U5317\U7701";
signature = "\U5347\U5b66\U6559\U80b2app\U5f00\U53d1\U8001\U5e08";
status = 1;
token = "10118053100001_12b7cf28113742bb8373c04c356abbfa";
trueName = "\U6d4b\U8bd5\U5b59\U6770";
uid = 10118053100001;
userName = "\U6c9f\U6c9f\U58d1\U58d1";
userSex = 1;
*/






@end

@interface PL_ProvidenceLoginManager : NSObject


@property (nonatomic,strong)    PL_ProvidenceLoginData   *currentLoginData;

+ (instancetype)sharedManager;

- (void)configCookie;
- (void)cleanCookie;


@end

NS_ASSUME_NONNULL_END
