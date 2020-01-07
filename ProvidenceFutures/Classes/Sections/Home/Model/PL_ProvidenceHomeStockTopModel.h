//
//  PL_ProvidenceHomeStockTopModel.h
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
//2019/10/8.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeStockTopModel : NSObject



@property (nonatomic,strong)NSString    *invalidDay;

@property (nonatomic,strong)NSString    *createDate;

@property (nonatomic,strong)NSString    *modifyDate;

@property (nonatomic,strong)NSString    *invalidType;

@property (nonatomic,assign)BOOL        isRead;

//////////////////////

@property (nonatomic, strong) NSString *deal_num;
@property (nonatomic, strong) NSString *deal_pri;
@property (nonatomic, strong) NSString *high_pri;
@property (nonatomic, strong) NSString *ID;
@property (nonatomic, strong) NSString *incre_per;
@property (nonatomic, strong) NSString *increase;
@property (nonatomic, strong) NSString *name;



@end

NS_ASSUME_NONNULL_END
