//
//  PL_ProvidenceDealDataManager.m
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
//2019/11/11.
//  Copyright © 2019 qhwr. All rights reserved.
//

#import "PL_ProvidenceDealDataManager.h"
#import <FMDB.h>
#import "PL_ProvidenceDealModel.h"
#import "PL_ProvidenceMarketLogic.h"
#import "PL_ProvidenceHomeStockModel.h"



#define ksymbol                      @"symbol"
#define kavgPrice                    @"avgPrice"
#define kcode                        @"code"
#define kname                        @"name"
#define kpostion                     @"postion"
#define kavailPosition               @"availPosition"
#define kprofit                      @"profit"
#define kprofitRate                  @"profitRate"

#define kmarketValue                 @"marketValue"
#define ktotalProfitRate             @"totalProfitRate"
#define ktotalProfit                 @"totalProfit"
#define kpriceNow                    @"priceNow"
#define ksettlement                  @"settlement"
#define ktime                        @"time"

#define kbuysell                     @"buysell"
#define kdate                        @"date"

static const void * const SXAssertDispatchMyCacheiOSpecificKey = &SXAssertDispatchMyCacheiOSpecificKey;
typedef void(^dispatch_myCacheblock)(void);

dispatch_queue_t SXAssertDispatchMyCacheIOQueue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("education.myCacheio.queue", 0);
        dispatch_queue_set_specific(queue, SXAssertDispatchMyCacheiOSpecificKey, (void *)SXAssertDispatchMyCacheiOSpecificKey, NULL);
    });
    return queue;
}

void AssertmyCache_io_sync_safe (dispatch_myCacheblock block) {
    if (dispatch_get_specific(SXAssertDispatchMyCacheiOSpecificKey)) {
        block();
    } else {
        dispatch_sync(SXAssertDispatchMyCacheIOQueue(), ^() {
            block();
        });
    }
}

void AssertmyCache_io_async (dispatch_myCacheblock block) {
    dispatch_async(SXAssertDispatchMyCacheIOQueue(), ^() {
        block();
    });
}


@interface PL_ProvidenceAssetModel2Impl : NSObject

@property (nonatomic, strong) PL_ProvidenceDealModel *model;

- (instancetype)initWithFMResultSet:(FMResultSet *)resultSet;

@end

@implementation PL_ProvidenceAssetModel2Impl

- (instancetype)initWithFMResultSet:(FMResultSet *)resultSet {
    if (self= [super init]) {
        
        _model = [[PL_ProvidenceDealModel alloc]init];
        _model.symbol = [resultSet objectForColumn:ksymbol];
        _model.avgPrice = [resultSet objectForColumn:kavgPrice];
        _model.code = [resultSet objectForColumn:kcode];
        _model.name = [resultSet objectForColumn:kname];
        _model.postion = [resultSet objectForColumn:kpostion];
        
        _model.availPosition = [resultSet objectForColumn:kavailPosition];
        _model.profit = [resultSet objectForColumn:kprofit];
        _model.totalProfitRate = [resultSet objectForColumn:ktotalProfitRate];
        _model.profitRate = [resultSet objectForColumn:kprofitRate];
        
        _model.totalProfit = [resultSet objectForColumn:ktotalProfit];
        _model.priceNow = [resultSet objectForColumn:kpriceNow];
        _model.settlement = [resultSet objectForColumn:ksettlement];
        _model.time = [resultSet objectForColumn:ktime];
        _model.dateString = [resultSet objectForColumn:kdate];
        _model.buySell = [resultSet objectForColumn:kbuysell];
    }
    return self;
}

@end

@interface PL_ProvidenceDealDataManager ()

@property (nonatomic, strong) FMDatabase  *myCachedb;

@end

@implementation PL_ProvidenceDealDataManager



- (NSString *)getMyCachePath {
    NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filepath = [path stringByAppendingPathComponent:@"MyAssertModelsCache.db"];
 
    if (![[NSFileManager defaultManager] fileExistsAtPath:filepath]) {
        BOOL result = [[NSFileManager defaultManager] createFileAtPath:filepath contents:nil attributes:nil] ;
        if (result) {
            NSLog(@"FMDB create success");
        } else {
            NSLog(@"FMDB create fail");
        }
    }
    return filepath ;
}


+ (instancetype)manager {
    static PL_ProvidenceDealDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        //您想要做什么? (注:该线程只执行一次 )
        manager = [[PL_ProvidenceDealDataManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    
    if (self = [super init]) {
        _myCachedb = [[FMDatabase alloc] initWithPath:[self getMyCachePath]];
        if ([_myCachedb open]) { // AUTOINCREMENT 自动递增的UID/
            NSString * sql = @"CREATE TABLE IF NOT EXISTS MM_TABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT,symbol TEXT ,avgPrice TEXT,code TEXT,name TEXT ,postion TEXT,availPosition TEXT,profit TEXT ,totalProfitRate TEXT,profitRate TEXT,totalProfit TEXT,priceNow TEXT,settlement TEXT,time TEXT,buysell  TEXT,date  TEXT)";
            BOOL rect = [_myCachedb executeUpdate:sql];
            if (rect) {
                NSLog(@"FMDB Table create success");
            }else {
                NSLog(@"FMDB Table create fail");
            }
        }
        //[self fmdbVersionUpdate];
    }
    return self;
}


- (BOOL)insertModel:(PL_ProvidenceDealModel *)model {
    
    __block BOOL result;
    AssertmyCache_io_sync_safe(^{
        PL_ProvidenceDealModel *myCacheModel = [self getMyCacheModelSymbol:model.symbol];
//        if (!myCacheModel ) {
            if ([self.myCachedb open]) {
                NSString * sql = @"INSERT INTO MM_TABLE (symbol,avgPrice,code,name,postion,availPosition,profit,totalProfitRate,profitRate,totalProfit,priceNow,settlement,time,buysell,date) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                NSError *error;
                
                NSArray *values = @[kStrEmpty(model.symbol),kStrEmpty(model.avgPrice),kStrEmpty(model.code),kStrEmpty(model.name),kStrEmpty(model.postion),kStrEmpty(model.availPosition),kStrEmpty(model.profit),kStrEmpty(model.totalProfitRate),kStrEmpty(model.profitRate),kStrEmpty(model.totalProfit),kStrEmpty(model.priceNow),kStrEmpty(model.settlement),model.time,model.buySell,model.dateString];
             
                result = [self.myCachedb executeUpdate:sql values:values error:&error];
                if (!result) {
                    NSLog(@"totle Database insert fail, with error = %@",error);
                }
            }
//        }
    });
    return result;
}

- (BOOL)updateMyCachePostion:(PL_ProvidenceDealModel *)model  {
    weakSelf(self)
    __block BOOL result;
    AssertmyCache_io_sync_safe(^{
        if ([weakSelf.myCachedb open]) {
            if (model.postion == 0) {
                [self deleteModel:model];  return;
            }
            
            result = [weakSelf.myCachedb executeUpdate:@"UPDATE MM_TABLE SET postion = ? where symbol = ?",
                      model.postion,model.symbol];
            if (!result) {
                NSLog(@"totle Database update fail");
            }
        }
    });
    return result;
}


- (void)deleteModelWithSymbol:(NSString *)symbol {
    AssertmyCache_io_sync_safe(^{
        PL_ProvidenceDealModel *model = [self getMyCacheModelSymbol:symbol];
        if (model) {
            [self deleteModel:model];
        }
    });
}

- (void)deleteModel:(PL_ProvidenceDealModel *)model {
    weakSelf(self)
    AssertmyCache_io_sync_safe(^{
        if ([weakSelf.myCachedb open]) {
            NSString * sql = @"DELETE FROM MM_TABLE WHERE symbol = ?";
            BOOL result = [weakSelf.myCachedb executeUpdate:sql,model.symbol];
            if (result) {
                NSLog(@"Data delete success");
            }else {
                NSLog(@"Data delete fail");
            }
        }
        
    });
}

- (void)deleteAllModel {
    weakSelf(self)
    AssertmyCache_io_async(^{
        if ([weakSelf.myCachedb open]) {
            NSString * sql = @"DELETE FROM MM_TABLE";
            BOOL result = [weakSelf.myCachedb executeUpdate:sql];
            if (result) {
                NSLog(@"Data delete success");
            }else {
                NSLog(@"Data delete fail");
            }
        }
    });
}

- (NSMutableArray *)getMyCacheModelBuySell:(NSString *)BuySell {
    weakSelf(self)
    __block NSMutableArray * models = [NSMutableArray arrayWithCapacity:1];
    AssertmyCache_io_sync_safe(^{
        if ([weakSelf.myCachedb open]) {
            NSString * sql = @"SELECT * FROM MM_TABLE WHERE buysell = ?";
            FMResultSet * resultSet = [weakSelf.myCachedb executeQuery:sql,BuySell];
            while ([resultSet next]) {
                PL_ProvidenceAssetModel2Impl *lmpl = [[PL_ProvidenceAssetModel2Impl alloc] initWithFMResultSet:resultSet];
                [models addObject:lmpl.model];
            }
        }
    });
    return models;
}


- (PL_ProvidenceDealModel *)getMyCacheModelSymbol:(NSString *)symbol  {
    weakSelf(self)
    __block PL_ProvidenceDealModel * model = nil;
    AssertmyCache_io_sync_safe(^{
        if ([weakSelf.myCachedb open]) {
            NSString * sql = @"SELECT * FROM MM_TABLE WHERE symbol = ?";
            FMResultSet * resultSet = [weakSelf.myCachedb executeQuery:sql,symbol];
            while ([resultSet next]) {
                PL_ProvidenceAssetModel2Impl *lmpl = [[PL_ProvidenceAssetModel2Impl alloc] initWithFMResultSet:resultSet];
                model = lmpl.model;
            }
        }
    });
    return model;
}

- (NSArray *)getAllModels
{
    weakSelf(self);
    __block NSArray *result = nil;
    AssertmyCache_io_sync_safe(^{
        if ([weakSelf.myCachedb open]) {
            NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:1];
            NSString * sql = @"SELECT * FROM MM_TABLE";
            FMResultSet * resultSet = [weakSelf.myCachedb executeQuery:sql];
            while ([resultSet next]) {
               PL_ProvidenceAssetModel2Impl *lmpl = [[PL_ProvidenceAssetModel2Impl alloc] initWithFMResultSet:resultSet];
                [arrayM addObject:lmpl.model];
            }
            result = arrayM;
        }
    });
    return result;
}

- (BOOL)deleteDataBase {
    
    __block BOOL success = NO;
    AssertmyCache_io_async(^{
        success = [[NSFileManager defaultManager]removeItemAtPath:[self getMyCachePath] error:nil];
    });
    return success;
}

@end


