//
//  PL_ProvidenceBaseListView.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceHomeBaseView.h"

@interface PL_ProvidenceHomeBaseView ()

/* 标识符 */
@property (readwrite, strong, nonatomic) NSString *identifier;


@end

@implementation PL_ProvidenceHomeBaseView

/**
 更新id

 @param identifier 标识符
 */
- (void)updateIdentifier:(NSString *)identifier {

    if (!isStrEmpty(identifier)) {
        self.identifier = identifier;
    }
}

- (void)reloadNewData {
    
}



- (instancetype)initWithFrame:(CGRect)frame identifier:(NSString *)identifier  {
    if (self = [super initWithFrame:frame]) {

        self.identifier = STRINGNOTNIL(identifier);
    }
    return self;
}



@end
