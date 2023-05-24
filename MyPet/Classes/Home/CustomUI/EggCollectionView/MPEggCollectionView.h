//
//  MPEggCollectionView.h
//  MyPet
//
//  Created by long on 2023/5/24.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MPEggCollectionViewDelegate <NSObject>

- (void)getCurrenSectionIndex:(NSInteger)index;

@end

@interface MPEggCollectionView : BaseView

@property (nonatomic, weak) id<MPEggCollectionViewDelegate> delegate;

@property (nonatomic, assign) NSInteger lastPage;

- (instancetype)initWithItemSize:(CGSize)itemSize;

- (void)clickLeft;
- (void)clickRight;

@end

NS_ASSUME_NONNULL_END
