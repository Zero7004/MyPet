//
//  MPMyPetViewController.m
//  MyPet
//
//  Created by long on 2023/5/24.
//  Copyright © 2023 王健龙. All rights reserved.
//

#import "MPMyPetViewController.h"
#import "CycleImageView.h"

@interface MPMyPetViewController ()

@property (nonatomic, strong) UIImageView *topBG;

@property (nonatomic, strong) UIView *bottomView;

@end

@implementation MPMyPetViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initView];
}

- (void)initView {
    self.view.backgroundColor = UIColor.whiteColor;
    
    self.topBG = ({
        UIImageView *topBG = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bgLV4"]];
        [self.view addSubview:topBG];
        [topBG mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self.view).offset(0);
            make.height.offset(390);
        }];

        topBG;
    });
    
    self.bottomView = ({
        UIView *bottomView = [UIView new];
        
        bottomView;
    });
}


@end
