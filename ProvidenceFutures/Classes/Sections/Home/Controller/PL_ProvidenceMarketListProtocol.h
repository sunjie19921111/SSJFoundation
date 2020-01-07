//
// //
//
//  Created by Journey on 2019/11/30.
//
// Mac on 2019-04-22.
// Copyright (c) 2019 ASO. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PL_ProvidenceMarketListModel,PL_ProvidenceHomeBaseView;


@protocol PL_ProvidenceMarketListProtocol <NSObject>

- (void)PL_ProvidencemarketListView:(PL_ProvidenceHomeBaseView *)listView didSelectedModel:(PL_ProvidenceMarketListModel *)listModel indexPath:(NSIndexPath *)indexPath;

/**
 数据加载完成

 @param listView 列表视图
 */
- (void)PL_ProvidencemarketListViewDidLoadData:(PL_ProvidenceHomeBaseView *)listView;
/**
 需要展示搜索界面

 @param listView 列表
 */
- (void)PL_ProvidencemarketListViewShouldShowSearch:(PL_ProvidenceHomeBaseView *)listView;
/**
 列表视图被选中

 @param listView 列表视图
 @param listModel 选中的模型
 @param indexPath 选中的位置
 */



@end
