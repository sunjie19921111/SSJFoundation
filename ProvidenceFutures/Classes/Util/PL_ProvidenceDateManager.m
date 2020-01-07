//
//  PL_ProvidenceDateManager.m
//  hs
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// PXJ on 17/2/23.
//  Copyright © 2017年 luckin. All rights reserved.
//

#import "PL_ProvidenceDateManager.h"



@implementation PL_ProvidenceDateManager

+(PL_ProvidenceDateManager *)sharedInstance{
    static dispatch_once_t once;
    static PL_ProvidenceDateManager * singleton;
    dispatch_once( &once,^{
        singleton = [[PL_ProvidenceDateManager alloc] init];
        singleton.dateFormatter = [[NSDateFormatter alloc] init];
    });
    return singleton;
}



- (NSNumber *)timeStamp_now;
{
    NSDate * nowDate = [NSDate date];
    NSNumber * timeStamp = [NSNumber numberWithDouble:[nowDate timeIntervalSince1970]*1000];
    return timeStamp;
}
@end
