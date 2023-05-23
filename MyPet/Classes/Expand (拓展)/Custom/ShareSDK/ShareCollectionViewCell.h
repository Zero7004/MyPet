//
//  ShareCollectionViewCell.h
//  MyPet
//
//  Created by 王健龙 on 2020/4/22.
//  Copyright © 2020 王健龙. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ShareCollectionViewCell : UICollectionViewCell
/// logo
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/// 名称
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

NS_ASSUME_NONNULL_END
