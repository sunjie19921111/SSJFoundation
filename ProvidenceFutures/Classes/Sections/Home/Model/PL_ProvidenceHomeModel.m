//
//  PL_ProvidenceHomeModel.m
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
//2019/11/6.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceHomeModel.h"
#import "PL_ProvidenceHomeStockModel.h"

@implementation PL_ProvidenceHomeModel

+ (NSDictionary *)mj_objectClassInArray{
    return @{ @"dl" : @"PL_ProvidenceHomeStockModel",
              @"sh" : @"PL_ProvidenceHomeStockModel",
              @"zz" : @"PL_ProvidenceHomeStockModel"
              };
}

@end
