//
//  ViewController.m
//  simple
//
//  Created by hundred on 2017/3/14.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "ViewController.h"

#import "SortTool.h"

#import "CustomModel.h"
#import <MJExtension.h>
@interface ViewController ()

@property(nonatomic,strong)NSMutableArray *data;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self show];
    
}

-(NSMutableArray *)data
{
    if (!_data) {
        NSMutableArray *data = [@[] mutableCopy];
        [data addObject:@{@"title":@"李伯冰",@"tel":@"13535267171",@"address":@"深圳市福田区福华路view",@"isPerson":@1}];
        [data addObject:@{@"title":@"王月华",@"tel":@"13535267171",@"address":@"深圳市福田区福华路view",@"isPerson":@1}];
        [data addObject:@{@"title":@"完月辉",@"tel":@"13535267171",@"address":@"深圳市福田区福华路view",@"isPerson":@1}];
        [data addObject:@{@"title":@"陈月辉",@"tel":@"13535267171",@"address":@"深圳市福田区福华路view",@"isPerson":@1}];
        [data addObject:@{@"title":@"深圳市",@"tel":@"13535267171",@"address":@"深圳市福田区福华路view",@"isPerson":@1}];
        [data addObject:@{@"title":@"谷圳市",@"tel":@"13535267171",@"address":@"深圳市福田区福华路view",@"isPerson":@1}];
        _data = data;
    }
    return _data;
}

-(void)show
{
    
//    NSLog(@"%@",self.data);
    
    
    NSMutableArray *modelArr = [@[] mutableCopy];
    for (NSDictionary *dic in self.data) {
        CustomModel *model = [CustomModel mj_objectWithKeyValues:dic];
//        NSLog(@"设置model:%@\n=====\n",model);
        [modelArr addObject:model];
    }
//    NSLog(@"输出model的数组:%@\n",modelArr);
    
    
    
    NSDictionary *dic = [SortTool sortedArrayWithChineseObject:modelArr withPropertyNameSEL:@selector(title)];
    
    
    NSLog(@"%@",dic);
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
