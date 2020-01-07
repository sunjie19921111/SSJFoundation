//
//  FSMStateUtil.h
//  RealReachability
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Dustturtle on 16/1/9.
//  Copyright (c) 2016 Dustturtle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FSMDefines.h"

@interface FSMStateUtil : NSObject

+ (RRStateID)RRStateFromValue:(NSString *)LCEventValue;

+ (RRStateID)RRStateFromPingFlag:(BOOL)isSuccess;

@end
