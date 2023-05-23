//
//  SelectLabelCollectionViewCellFlowLayout.h
//  MyPet
//
//  Created by long on 2022/7/21.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SelectLabelCollectionViewCellFlowLayout : UICollectionViewFlowLayout

///数组内容
@property (nonatomic, strong) NSArray *dataArry;
///item高度
@property (nonatomic, assign) CGFloat itemHeight;
///item左右偏移
@property (nonatomic, assign) CGFloat itemWidthSpacing;
///展示字体
@property (nonatomic, strong) UIFont *textFont;
///UICollectionView宽度
@property (nonatomic, assign) CGFloat contentWidth;


@end

NS_ASSUME_NONNULL_END
