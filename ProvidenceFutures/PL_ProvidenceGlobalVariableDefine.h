//
//  PL_ProvidenceGlobalVariableDefine.h
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
//2019/11/14.
//  Copyright © 2019 qhwr. All rights reserved.
//

#ifndef PL_ProvidenceGlobalVariableDefine_h
#define PL_ProvidenceGlobalVariableDefine_h

/* K线主图样式 */
typedef enum : NSUInteger {
    KLineMainViewTypeKLine = 1,     // K线图(蜡烛图)
    KLineMainViewTypeKLineWithMA,   // K线图包含MA
    KLineMainViewTypeTimeLine,      // 分时图
    KLineMainViewTypeTimeLineWithMA,// 分时图包含MA
    KLineMainViewTypeKLineWithBOLL, // K线图包含BOLL指数
} KLineMainViewType;

/* K线附图样式 */
typedef enum : NSUInteger {
    KLineAssistantViewTypeVol = 1,      // 成交量
    KLineAssistantViewTypeVolWithMA,    // 成交量包含MA
    KLineAssistantViewTypeKDJ,          // KDJ
    KLineAssistantViewTypeMACD,         // MACD
    KLineAssistantViewTypeRSI,          // RSI
} KLineAssistantViewType;

/** 挂单列表的展示数据类型 */
typedef enum : NSUInteger {
    
    OrderBookDisPlayDataTypeAmount,             // 金额 / 币量
    OrderBookDisPlayDataTypeCount,              // 数量
    
}OrderBookDisPlayDataType;



#endif /* PL_ProvidenceGlobalVariableDefine_h */
