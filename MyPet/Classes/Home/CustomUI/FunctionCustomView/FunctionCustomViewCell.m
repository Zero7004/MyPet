//
//  FunctionCustomViewCell.m
//  MyPet
//
//  Created by long on 2022/7/20.
//  Copyright © 2022 王健龙. All rights reserved.
//

#import "FunctionCustomViewCell.h"
#import "FunctionCustomDM.h"

@interface FunctionCustomViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconIMG;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation FunctionCustomViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(FunctionItmeDM *)model {
    _model = model;
    
    [self.iconIMG setImage:[UIImage imageNamed:model.iconName]];
    self.titleLabel.text = model.title;
}


@end
