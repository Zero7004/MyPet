//
//  SelectLabelCollectionViewCell.m
//  MyPet
//
//  Created by long on 2022/7/21.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "SelectLabelCollectionViewCell.h"
#import "SelectLabelDM.h"

@interface SelectLabelCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleL;
@property (weak, nonatomic) IBOutlet UIImageView *selectIcon;


@end

@implementation SelectLabelCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.contentView.layer.cornerRadius = 5;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderWidth = 1;
}

- (void)setModel:(SelectLabelItmeDM *)model {
    _model = model;
    
    self.titleL.text = model.title;
    self.selectIcon.hidden = !model.isSelect;
    if (model.isSelect) {
        self.titleL.textColor = [UIColor colorWithHexString:@"#006AFF"];
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#006AFF"].CGColor;
    } else {
        self.titleL.textColor = [UIColor colorWithHexString:@"#A1A8B3"];
        self.contentView.layer.borderColor = [UIColor colorWithHexString:@"#A1A8B3" alpha:0.2].CGColor;
    }
}

@end
