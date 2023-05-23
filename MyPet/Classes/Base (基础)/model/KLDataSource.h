//
//  KLDataSource.h
//  MyPet
//
//  Created by lzf on 2020/9/12.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^cellConfigureBefore)(id cell, id model, NSIndexPath *indexPath);
typedef void(^selectCell)(NSIndexPath *indexPath);

@interface KLDataSource : NSObject <UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate,UICollectionViewDataSource>
/// 数据
@property (nonatomic, strong) NSMutableArray *dataArray;


- (id)initWithIdentifier:(NSString *)identifier configureBlock:(cellConfigureBefore)before selectBlcok:(selectCell)selectBlock;

- (id)modelsAtIndexPath:(NSIndexPath *)indexPath;

- (void)addDataAtArray:(NSArray *)array;
@end

NS_ASSUME_NONNULL_END
