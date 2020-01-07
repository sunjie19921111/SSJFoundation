//
//  PL_ProvidenceTabVC.m
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



#import "PL_ProvidenceTabVC.h"
#import "AppDelegate.h"
#import "PL_ProvidenceNavigationVC.h"
#import "PL_ProvidenceLoginVC.h"

//                     @(PL_ProvidenceMainTabTypeMessageHome) : @{
//                             TabbarVC           : @"PL_ProvidenceMainVC",
//                             TabbarTitle        : @"行情",
//                             TabbarImage        : @"icon_tabbar_market_nor",
//                             TabbarSelectedImage: @"icon_tabbar_market_sel",
//                             TabbarItemBadgeValue: @(self.sessionUnreadCount)
//                             },

#define TabbarVC    @"vc"
#define TabbarTitle @"title"
#define TabbarImage @"image"
#define TabbarSelectedImage @"selectedImage"
#define TabbarItemBadgeValue @"badgeValue"
#define TabBarCount 4

typedef NS_ENUM(NSInteger,PL_ProvidenceMainTabType) {
//    PL_ProvidenceMainTabTypeMessageHome,    //行情
    PL_ProvidenceMainTabTypeFutures,    //期货
    PL_ProvidenceMainTabTypeNews,        //新闻
    PL_ProvidenceMainTabTypeMarket,   //持仓
    PL_ProvidenceMainTabTypeMe,        //我的
};

@interface PL_ProvidenceTabVC ()<UITabBarControllerDelegate>

@property (nonatomic,strong) NSArray *navigationHandlers;

@property (nonatomic,assign) NSInteger sessionUnreadCount;

@property (nonatomic,assign) NSInteger systemUnreadCount;

@property (nonatomic,assign) NSInteger customSystemUnreadCount;

@property (nonatomic,copy)  NSDictionary *configs;


@end

@implementation PL_ProvidenceTabVC

+ (instancetype)instance{
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *vc = delegete.window.rootViewController;
    if ([vc isKindOfClass:[PL_ProvidenceTabVC class]]) {
        return (PL_ProvidenceTabVC *)vc;
    }else{
        return nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.delegate = self;
    [[UITabBar appearance] setTranslucent:NO];
    
    [self setUpSubNav];
    [self setUpStatusBar];
}

- (void)setUpSubNav{
    NSMutableArray *handleArray = [[NSMutableArray alloc] init];
    NSMutableArray *vcArray = [[NSMutableArray alloc] init];
    [self.tabbars enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSDictionary * item =[self vcInfoForTabType:[obj integerValue]];
        NSString *vcName = item[TabbarVC];
        NSString *title  = item[TabbarTitle];
        NSString *imageName = item[TabbarImage];
        NSString *imageSelected = item[TabbarSelectedImage];
        Class clazz = NSClassFromString(vcName);
        UIViewController *vc = [[clazz alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = NO;
        PL_ProvidenceNavigationVC *nav = [[PL_ProvidenceNavigationVC alloc] initWithRootViewController:vc];
        nav.navigationItem.title = title;
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:title
                                                       image:[[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                               selectedImage:[[UIImage imageNamed:imageSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        
        NSDictionary *dict = [NSDictionary dictionaryWithObject:kMainColor forKey:NSForegroundColorAttributeName];
        [nav.tabBarItem setTitleTextAttributes:dict forState:UIControlStateSelected];
        self.tabBar.tintColor = kMainColor;
        nav.tabBarItem.tag = idx;
        NSInteger badge = [item[TabbarItemBadgeValue] integerValue];
        if (badge) {
            nav.tabBarItem.badgeValue = [NSString stringWithFormat:@"%zd",badge];
        }
        
        [vcArray addObject:nav];
//        [handleArray addObject:handler];
    }];
    self.viewControllers = [NSArray arrayWithArray:vcArray];
    self.navigationHandlers = [NSArray arrayWithArray:handleArray];
}


- (void)setUpStatusBar{
    UIStatusBarStyle style = UIStatusBarStyleDefault;
    [[UIApplication sharedApplication] setStatusBarStyle:style
                                                animated:NO];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    NSInteger index = tabBarController.selectedIndex;
    NSString *account = k_CurrentLoginData.phone;
    if ((index == 0 || index == 3) && account == nil) {
        PL_ProvidenceLoginVC *vc = [PL_ProvidenceLoginVC new];
        vc.modalPresentationStyle = 0;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:vc  animated:YES completion:nil];
    }
    return YES;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray*)tabbars{
    NSMutableArray *items = [[NSMutableArray alloc] init];
    for (NSInteger tabbar = 0; tabbar < TabBarCount; tabbar++) {
        [items addObject:@(tabbar)];
    }
    return items;
}

#pragma mark - VC
- (NSDictionary *)vcInfoForTabType:(PL_ProvidenceMainTabType)type{
    
    if (_configs == nil)
    {
        _configs = @{
                     @(PL_ProvidenceMainTabTypeFutures) : @{
                             TabbarVC           : @"PL_ProvidenceHomeController",
                             TabbarTitle        : @"期货",
                             TabbarImage        : @"icon_tabbar_home_nor",
                             TabbarSelectedImage: @"icon_tabbar_home_sel",
                             TabbarItemBadgeValue: @(self.sessionUnreadCount)
                             },
                     @(PL_ProvidenceMainTabTypeNews)     : @{
                             TabbarVC           : @"PL_ProvidencePaperVC",
                             TabbarTitle        : @"新闻",
                             TabbarImage        : @"icon_tabbar_new_nor",
                             TabbarSelectedImage: @"icon_tabbar_new_sel",
                             TabbarItemBadgeValue: @(self.systemUnreadCount)
                             },
                     @(PL_ProvidenceMainTabTypeMarket): @{
                             TabbarVC           : @"PL_ProvidenceDealController",
                             TabbarTitle        : @"交易",
                             TabbarImage        : @"icon_tabbar_deal_nor",
                             TabbarSelectedImage: @"icon_tabbar_deal_sel",
                             },
                     @(PL_ProvidenceMainTabTypeMe)     : @{
                             TabbarVC           : @"PL_ProvidenceSettingVC",
                             TabbarTitle        : @"我的",
                             TabbarImage        : @"icon_tabbar_my_nor",
                             TabbarSelectedImage: @"icon_tabbar_my_sel",
                             }
                     };
        
    }
    return _configs[@(type)];
}

@end
