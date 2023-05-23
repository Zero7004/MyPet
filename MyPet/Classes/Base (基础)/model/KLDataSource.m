//
//  KLDataSource.m
//  MyPet
//
//  Created by lzf on 2020/9/12.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import "KLDataSource.h"

@interface KLDataSource ()
/// <#name#>
@property (nonatomic, strong) IBInspectable NSString *cellIdentifier;
/// <#name#>
@property (nonatomic, copy) cellConfigureBefore cellConfigureBefore;
/// <#name#>
@property (nonatomic, copy) selectCell selectBlock;
@end

@implementation KLDataSource

- (id)initWithIdentifier:(NSString *)identifier configureBlock:(cellConfigureBefore)before selectBlcok:(selectCell)selectBlock {
    if (self = [super init]) {
        _cellIdentifier = identifier;
        _cellConfigureBefore = [before copy];
        _selectBlock = [selectBlock copy];
    }
    return self;
}

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath {
    // 当数据大于行数，防止未发送消息到变量
    return self.dataArray.count > indexPath.row ? self.dataArray[indexPath.row] : nil;
}

- (void)addDataAtArray:(NSArray *)array {
    if (!array) {
        return;
    }
    // 如果里面有值，移除重新添加
    if (self.dataArray.count > 0) {
        [self.dataArray removeAllObjects];
    }
    [self.dataArray addObjectsFromArray:array];
}


#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:self.cellIdentifier];
    }
    
    id model = [self modelsAtIndexPath:indexPath];
    if (self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model, indexPath);
    }
    
    return cell;
}

#pragma mark - UITableViewDataDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    self.selectBlock(indexPath);
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    id model = [self modelsAtIndexPath:indexPath];
    if (self.cellConfigureBefore) {
        self.cellConfigureBefore(cell, model, indexPath);
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    self.selectBlock(indexPath);
}


#pragma mark - 懒加载
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
@end

