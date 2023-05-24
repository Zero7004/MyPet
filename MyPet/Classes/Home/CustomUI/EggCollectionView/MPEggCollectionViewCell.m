//
//  MPEggCollectionViewCell.m
//  MyPet
//
//  Created by long on 2023/5/24.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "MPEggCollectionViewCell.h"

@interface MPEggCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *petImage;

@end

@implementation MPEggCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    [self.petImage setImage:[UIImage imageNamed:imageName]];
}

@end
