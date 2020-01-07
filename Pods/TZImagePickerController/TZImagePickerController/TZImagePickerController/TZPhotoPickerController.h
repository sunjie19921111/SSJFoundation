//
//  TZPhotoPickerController.h
//  TZImagePickerController
//
//  //
//
//  Created by Journey on 2019/11/30.
//
// 谭真 on 15/12/24.
//  Copyright © 2015年 谭真. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TZAlbumModel;
@interface TZPhotoPickerController : UIViewController

@property (nonatomic, assign) BOOL isFirstAppear;
@property (nonatomic, assign) NSInteger columnNumber;
@property (nonatomic, strong) TZAlbumModel *model;
@end


@interface TZCollectionView : UICollectionView

@end
