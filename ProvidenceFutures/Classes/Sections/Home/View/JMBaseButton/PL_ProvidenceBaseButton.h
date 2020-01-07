//
//  PL_ProvidenceBaseButton.h
//  JMButton
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// JM on 2018/1/10.
//  Copyright © 2018年 JM. All rights reserved.
//
/*
 .----------------. .----------------.
 | .--------------. | .--------------. |
 | |     _____    | | | ____    ____ | |
 | |    |_   _|   | | ||_   \  /   _|| |
 | |      | |     | | |  |   \/   |  | |
 | |   _  | |     | | |  | |\  /| |  | |
 | |  | |_' |     | | | _| |_\/_| |_ | |
 | |  `.___.'     | | ||_____||_____|| |
 | |              | | |              | |
 | '--------------' | '--------------' |
 '----------------' '----------------'
 github: https://github.com/JunAILiang
 blog: https://www.ljmvip.cn
 */

#import <UIKit/UIKit.h>
#import "PL_ProvidenceBaseButtonConfig.h"

@interface PL_ProvidenceBaseButton : UIButton

+ (instancetype)buttonFrame:(CGRect)frame ButtonConfig:(PL_ProvidenceBaseButtonConfig *)buttonConfig;

- (instancetype)initWithFrame:(CGRect)frame ButtonConfig:(PL_ProvidenceBaseButtonConfig *)buttonConfig;

@end
