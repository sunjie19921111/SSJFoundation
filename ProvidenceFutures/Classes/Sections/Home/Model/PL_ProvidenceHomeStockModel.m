//
//  PL_ProvidenceHomeStockModel.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceHomeStockModel.h"

@implementation PL_ProvidenceHomeStockModel


- (NSString *)trade {
    if (isStrEmpty(_trade)) {
        if(!isStrEmpty(_price)) {
            return _price;
        }
        if (!isStrEmpty(_lasttrade)) {
            return _lasttrade;
        }
    }
    
    return _trade;
}

- (NSString *)code {
    if (isStrEmpty(_code)) {
        return _symbol;
    }
    return _code;
}

- (NSString *)name {
    if (isStrEmpty(_name)) {
        return _cname;
    }
    return _name;
}

- (NSString *)settlement {
    if (isStrEmpty(_settlement)) {
        return _preclose;
    }
    return _settlement;
}

- (NSString *)pricechange {
    if (isStrEmpty(_pricechange)) {
        return _diff;
    }
    return _pricechange;
}

- (NSString *)changepercent {
    if (isStrEmpty(_changepercent)) {
        return _chg;
    }
    return _changepercent;
}


+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID":@"id"};
}

MJCodingImplementation;

- (NSString * _Nullable)convertTo51ApiSymbol {

    NSString *symbol = nil;
    NSString *market51Code = @"";
    if (!isStrEmpty(_marketCode)) {

        if ([_marketCode isEqualToString:@"sh"]) {
            market51Code = @"SS";
        }else if ([_marketCode isEqualToString:@"sz"]) {
            market51Code = @"SZ";
        }

        if (!isStrEmpty(_code) && !isStrEmpty(market51Code)) {
            symbol = [NSString stringWithFormat:@"%@.%@",_code,market51Code];
        }
    }

    return symbol;
}

@end
