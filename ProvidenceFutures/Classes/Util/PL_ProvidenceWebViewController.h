//
//  PL_ProvidenceWebViewController.h
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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceWebViewController : UIViewController



@property (nonatomic, assign) BOOL islocal;

@property (nonatomic, assign) BOOL isFull;
/** html 文本内容 */
@property (nonatomic, copy) NSString *contentHTML;

/** 跳转的url */
@property (nonatomic, copy) NSString *gotoURL;



@end

NS_ASSUME_NONNULL_END
