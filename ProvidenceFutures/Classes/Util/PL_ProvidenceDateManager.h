//
//  PL_ProvidenceDateManager.h
//  hs
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// PXJ on 17/2/23.
//  Copyright © 2017年 luckin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PL_ProvidenceDateManager : NSObject

@property (nonatomic, strong) NSDateFormatter * dateFormatter;

+(PL_ProvidenceDateManager *)sharedInstance;


- (NSNumber *)timeStamp_now;
@end
