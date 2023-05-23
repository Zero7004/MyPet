//
//  SelectLabelItemView.m
//  MyPet
//
//  Created by long on 2022/7/21.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "SelectLabelItemView.h"
#import "SelectLabelCollectionViewCell.h"
#import "SelectLabelCollectionViewCellFlowLayout.h"


@interface SelectLabelItemView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) SelectLabelCollectionViewCellFlowLayout *flowLayout;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) CGFloat viewWidth;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation SelectLabelItemView

- (instancetype)initWithTitle:(NSString *)title Width:(CGFloat)width dataArray:(NSArray *)dataArray {
    self = [super init];
    if (self) {
        self.title = title;
        self.viewWidth = width;
        [self.dataArray addObjectsFromArray:dataArray];
        [self setupUI];
        [self updateUI];
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
                make.top.left.equalTo(self).offset(16);
                make.right.equalTo(self).offset(-16);
            }];

            label;
        });
        
        UIView *topLine = [UIView new];
        topLine.backgroundColor = [UIColor colorWithHexString:@"#000000" alpha:0.05];
        [self addSubview:topLine];
        [topLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(16);
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
            make.height.offset(0.5);
        }];
    }

    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (self.title.length > 0) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(16 + 16);
        } else {
            make.top.equalTo(self).offset(16);
        }
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.bottom.equalTo(self).offset(-18);
        make.height.offset(32);
    }];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        SelectLabelCollectionViewCellFlowLayout *layout = [[SelectLabelCollectionViewCellFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(70, 32);
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        
        layout.dataArry = [self getAllTitle];
        layout.itemHeight = 32;
        layout.itemWidthSpacing = 10;
        layout.textFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14.0f];
        layout.contentWidth = self.viewWidth - 32;

        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.flowLayout = layout;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerNib:[UINib nibWithNibName:@"SelectLabelCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"SelectLabelCollectionViewCell"];
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = NSMutableArray.new;
    }
    return _dataArray;
}

// MARK: - function
- (void)updateUI {
    CGFloat height = self.flowLayout.collectionViewContentSize.height;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.offset(height);
    }];
}

- (NSArray *)getAllTitle {
    if (self.dataArray.count == 0) {
        return NSArray.new;
    }
    NSMutableArray *titles = NSMutableArray.new;
    for (SelectLabelItmeDM *model in self.dataArray) {
        [titles addObject:model.title];
    }
    return [titles copy];
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
    SelectLabelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SelectLabelCollectionViewCell" forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.dataArray enumerateObjectsUsingBlock:^(SelectLabelItmeDM *model, NSUInteger idx, BOOL * _Nonnull stop) {
        if (self.selectType == SelectLabelType_multiple) {
            //多选
            if (idx == indexPath.row) {
                model.isSelect = !model.isSelect;
            }
        } else {
            //单选
            if (idx == indexPath.row) {
                model.isSelect = YES;
            } else {
                model.isSelect = NO;
            }
        }
    }];

    [self.collectionView reloadData];
}

@end
