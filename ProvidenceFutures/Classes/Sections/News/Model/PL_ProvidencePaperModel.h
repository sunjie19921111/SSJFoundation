//
//  PL_ProvidencePaperModel.h
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
//2019/9/30.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidencePaperModel : NSObject

@property (nonatomic,strong)NSString    *orderWeight;

@property (nonatomic,strong)NSString    *sourceType;

@property (nonatomic,strong)NSString    *newsID;
//标题----
@property (nonatomic,strong) NSString    *title;

@property (nonatomic,strong) NSString    *image;

@property (nonatomic,strong) NSString    *desc;

@property (nonatomic,strong) NSString    *ID;

@property (nonatomic,strong) NSString    *date;

@property (nonatomic,strong)NSString    *keyword;
//创建人员
@property (nonatomic,strong)NSString    *createStaffName;

@property (nonatomic,strong)NSString    *newsPlateIdList;



@end

NS_ASSUME_NONNULL_END
