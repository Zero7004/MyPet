//
//  MPGetPetViewController.m
//  MyPet
//
//  Created by long on 2023/5/23.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "MPGetPetViewController.h"
#import "UIButton+LXMImagePosition.h"
#import "MPMyPetViewController.h"
#import "BaseTabBarController.h"

@interface MPGetPetViewController ()

@property (nonatomic, strong) UILabel *centerLabel;
@property (nonatomic, strong) UIButton *getEggBtn;

@end

@implementation MPGetPetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)initView {
    self.view.backgroundColor = UIColor.whiteColor;
    
    UIImageView *bgIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgColor"]];
    bgIMG.frame = SCREEN_RECT;
    [self.view addSubview:bgIMG];
    
    self.centerLabel = ({
        UILabel *label = [[UILabel alloc] init];
        label.text = @"You have received an egg!";
        label.numberOfLines = 0;
        label.textColor = [UIColor colorWithHexString:@"#003150"];
        label.font = [UIFont fontWithName:@"PingFangSC-Medium" size:18.0f];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(0);
            make.centerY.equalTo(self.view.mas_centerY).offset(0);
            make.left.equalTo(self.view.mas_left).offset(20);
            make.right.equalTo(self.view.mas_right).offset(-20);
        }];

        label;
    });
    
    UIImageView *eggIMG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"egg"]];
    [self.view addSubview:eggIMG];
    [eggIMG mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.centerLabel.mas_top).offset(-18);
        make.centerX.equalTo(self.view.mas_centerX).offset(0);
        make.width.height.offset(140);
    }];
    
    self.getEggBtn = ({
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:@"Hatch" forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"eggIcon"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#373737"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Medium" size:22.0f];
        btn.layer.cornerRadius = 25;
        btn.layer.shadowColor = [UIColor colorWithRed:9/255.0 green:30/255.0 blue:70/255.0 alpha:0.1400].CGColor;
        btn.layer.shadowOffset = CGSizeMake(0,5);
        btn.layer.shadowOpacity = 1;
        btn.layer.shadowRadius = 5;
        btn.backgroundColor = [UIColor colorWithHexString:@"#FFF87B" alpha:1.0];
        [btn setImagePosition:LXMImagePositionLeft spacing:6];
        [self.view addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view.mas_centerX).offset(0);
            make.top.equalTo(self.centerLabel.mas_bottom).offset(37);
            make.height.offset(50);
            make.width.offset(150);
        }];
        @weakify(self)
        [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self)
            [MPWindow setRootViewController:[[BaseTabBarController alloc] init]];
            [MPWindow makeKeyAndVisible];
        }];
        
        btn;
    });
    
}

@end
