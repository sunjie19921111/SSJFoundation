//
//  PL_ProvidenceHomeStockModel.h
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/15.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PL_ProvidenceHomeStockModel : NSObject<NSCoding>

/*
 {
 amount = "25449953.000";
 buy = "4.490";
 "buy_five" = 41200;
 "buy_five_pri" = "4.450";
 "buy_four" = 23600;
 "buy_four_pri" = "4.460";
 "buy_one" = 33400;
 "buy_one_pri" = "4.490";
 "buy_three" = 33900;
 "buy_three_pri" = "4.470";
 "buy_two" = 204448;
 "buy_two_pri" = "4.480";
 changepercent = "0.220";
 code = 600006;
 dayurl = "http://image.sinajs.cn/newchart/daily/n/sh600006.gif";
 high = "4.570";
 id = 3;
 low = "4.480";
 minurl = "http://image.sinajs.cn/newchart/min/n/sh600006.gif";
 monthurl = "http://image.sinajs.cn/newchart/monthly/n/sh600006.gif";
 name = "\U4e1c\U98ce\U6c7d\U8f66";
 open = "4.530";
 pricechange = "0.010";
 sell = "4.500";
 "sell_five" = 41900;
 "sell_five_pri" = "4.540";
 "sell_four" = 105800;
 "sell_four_pri" = "4.530";
 "sell_one" = 127700;
 "sell_one_pri" = "4.500";
 "sell_three" = 30500;
 "sell_three_pri" = "4.520";
 "sell_two" = 46400;
 "sell_two_pri" = "4.510";
 settlement = "4.530";
 symbol = sh600006;
 ticktime = "2019-10-08 15:00:02";
 trade = "4.490";
 volume = 5614932;
 weekurl = "http://image.sinajs.cn/newchart/weekly/n/sh600006.gif";
 }
 
 
 
 */


@property (nonatomic,strong)NSString * anwserContent;

@property (nonatomic,strong)NSString * createTime;

@property (nonatomic,strong)NSString * replyTime;

@property (nonatomic,strong)NSString * feedID;

@property (nonatomic,strong)NSString * userID;

@property (nonatomic,strong)NSString * replyStatus;

@property (nonatomic,strong)NSMutableArray  *imgUrlArray;


@property (copy, nonatomic) NSString *ID;

/** 唯一代码 */
@property (strong, nonatomic) NSString *symbol;

/** 股票简码 */
@property (strong, nonatomic) NSString *code;

/** 名称 */
@property (strong, nonatomic) NSString *name;

/** 最新成交价 / 收盘价 */
@property (strong, nonatomic) NSString *trade;

/** 价格涨跌额 */
@property (strong, nonatomic) NSString *pricechange;

/** 涨跌幅 */
@property (strong, nonatomic) NSString *changepercent;

/** 买一 */
@property (strong, nonatomic) NSString *buy;

/** 卖一 */
@property (strong, nonatomic) NSString *sell;

/** 昨收 */
@property (strong, nonatomic) NSString *settlement;

/** 开盘价 */
@property (strong, nonatomic) NSString *open;

/** 最高价 */
@property (strong, nonatomic) NSString *high;

/** 最低价 */
@property (strong, nonatomic) NSString *low;

/** 成交量 */
@property (strong, nonatomic) NSString *volume;

/** 成交额 */
@property (strong, nonatomic) NSString *amount;

/** 时间 */
@property (strong, nonatomic) NSString *ticktime;

/** 成交数量 */
@property (copy, nonatomic) NSString *hands;


@property (copy, nonatomic) NSString *minurl;
/** 价格 */



// ------ 美股模型 ---
/* 模型 */
@property (strong, nonatomic) NSString *cname;
/* 板块 */
@property (strong, nonatomic) NSString *category;
/* 最新价 */
@property (strong, nonatomic) NSString *price;
/* 涨跌额 */
@property (strong, nonatomic) NSString *diff;
/* 涨跌幅 */
@property (strong, nonatomic) NSString *chg;
/* 昨收 */
@property (strong, nonatomic) NSString *preclose;
/* 振幅 */
@property (strong, nonatomic) NSString *amplitude;
/* 市值 */
@property (strong, nonatomic) NSString *mktcap;
/* 上市交易所 */
@property (strong, nonatomic) NSString *market;
/* 最新成交价 */
@property (strong, nonatomic) NSString *lasttrade;

/** 所属市场代码  sz、usa、hk 等 */
@property (strong, nonatomic) NSString *marketCode;

#pragma mark - 扩展属性 --
/* 是否是股指 */
@property (assign, nonatomic) BOOL isIndex;


//内容
@property (nonatomic,strong)NSString    *content;
//副标题
@property (nonatomic,strong)NSString    *subTitle;
//修改时间
@property (nonatomic,strong)NSString    *modifyDate;
//状态
@property (nonatomic,strong)NSString    *status;
//

/** 所属市场代码  sz、usa、hk 等 */
@property (strong, nonatomic) NSString *marketCode;

#pragma mark - 扩展属性 --
/* 是否是股指 */
@property (assign, nonatomic) BOOL isIndex;

/**
 根据api51的数据创建模型
 */
+ (instancetype)createWithAPI51Array:(NSArray *)array;

/**
 转换成51Api支持的symbol格式
 */
- (NSString * _Nullable)convertTo51ApiSymbol;

@end

NS_ASSUME_NONNULL_END
