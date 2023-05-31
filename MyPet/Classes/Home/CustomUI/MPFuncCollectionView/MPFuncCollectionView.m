//
//  MPFuncCollectionView.m
//  MyPet
//
//  Created by long on 2023/5/30.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "MPFuncCollectionView.h"

@interface MPFuncCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) CGSize iconSize;
@property (nonatomic, assign) BOOL hasMessage;

@end

@implementation MPFuncCollectionView

- (instancetype)initWithItemSize:(CGSize)itemSize IconSize:(CGSize)iconSize hasMessage:(BOOL)hasMessage {
    self = [super init];
    if (self){
        _itemSize = itemSize;
        _iconSize = iconSize;
        _hasMessage = hasMessage;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

@end
