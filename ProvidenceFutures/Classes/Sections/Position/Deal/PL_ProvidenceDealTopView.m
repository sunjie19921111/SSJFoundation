//
//  PL_ProvidenceDealTopView.m
//  ProvidenceFutures
//
//  //
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Journey on 2019/11/30.
//
//2019/12/3.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceDealTopView.h"
#import "PL_ProvidenceDealModel.h"
#import "PL_ProvidenceFavDBManager.h"

@implementation PL_ProvidenceDealTopView


- (void)awakeFromNib {
    [super awakeFromNib];
    self.nameLabel.text = k_CurrentLoginData.username;
    
    NSData *imagedata = [[NSUserDefaults standardUserDefaults] objectForKey:@"imageData"];
    if (imagedata.length >0) {
        _headImg.image = [UIImage imageWithData:imagedata];
    }
}


- (void)refresh {
       
    
        NSArray *favLists = [[PL_ProvidenceDataManager manager] getAllModels];
        
        __block float availableMoney = 0;
        [favLists enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            availableMoney += [obj.avgPrice floatValue] * [obj.postion floatValue];
        }];
        
        [[PL_ProvidenceFavDBManager manager] getPositionArrayWithCallback:^(NSArray * _Nonnull favList) {
            [favList enumerateObjectsUsingBlock:^(PL_ProvidenceHomeStockModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (![obj.symbol containsString:@"sh"] || ![obj.symbol containsString:@"sz"]) {
                    availableMoney += [obj.trade floatValue] * [obj.hands floatValue];
                }
            }];
    //        self.dataSource = favList;
        }];
        
        __block float totalValue1 = 0;
        [favLists enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            totalValue1  += [obj.priceNow floatValue] * [obj.postion floatValue];
        }];
        
        NSString *totalValue = nil;
        if (totalValue1 == 0) {
            totalValue = @"----";
        } else {
            totalValue = [NSString stringWithFormat:@"%.2lf",totalValue1];
        }
        
        __block float totalyk1 = 0;
        [favLists enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            
            totalyk1 += ([model.priceNow doubleValue] - [model.avgPrice doubleValue]) * [model.postion doubleValue];
        }];
        

        NSString *totalyk = nil;
        if (totalValue1 == 0) {
            totalyk  = @"----";
        } else {
            totalyk = [NSString stringWithFormat:@"%.2lf",totalyk1];
        }
        
        __block float onDayyk1 = 0;
        [favLists enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
            onDayyk1 += ([model.priceNow doubleValue] - [model.settlement doubleValue]) * [model.postion doubleValue];
        }];
        
        NSString *onDayyk = nil;
        if (totalValue1 == 0) {
            onDayyk  = @"----";
        } else {
            onDayyk = [NSString stringWithFormat:@"%.2lf",onDayyk1];
        }
        onDayyk  = @"----";
    //    NSInteger result = [NSString compareDate:model.time withDate:[NSString localStringFromUTCDate:[NSDate date]]];
    //
    //    if (result == 0) {
    //        onDayyk  = @"----";
    //    }
        
        NSString *totalIntegral = k_MoneyManagerModel.totalIntegral ? k_MoneyManagerModel.totalIntegral : @"---";;
        NSString *availableIntegral = [NSString stringWithFormat:@"%.2f",[totalIntegral floatValue] - availableMoney];
    
    self.totalValue.text = totalIntegral;
    self.totalYk.text = totalyk;
    self.dyValue.text = totalValue;
    

    
        
//        self.dataSource = @[@{@"title":@"持仓市值",@"des":totalIntegral},@{@"title":@"持总盈亏",@"des":totalyk},@{@"title":@"当日盈亏",@"des":onDayyk},@{@"title":@"总积分",@"des":totalIntegral},@{@"title":@"可用",@"des":availableIntegral},@{@"title":@"申请积分",@"des":@""}];
}

@end
