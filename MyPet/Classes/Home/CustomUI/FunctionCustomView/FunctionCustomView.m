//
//  FunctionCustomView.m
//  MyPet
//
//  Created by long on 2022/7/20.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "FunctionCustomView.h"
#import "FunctionCustomViewCell.h"

@interface FunctionCustomView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) CGSize itemSize;

@end

@implementation FunctionCustomView

- (instancetype)initWithItemSize:(CGSize)itemSize
                           title:(NSString *)title {
    self = [super init];
    if (self) {
        _title = title;
        _itemSize = itemSize;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 6;
    self.layer.masksToBounds = YES;
    
    if (self.title.length > 0) {
        self.titleLabel = ({
            UILabel *label = [[UILabel alloc] init];
            label.text = self.title;
            label.numberOfLines = 0;
            label.textColor = [UIColor colorWithHexString:@"#3D4E66"];
            label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:15.0f];
            [self addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self).offset(18);
                make.right.equalTo(self).offset(-18);
            }];

            label;
        });
    }
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.title.length > 0) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        } else {
            make.top.equalTo(self).offset(0);
        }
        make.left.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-18);
        make.bottom.equalTo(self).offset(0);
        make.height.offset(70);
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
        [_collectionView registerNib:[UINib nibWithNibName:@"FunctionCustomViewCell" bundle:nil] forCellWithReuseIdentifier:@"FunctionCustomViewCell"];
    }
    return _collectionView;
}


// MARK: - function
- (void)setDataArray:(NSArray *)dataArray
           itemCount:(NSInteger)itemCount {
    _dataArray = dataArray;
    
    CGFloat collectionViewH = 107;
    if (dataArray.count % itemCount == 0) {
        collectionViewH = (dataArray.count / itemCount) * 107;
    } else {
        collectionViewH = (dataArray.count / itemCount) * 107 + collectionViewH;
    }
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(collectionViewH);
    }];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionView delegate
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FunctionCustomViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FunctionCustomViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.SelectBlock) {
        self.SelectBlock(self.dataArray[indexPath.row]);
    }
}

@end
