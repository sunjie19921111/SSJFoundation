//
//  QHJRGlobalMacro.h
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

#ifndef PL_ProvidenceGlobalMacro_h
#define PL_ProvidenceGlobalMacro_h


#define  k_AppVersion [(NSDictionary *)[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define  k_AppName [(NSDictionary *)[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"]

 
#define FontSize_Text_S 11

#define NavMustAdd (IS_HETERO_SCREEN ? 34.0 : 0.0)
#define TabMustAdd (IS_HETERO_SCREEN ? 20.0 : 0.0)

#define kMainColor [UIColor colorWithHexString:@"#f96132"]

#define k_CurrentLoginData [PL_ProvidenceLoginManager sharedManager].currentLoginData

#define IPHONEHIGHT(b) [UIScreen mainScreen].bounds.size.height*((b)/1294.0)
#define IPHONEWIDTH(a) [UIScreen mainScreen].bounds.size.width*((a)/750.0)

#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define ScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#define PL_ProvidenceNotificationLogout  @"NotificationLogout"
/**
 *设置Font
 */
#define FontSize(a) [UIFont systemFontOfSize:a]


#pragma mark - UITableViewCell点击背景
#define SelectCellBackViewSize(s_Width,s_Height,s_Color) UIView * selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, s_Width, s_Height)];\
selectView.backgroundColor = s_Color;\
self.selectedBackgroundView = selectView;

#define isStrEmpty(string) (string == nil || string == NULL || (![string isKindOfClass:[NSString class]]) || ([string isEqual:@""]) || [string isEqualToString:@""] || [string isEqualToString:@" "] || ([string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length == 0))

#define kStrEmpty(string)  isStrEmpty(string) ? @"" : string


// ----------- 公共尺寸 ------
/* 屏幕宽 */
#define SCREEN_Width   ([UIScreen mainScreen].bounds.size.width)
/* 屏幕高 */
#define SCREEN_Height  ([UIScreen mainScreen].bounds.size.height)

// 手机尺寸型号
#define PL_ProvidenceiPhone_4x        (SCREEN_Width == 320 && SCREEN_Height == 480)
#define PL_ProvidenceiPhone_5x        (SCREEN_Width == 320 && SCREEN_Height == 568)
#define PL_ProvidenceiPhone_6x        (SCREEN_Width == 375 && SCREEN_Height == 667)
#define PL_ProvidenceiPhone_plus      (SCREEN_Width == 414 && SCREEN_Height == 736)
#define PL_ProvidenceiPhone_X         (SCREEN_Width == 375 && SCREEN_Height == 812)   // iPhone X,    iPhone XS
#define PL_ProvidenceiPhone_X_Max     (SCREEN_Width == 414 && SCREEN_Height == 896)   // iPhone XR,   iPhone XS Max

#define STRINGNOTNIL(string) string.length==0? @"" : string

#define UiFontIPH(num) [UIFont systemFontOfSize:IPHONEWIDTH(num)]

#define fFont @"EuphemiaUCAS"

// --------- 适配公共宏 ------
/** 控件缩放比例，按照宽度计算 */
#define SCALE_Length(l) (IS_PORTRAIT ? round((SCREEN_Width/375.0*(l))) : round((SCREEN_Width/667.0*(l))))

/** 是否是竖屏 */
#define IS_PORTRAIT (([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait) || ([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown))

#define weakSelf(ref)           __weak __typeof(ref)weakSelf = ref;

#define Nav_topH (IS_HETERO_SCREEN ? 88.0 : 64.0)

#define kStatustopH (IS_HETERO_SCREEN ? 44.0 : 20.0)

/** 是否是异形屏 */
#define IS_HETERO_SCREEN (PL_ProvidenceiPhone_X || PL_ProvidenceiPhone_X_Max)

#define PL_ProvidenceArchiverPath_Assert             [@"PL_ProvidenceArchiverPath_Assert" pathInDocumentDirectory]
#define PL_ProvidenceArchiverPath_Fav                [@"PL_ProvidenceArchiverPath_Fav" pathInDocumentDirectory]
#define PL_ProvidenceArchiverPath_Position           [@"PL_ProvidenceArchiverPath_Position" pathInDocumentDirectory]

#define  k_MoneyManagerModel                [PL_ProvidenceDealManager sharedManager].currentModel

#endif /* QHJRGlobalMacro_h */
