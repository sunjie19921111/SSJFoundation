//
//  PL_ProvidenceMilionHttpUrl.h
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
//2019/9/25.
//  Copyright © 2019 qhwr. All rights reserved.
//

#ifndef PL_ProvidenceMilionHttpUrl_h
#define PL_ProvidenceMilionHttpUrl_h


#define K_HTTP @"https://"
/**
 *URL_host
 */
#define K_URL @"api.yiyuanhk.com:18888"//获取到域名 www.cainiu.com


#define WORD_DOMAIN(url)       [NSString stringWithFormat:@"https://words.viplgw.cn/%@",url]
#define GMAT_DOMAIN(url)      [NSString stringWithFormat:@"https://www.gmatonline.cn/%@",url]
#define OPPEN_DOMAIN(url)     [NSString stringWithFormat:@"https://open.viplgw.cn/%@",url]

/*************************************** 接口 **********************************/

//登录
#define PL_ProvidenceLOGIN_URL                         @"https://login.viplgw.cn/cn/app-api/check-login"


//获取 session
#define PL_ProvidenceSESSION_URLS                       @[@"https://www.toeflonline.cn/cn/app-api/unify-login",@"https://www.smartapply.cn/cn/app-api/unify-login",@"https://www.gmatonline.cn/index.php?web/appapi/unifyLogin",@"https://bbs.viplgw.cn/cn/app-api/unify-login",@"https://words.viplgw.cn/cn/app-api/unify-login"]

//获取验证码前先跟服务器确认
#define PL_ProvidenceCHECK_CODE_SURE                    @"https://login.viplgw.cn/cn/app-api/phone-request"

//通过手机获取验证码
#define PL_ProvidenceGET_CHECK_CODE_PHONE            @"https://login.viplgw.cn/cn/app-api/phone-code"

//通过 email 获取验证码
#define PL_ProvidenceGET_CHECK_CODE_EMAIL            @"https://login.viplgw.cn/cn/app-api/send-mail"

//注册
#define PL_ProvidenceREGISTER_URL                    @"https://login.viplgw.cn/cn/app-api/register"

//找回密码
#define PL_ProvidenceFIND_PASSWORD_URL                @"https://login.viplgw.cn/cn/app-api/find-pass"

//修改用户邮箱，密码，手机
#define PL_ProvidenceUPDATE_USER_URL                 @"https://login.viplgw.cn/cn/app-api/update-user"

//上传头像
#define PL_ProvidenceUPDATE_HEAD_IMG_URL             @"https://words.viplgw.cn/cn/app-api/app-image"

//更改昵称
#define PL_ProvidenceUPDATE_NICKNAME_URL                @"https://login.viplgw.cn/cn/app-api/change-nickname"

#define K_DOMAIN_URL    [NSString stringWithFormat:@"%@%@/lt-interface",K_HTTP,K_URL]

#endif /* PL_ProvidenceMilionHttpUrl_h */
