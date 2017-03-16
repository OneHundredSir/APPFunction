//
//  ViewController.m
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "ViewController.h"
#import "PictureViewController.h"
#import "ItemDetailView.h"
#import "HDetailView.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *arr = [@[] mutableCopy];
    [arr addObject:@{@"title":@"标题1",@"detail":@"阿萨德混的撒黄金卡圣诞节好看的撒很快就爱很简单卡萨丁数据库",@"isDiff":@0}];
    [arr addObject:@{@"title":@"标题2",@"detail":@"阿萨德混的撒黄金卡圣诞节好看的撒很快就爱很简单卡萨丁数据库",@"isDiff":@0}];
    [arr addObject:@{@"title":@"标题3",@"detail":@"阿萨德混的撒黄",@"isDiff":@1}];
    [arr addObject:@{@"title":@"标题4",@"detail":@"阿萨德混的撒黄金卡圣诞节好看的撒很快就爱很简单卡萨丁数据库",@"isDiff":@1}];
    [arr addObject:@{@"title":@"标题5",@"detail":@"阿萨德混的撒黄金卡圣诞节好看的撒很快就爱很dsfz简单卡萨丁数据库",@"isDiff":@1}];
    
    HDetailView *detailV = [[HDetailView alloc]initWithArray:arr];
    
    [self.view addSubview:detailV];
    [detailV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(8);
        make.right.equalTo(self.view).with.offset(-8);
        make.top.mas_equalTo(self.view.mas_top).with.offset(200);
    }];
#if 0
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = 40;
    CGRect rect = (CGRect){0,30,width,height};
//    ItemDetailView *detailV = [[ItemDetailView alloc]initWithFrame:rect];
    ItemDetailView *detailV = [[ItemDetailView alloc]initWithTitle:@"真的吗"
                                                         andDetail:@"不好爱上的大叔所大多所大撒多吧不好爱上的大叔所大多所大撒多吧不好爱上的大叔所大多所大撒多吧"];
    detailV.backgroundColor = [UIColor redColor];
    [self.view addSubview:detailV];
    [detailV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).with.offset(8);
        make.right.equalTo(self.view).with.offset(-8);
        make.top.mas_equalTo(self.view.mas_top).with.offset(200);
    }];
#endif
    
    UIButton *btn = [[UIButton alloc]init];
    [btn setTitle:@"跳转到照片" forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.and.height.mas_equalTo(40);
    }];
    
    
    
    
}

-(void)btnAction:(id)btnAction
{
    PictureViewController *vc = [PictureViewController new];
    [self presentViewController:vc animated:YES completion:nil];
}



@end
