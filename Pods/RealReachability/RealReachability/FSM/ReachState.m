//
//  ReachState.m
//  RealReachability
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Dustturtle on 16/1/19.
//  Copyright © 2016 Dustturtle. All rights reserved.
//

#import "ReachState.h"

@implementation ReachState

+ (id)state
{
    return [[self alloc] init];
}

- (RRStateID)onEvent:(NSDictionary *)event withError:(NSError **)error
{
    return RRStateInvalid;
}

@end
