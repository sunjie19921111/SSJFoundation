//
//  PL_ProvidenceHomeModel.h
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

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeModel : NSObject

@property (nonatomic,strong)NSMutableArray  *afficheDataArray;

@property (nonatomic,strong)NSMutableArray  *adDataArray;

@property (nonatomic,assign)int             unreadNum;

@property (nonatomic,assign)BOOL            isAdCache;

@property (nonatomic, strong) NSArray *zz;
@property (nonatomic, strong) NSArray *dl;
@property (nonatomic, strong) NSArray *sh;

@end

NS_ASSUME_NONNULL_END
