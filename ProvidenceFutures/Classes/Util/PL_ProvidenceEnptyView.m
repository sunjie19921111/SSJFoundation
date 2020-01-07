//
//  PL_ProvidenceEnptyView.m
//  HuiSurplusFutures
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/11/11.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceEnptyView.h"

@implementation PL_ProvidenceEnptyView

+(instancetype)emptyView {
    return [[[NSBundle mainBundle] loadNibNamed:@"PL_ProvidenceEnptyView" owner:nil options:@{}] objectAtIndex:0];
}

@end
