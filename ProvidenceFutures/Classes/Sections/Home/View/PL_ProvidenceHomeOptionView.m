//
//  PL_ProvidenceHomeOptionView.m
//  kkcoin
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// walker on 2018/8/15.
//  Copyright © 2018年 KKCOIN. All rights reserved.
//

#import "PL_ProvidenceHomeOptionView.h"
#import "PL_ProvidenceHomeOptionCell.h"


static NSString *const PL_ProvidenceMainSelectedViewCell_id_1 = @"PL_ProvidenceMainSelectedViewCell_id_1";

@interface PL_ProvidenceHomeOptionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *titles;

@property (strong, nonatomic) UICollectionView *collectionView;

@property (strong, nonatomic) UICollectionViewFlowLayout *flowLayout;

@property (strong, nonatomic) NSIndexPath *selectedIndexPath;

@end

@implementation PL_ProvidenceHomeOptionView

/**
 初始化方法
 
 @param frame 尺寸
 @param titles 选项标题的集合
 */
- (instancetype)initWithFrame:(CGRect)frame itemsTitles:(NSArray <NSString *>*)titles {
    
    if (self = [super initWithFrame:frame]) {
        
        if (titles && titles.count > 0) {
            self.titles = [titles copy];
        }
        
        [self PL_Providenceinitialize];;
        
        [self PL_ProvidenceconfigUI];
    }
    return self;
}


#pragma mark - 懒加载 --

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[];
    }
    return _titles;
}

- (UICollectionView *)collectionView {
    
    if(!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[PL_ProvidenceHomeOptionCell class] forCellWithReuseIdentifier:PL_ProvidenceMainSelectedViewCell_id_1];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _flowLayout.itemSize = CGSizeMake((SCREEN_Width - SCALE_Length(100.0f)) / 4.0f, SCALE_Length(30.0f));
        _flowLayout.minimumInteritemSpacing = SCALE_Length(10.0f);
        _flowLayout.minimumLineSpacing = SCALE_Length(10.0f);
        _flowLayout.sectionInset = UIEdgeInsetsMake(SCALE_Length(10.0f), SCALE_Length(15.0f), SCALE_Length(10.0f), SCALE_Length(15.0f));
        
    }
    return _flowLayout;
}



#pragma mark - collectionView的代理方法

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PL_ProvidenceHomeOptionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:PL_ProvidenceMainSelectedViewCell_id_1 forIndexPath:indexPath];
    
    cell.cellLabel.text = self.titles[indexPath.row];
    if (self.selectedIndexPath && [self.selectedIndexPath isEqual:indexPath]) {
        [cell setIsSelected:YES];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellTitle = @"";
    if (indexPath.row < self.titles.count) {
        cellTitle = [self.titles objectAtIndex:indexPath.row];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(selectedView:selectedItemTitle:indexPath:)]) {
        [_delegate selectedView:self selectedItemTitle:cellTitle indexPath:indexPath];
    }
    [self setItemSelectedState:YES atIndexPath:indexPath];
}

- (void)setItemSelectedState:(BOOL)isSelected atIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath && indexPath.row < self.titles.count) {
        
        self.selectedIndexPath = indexPath;
        
        [self.collectionView reloadData];
    }
}

- (void)PL_Providenceinitialize {
    
}

- (void)PL_ProvidenceconfigUI {
    
    [self addSubview:self.collectionView];
    
    [self PL_ProvidencelayoutWithMasonry];
}

- (void)PL_ProvidencelayoutWithMasonry {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

/**
 取消所有cell的选中状态
 */
- (void)PL_ProvidenceclearItemSelectedState {
    
    for (PL_ProvidenceHomeOptionCell *cell in self.collectionView.visibleCells) {
        [cell setIsSelected:NO];
    }
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}


@end
