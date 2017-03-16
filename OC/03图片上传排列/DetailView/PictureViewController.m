//
//  PictureViewController.m
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "PictureViewController.h"
#import "PictureView.h"
#import "PhotosView.h"
@interface PictureViewController ()

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
    
    PhotosView *pic = [PhotosView new];
    pic.backgroundColor = [UIColor redColor];
    [self.view addSubview:pic];
    [pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.centerX.equalTo(self.view);
        make.width.equalTo(self.view);
//        make.height.greaterThanOrEqualTo(@100);
    }];
    
    UIView *showXV = [UIView new];
    [self.view addSubview:showXV];
    showXV.backgroundColor = H_UI_RandomColor;
    [showXV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(pic.mas_bottom).offset(10);
        make.width.and.centerX.equalTo(pic);
        make.height.greaterThanOrEqualTo(@60);
    }];
    
    
    
    
    
    
}




@end
