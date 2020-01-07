//
//  PL_ProvidenceNavigationVC.m
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



#import "PL_ProvidenceNavigationVC.h"

@interface PL_ProvidenceNavigationVC ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@property (nonatomic ,strong) id popDelegate;

@end

@implementation PL_ProvidenceNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.popDelegate = self.interactivePopGestureRecognizer.delegate;
    [self.navigationBar setShadowImage:[UIImage new]]; // 去除navBar下的1px的横线
//    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];

    [[UINavigationBar appearance] setTintColor:kMainColor];
    [[UINavigationBar appearance] setBarTintColor:kMainColor];
    NSDictionary *att = @{NSForegroundColorAttributeName:[UIColor whiteColor],};
    [[UINavigationBar appearance] setTitleTextAttributes:att];
    self.delegate = self;
    [self.navigationController.navigationBar setTranslucent:NO];
}

#pragma mark - 状态栏控制
- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.visibleViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.visibleViewController;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count == 1) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    if (self.childViewControllers.count) { // 非根控制器
        viewController.hidesBottomBarWhenPushed = YES;
        UIImage *backImage = [[UIImage imageNamed:@"icon_nav_back"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backImage style:0 target:self action:@selector(back)];
        self.interactivePopGestureRecognizer.delegate = nil;
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.childViewControllers.count == 1) { // 根控制器
        
        self.interactivePopGestureRecognizer.delegate = self.popDelegate;
    }
}


- (void)back {
    [self popViewControllerAnimated:YES];
}

#pragma mark - 转屏控制
// 是否支持自动转屏
- (BOOL)shouldAutorotate {
    return [self.visibleViewController shouldAutorotate];
}

// 支持哪些屏幕方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    return [self.visibleViewController supportedInterfaceOrientations];
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return [self.visibleViewController preferredInterfaceOrientationForPresentation];
}

@end
