//
//  SelectLabelCollectionViewCellFlowLayout.m
//  MyPet
//
//  Created by long on 2022/7/21.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "SelectLabelCollectionViewCellFlowLayout.h"

@implementation SelectLabelCollectionViewCellFlowLayout

- (CGSize)collectionViewContentSize {
    CGSize size = CGSizeZero;
    NSInteger itemCount = 0;
    //获取collectionView的item个数，为0的话返回CGSizeZero
    if ([self.collectionView.dataSource respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
        itemCount = [self.collectionView.dataSource collectionView:self.collectionView numberOfItemsInSection:0];
    }
    if (CGSizeEqualToSize(size, CGSizeZero) && itemCount == 0) {
        return CGSizeZero;
    }
    //内容宽度
    NSInteger lineWidth = 0;
    //展示行数
    NSUInteger rowCount = 1;
    for (int i = 0; i < itemCount; ++i) {
        //self.dataArry为内容数组
        //根据传入的字体大小self.textFont计算item宽度
        //然后与传入的collectionView的宽度self.contentWidth做计算
        NSDictionary *attribute = @{NSFontAttributeName: self.textFont};
        CGSize currentLabelSize = [self.dataArry[i] sizeWithAttributes:attribute];
        //self.itemWidthSpacing为展示预留的宽度，根据需求设置
        CGFloat cellWidth = currentLabelSize.width + self.itemWidthSpacing*2;
        if (i == (itemCount - 1)) {
            lineWidth = lineWidth + cellWidth;
        } else {
            lineWidth = lineWidth + self.minimumInteritemSpacing + cellWidth;
        }
        //计算一行的item展示数量
        if (lineWidth > (NSInteger)self.contentWidth) {
            rowCount++;
            lineWidth = 0;
        }
    }
    //最终计算出collectionView内容展示所需的高度
    size.width = self.contentWidth;
    size.height = rowCount * self.itemHeight + (rowCount - 1) * self.minimumLineSpacing;
    
    return size;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray* attributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];
    //将第一个item固定在左上，防止一行只展示一个item时位置错乱
    if (attributes.count > 0) {
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[0];
        CGRect frame = currentLayoutAttributes.frame;
        frame.origin.x = 0;
        currentLayoutAttributes.frame = frame;
    }
    
    CGFloat originY = 0;
    for(int i = 1; i < [attributes count]; ++i) {
        NSDictionary *attribute = @{NSFontAttributeName: self.textFont};
        CGSize labelSize = [self.dataArry[i] sizeWithAttributes:attribute];
        UICollectionViewLayoutAttributes *currentLayoutAttributes = attributes[i];
        UICollectionViewLayoutAttributes *prevLayoutAttributes = attributes[i - 1];
        CGFloat cellWidth = ceil(labelSize.width) + self.itemWidthSpacing*2;
        currentLayoutAttributes.size = CGSizeMake(cellWidth, self.itemHeight);
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        //如果当前item的宽度+前一个item的最大宽度+item间距<=collectionView的宽度，则一行可以容纳下，修改当前item的x轴位置，否则居左显示
        if (origin + self.minimumInteritemSpacing + currentLayoutAttributes.frame.size.width < self.contentWidth) {
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = origin + self.minimumInteritemSpacing;
            frame.origin.y = originY;
            currentLayoutAttributes.frame = frame;
        } else {
            originY = originY + self.minimumLineSpacing + self.itemHeight;
            CGRect frame = currentLayoutAttributes.frame;
            frame.origin.x = 0;
            frame.origin.y = originY;
            currentLayoutAttributes.frame = frame;
        }
    }
    
    return attributes;
}

@end
