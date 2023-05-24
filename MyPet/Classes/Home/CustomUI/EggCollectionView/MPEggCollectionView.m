//
//  MPEggCollectionView.m
//  MyPet
//
//  Created by long on 2023/5/24.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "MPEggCollectionView.h"
#import "MPEggCollectionViewCell.h"

@interface MPEggCollectionView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, assign) CGSize itemSize;

@end

@implementation MPEggCollectionView

- (instancetype)initWithItemSize:(CGSize)itemSize {
    self = [super init];
    if (self){
        _itemSize = itemSize;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];

    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
        make.left.equalTo(self).offset(0);
        make.right.equalTo(self).offset(0);
        make.bottom.equalTo(self).offset(0);
        make.height.offset(self.itemSize.height);
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = self.itemSize;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"MPEggCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MPEggCollectionViewCell"];
    }
    return _collectionView;
}

// MARK: - function




@end
