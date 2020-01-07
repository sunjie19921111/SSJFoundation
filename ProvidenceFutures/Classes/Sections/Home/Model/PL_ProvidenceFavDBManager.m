//
//  PL_ProvidenceFavDBManager.m
//  PL_ProvidenceStockProject
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019/4/18.
//  Copyright © 2019 GhostLord. All rights reserved.
//

#import "PL_ProvidenceFavDBManager.h"
#import "PL_ProvidenceHomeStockModel.h"



@interface PL_ProvidenceFavDBManager ()

@property (readwrite, strong, nonatomic) NSMutableArray *assertArray;
@property (readwrite, strong, nonatomic) NSMutableArray *favArray;
@property (readwrite, strong, nonatomic) NSMutableArray *positionArray;


@end

@implementation PL_ProvidenceFavDBManager
#pragma mark - 单例相关 -----begin---
/*
 创建静态对象 防止外部访问
 */
static PL_ProvidenceFavDBManager *_manager;

/**
 重写初始化方法
 */
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_manager == nil) {
            _manager = [super allocWithZone:zone];
            
            [_manager single_dfsbfd:@"daslkl" dagqwg:@(arc4random() % 457)];
            
            [_manager favArray];
        }
    });
    return _manager;
}

/**
 初始化单例
 
 @return Socket管理中心单例
 */
+ (instancetype)manager
{
    return [[self alloc]init];;
}

/**
 重写copyWithZone
 */
-(id)copyWithZone:(NSZone *)zone
{
    return _manager;
}

/**
 重写mutableCopyWithZone
 */
-(id)mutableCopyWithZone:(NSZone *)zone
{
    return _manager;
}
#pragma mark - 单例相关 ----- end ---

#pragma mark - 公共方法 --

/**
 获得收藏列表
 
 @param callBack 回调
 */
- (void)getFavArrayWithCallback:(void(^)(NSArray *favList))callBack {

    if (self.favArray) {
        !callBack ? : callBack(self.favArray);
    }
}

/**
 获得持仓列表
 
 @param callBack 回调
 */
- (void)getPositionArrayWithCallback:(void(^)(NSArray *favList))callBack {
    
    if (self.favArray) {
        !callBack ? : callBack(self.positionArray);
    }
}


/**
 查找是否持仓
 
 @param symbol 股票唯一标识符
 @return 收藏为YES
 */
- (BOOL)isPostionWithSymbol:(NSString *)symbol {
    
    BOOL isExist = NO;
    for (PL_ProvidenceHomeStockModel *tempModel in self.favArray) {
        
        if ([tempModel.symbol isEqualToString:symbol]) {
            isExist = YES;
        }
    }
    
    return isExist;
}

/**
 查找是否收藏
 
 @param symbol 股票唯一标识符
 @return 收藏为YES
 */
- (BOOL)isFavWithSymbol:(NSString *)symbol {
    
    BOOL isExist = NO;
    for (PL_ProvidenceHomeStockModel *tempModel in self.favArray) {
        
        if ([tempModel.symbol isEqualToString:symbol]) {
            isExist = YES;
        }
    }
    
    return isExist;
}

/**
 添加自选
 
 @param listModel 自选模型
 @param callBack 回调
 */
- (void)addFavWithMarketListModel:(PL_ProvidenceHomeStockModel *)listModel callBack:(FavCallBackBlock)callBack {
    
    if (!listModel) {
        !callBack ? : callBack(NO, listModel);
        return;
    }
    
    if (![self isFavWithSymbol:listModel.symbol]) {
        
        [self.favArray addObject:listModel];
        
        [self p_saveFavArray];
    }
    
    !callBack ? : callBack(YES, listModel);
}

/**
 添加持仓
 
 @param listModel 自选模型
 @param callBack 回调
 */
- (void)addPositionWithMarketListModel:(PL_ProvidenceHomeStockModel *)listModel callBack:(FavCallBackBlock)callBack {
    
    if (!listModel) {
        !callBack ? : callBack(NO, listModel);
        return;
    }
    
    if (![self isPostionWithSymbol:listModel.symbol]) {
        
        [self.positionArray addObject:listModel];
        
        [self p_savePositionArray];
    }
    
    !callBack ? : callBack(YES, listModel);
}


/**
 移除自选
 
 @param listModel 自选模型
 @param callBack 回调
 */
- (void)removeFavWithListModel:(PL_ProvidenceHomeStockModel *)listModel callBack:(FavCallBackBlock)callBack {
    
    if (!listModel) {
        !callBack ? : callBack(NO, listModel);
        return;
    }
    
    if ([self isFavWithSymbol:listModel.symbol]) {
        
        for (PL_ProvidenceHomeStockModel *tempModel in [self.favArray copy]) {
            
         if ([tempModel.symbol isEqualToString:listModel.symbol]) {
                [self.favArray removeObject:tempModel];
                break;
            }
        }
        
        [self p_saveFavArray];
    }
    
    !callBack ? : callBack(YES, listModel);
}

/**
 移除持仓
 
 @param listModel 自选模型
 @param callBack 回调
 */
- (void)removePostionWithListModel:(PL_ProvidenceHomeStockModel *)listModel callBack:(FavCallBackBlock)callBack {
    
    if (!listModel) {
        !callBack ? : callBack(NO, listModel);
        return;
    }
    
    if ([self isPostionWithSymbol:listModel.symbol]) {
        
        for (PL_ProvidenceHomeStockModel *tempModel in [self.favArray copy]) {
            
            if ([tempModel.symbol isEqualToString:listModel.symbol]) {
                [self.favArray removeObject:tempModel];
                break;
            }
        }
        
        [self p_savePositionArray];
    }
    
    !callBack ? : callBack(YES, listModel);
}

#pragma mark - 私有方法 --

- (NSArray *)p_getFavInfoFromLocal {
    
    NSArray *favDict = [NSKeyedUnarchiver unarchiveObjectWithFile:PL_ProvidenceArchiverPath_Fav];
    
    return favDict ? : @[];
}

- (NSArray *)p_getPositionInfoFromLocal {
    
    NSArray *favDict = [NSKeyedUnarchiver unarchiveObjectWithFile:PL_ProvidenceArchiverPath_Position];
    
    return favDict ? : @[];
}

- (NSArray *)p_getAssertInfoFromLocal {
    
    NSArray *assertDict = [NSKeyedUnarchiver unarchiveObjectWithFile:PL_ProvidenceArchiverPath_Assert];
    
    return assertDict ? : @[];
}

- (void)p_saveAssertArray {
    if (self.assertArray) {
        [NSKeyedArchiver archiveRootObject:self.assertArray toFile:PL_ProvidenceArchiverPath_Assert];
    }
}

- (void)p_saveFavArray {
    
    if (self.favArray) {
        [NSKeyedArchiver archiveRootObject:self.favArray toFile:PL_ProvidenceArchiverPath_Fav];
    }
}

- (void)p_savePositionArray {
    
    if (self.positionArray) {
        [NSKeyedArchiver archiveRootObject:self.positionArray toFile:PL_ProvidenceArchiverPath_Position];
    }
}


#pragma mark - lazy load ---

- (NSMutableArray *)favArray {
    
    if (!_favArray) {
        
        _favArray = [[self p_getFavInfoFromLocal] mutableCopy];
    }
    return _favArray;
}

- (NSMutableArray *)positionArray {
    if (!_positionArray) {
        _positionArray = [self p_getPositionInfoFromLocal].mutableCopy;
    }
    return _positionArray;
}

- (NSMutableArray *)assertArray {
    if (!_assertArray) {
        _assertArray = [self p_getAssertInfoFromLocal].mutableCopy;
    }
    return _assertArray;
}

@end
