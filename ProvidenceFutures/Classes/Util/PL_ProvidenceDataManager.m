//
//  PL_ProvidenceDataManager.m
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
//2019/10/10.
//  Copyright © 2019 qhwr. All rights reserved.
//
#import "PL_ProvidenceDealModel.h"
#import "PL_ProvidenceMarketLogic.h"
#import "PL_ProvidenceHomeStockModel.h"
#import "PL_ProvidenceDataManager.h"
#import <FMDB.h>





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

static const void * const SXDispatchMyCacheiOSpecificKey = &SXDispatchMyCacheiOSpecificKey;
typedef void(^dispatch_myCacheblock)(void);

dispatch_queue_t SXDispatchMyCacheIOQueue() {
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("education.myCacheio.queue", 0);
        dispatch_queue_set_specific(queue, SXDispatchMyCacheiOSpecificKey, (void *)SXDispatchMyCacheiOSpecificKey, NULL);
    });
    return queue;
}

void myCache_io_sync_safe (dispatch_myCacheblock block) {
    if (dispatch_get_specific(SXDispatchMyCacheiOSpecificKey)) {
        block();
    } else {
        dispatch_sync(SXDispatchMyCacheIOQueue(), ^() {
            block();
        });
    }
}

void myCache_io_async (dispatch_myCacheblock block) {
    dispatch_async(SXDispatchMyCacheIOQueue(), ^() {
        block();
    });
}


@interface PL_ProvidenceAssetModelImpl : NSObject

@property (nonatomic, strong) PL_ProvidenceDealModel *model;

- (instancetype)initWithFMResultSet:(FMResultSet *)resultSet;

@end

@implementation PL_ProvidenceAssetModelImpl

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
    }
    return self;
}

@end

@interface PL_ProvidenceDataManager ()

@property (nonatomic, strong) FMDatabase  *myCachedb;

@end

@implementation PL_ProvidenceDataManager


+ (instancetype)manager {
    static PL_ProvidenceDataManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once (&onceToken, ^{
        //您想要做什么? (注:该线程只执行一次 )
        manager = [[PL_ProvidenceDataManager alloc] init];
    });
    
    return manager;
}

- (instancetype)init {
    
    if (self = [super init]) {
        _myCachedb = [[FMDatabase alloc] initWithPath:[self getMyCachePath]];
        if ([_myCachedb open]) { // AUTOINCREMENT 自动递增的UID/
            NSString * sql = @"CREATE TABLE IF NOT EXISTS MM_TABLE (ID INTEGER PRIMARY KEY AUTOINCREMENT,symbol TEXT ,avgPrice TEXT,code TEXT,name TEXT ,postion TEXT,availPosition TEXT,profit TEXT ,totalProfitRate TEXT,profitRate TEXT,totalProfit TEXT,priceNow TEXT,settlement TEXT,time TEXT)";
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

- (NSString *)getMyCachePath {
    NSString *path =  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filepath = [path stringByAppendingPathComponent:@"MyModelsCache.db"];
 
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

- (BOOL)insertModel:(PL_ProvidenceDealModel *)model {
    
    __block BOOL result;
    myCache_io_sync_safe(^{
        PL_ProvidenceDealModel *myCacheModel = [self getMyCacheModelSymbol:model.symbol];
//        if (!myCacheModel ) {
            if ([self.myCachedb open]) {
                NSString * sql = @"INSERT INTO MM_TABLE (symbol,avgPrice,code,name,postion,availPosition,profit,totalProfitRate,profitRate,totalProfit,priceNow,settlement,time) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)";
                NSError *error;
                
                NSArray *values = @[kStrEmpty(model.symbol),kStrEmpty(model.avgPrice),kStrEmpty(model.code),kStrEmpty(model.name),kStrEmpty(model.postion),kStrEmpty(model.availPosition),kStrEmpty(model.profit),kStrEmpty(model.totalProfitRate),kStrEmpty(model.profitRate),kStrEmpty(model.totalProfit),kStrEmpty(model.priceNow),kStrEmpty(model.settlement),model.time];
             
                result = [self.myCachedb executeUpdate:sql values:values error:&error];
                if (!result) {
                    NSLog(@"totle Database insert fail, with error = %@",error);
                }
            }
//        }
    });
    return result;
}

- (BOOL)updateMyCachePriceNow:(PL_ProvidenceDealModel *)model  {
   weakSelf(self)
    __block BOOL result;
    myCache_io_sync_safe(^{
        if ([weakSelf.myCachedb open]) {
            
            result = [weakSelf.myCachedb executeUpdate:@"UPDATE MM_TABLE SET priceNow = ? , settlement = ? where symbol = ?",
                      model.priceNow,model.settlement,model.symbol];
            if (!result) {
                NSLog(@"totle Database update fail");
            }
        }
    });
    return result;
}

- (BOOL)updateMyCachePostion:(PL_ProvidenceDealModel *)model  {
    weakSelf(self)
    __block BOOL result;
    myCache_io_sync_safe(^{
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
    myCache_io_sync_safe(^{
        PL_ProvidenceDealModel *model = [self getMyCacheModelSymbol:symbol];
        if (model) {
            [self deleteModel:model];
        }
    });
}

- (void)deleteModel:(PL_ProvidenceDealModel *)model {
    weakSelf(self)
    myCache_io_sync_safe(^{
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
    myCache_io_async(^{
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

- (PL_ProvidenceDealModel *)getMyCacheModelSymbol:(NSString *)symbol  {
    weakSelf(self)
    __block PL_ProvidenceDealModel * model = nil;
    myCache_io_sync_safe(^{
        if ([weakSelf.myCachedb open]) {
            NSString * sql = @"SELECT * FROM MM_TABLE WHERE symbol = ?";
            FMResultSet * resultSet = [weakSelf.myCachedb executeQuery:sql,symbol];
            while ([resultSet next]) {
                PL_ProvidenceAssetModelImpl *lmpl = [[PL_ProvidenceAssetModelImpl alloc] initWithFMResultSet:resultSet];
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
    myCache_io_sync_safe(^{
        if ([weakSelf.myCachedb open]) {
            NSMutableArray * arrayM = [NSMutableArray arrayWithCapacity:1];
            NSString * sql = @"SELECT * FROM MM_TABLE";
            FMResultSet * resultSet = [weakSelf.myCachedb executeQuery:sql];
            while ([resultSet next]) {
               PL_ProvidenceAssetModelImpl *lmpl = [[PL_ProvidenceAssetModelImpl alloc] initWithFMResultSet:resultSet];
                [arrayM addObject:lmpl.model];
            }
            result = arrayM;
        }
    });
    return result;
}

- (BOOL)deleteDataBase {
    
    __block BOOL success = NO;
    myCache_io_async(^{
        success = [[NSFileManager defaultManager]removeItemAtPath:[self getMyCachePath] error:nil];
    });
    return success;
}

- (void)start {

}

- (void)update {
    NSArray *models = [[PL_ProvidenceDataManager manager] getAllModels];
    
    [models enumerateObjectsUsingBlock:^(PL_ProvidenceDealModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *market = [obj.symbol substringToIndex:2];
        [PL_ProvidenceMarketLogic getMarketDetailhMarket:market symbol:obj.symbol uccess:^(PL_ProvidenceHomeStockModel * _Nonnull model) {
            if (!model) {
                return;
            }
            obj.priceNow = model.trade;
            
            NSInteger result = [NSString compareDate:obj.time withDate:[NSString localStringFromUTCDate:[NSDate date]]];
            
            if (result == 0) {
                 obj.settlement = @"0";
            } else {
                obj.settlement = model.settlement;
            }
           
//            obj.priceNow = @"90";
//            obj.settlement = @"88";
            [self updateMyCachePriceNow:obj];
        } faild:^(NSError * _Nonnull error) {
            
        }];
    }];
}

@end
