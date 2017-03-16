//
//  PictureView.m
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "PictureView.h"
#import <ReactiveCocoa.h>
#define PHOTOWH 80
#define PHOTOMARGIN 10

@interface PictureView ()

@property(nonatomic,strong)NSMutableArray *picArr;

@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *cancelBtn;

@end

@implementation PictureView



#pragma mark - private
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupUI];
    }
    return self;
}
-(NSMutableArray *)picArr
{
    if (!_picArr) {
        _picArr = [@[] mutableCopy];
    }
    return _picArr;
}

-(void)setupUI
{
    //添加按钮
    [self setupButtons];
    
}

-(void)setupButtons
{
//    添加按钮
    UIButton *addbtn = [[UIButton alloc]init];
    addbtn.backgroundColor = [UIColor blueColor];
    [addbtn setTitle:@"添加" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addbtn.tag = 1;
    [[addbtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        UIButton *btn = [UIButton new];
        [self.picArr addObject:btn];
        [self addSubview:btn];
        NSLog(@"点击了添加按钮");
        
    }];
    [self addSubview:addbtn];
    _addBtn = addbtn;
    
    //删除按钮
    UIButton *cancelBtn = [[UIButton alloc]init];
    cancelBtn.backgroundColor = [UIColor grayColor];
    [cancelBtn setTitle:@"删除" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    cancelBtn.tag = 1;
    [[cancelBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        if (self.picArr.count>0) {
            UIButton *btn = [self.picArr lastObject];
            //删除最后的object从subviews
//            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)]
            //最后删除数组的最后一个
            [self.picArr removeLastObject];
        }
        NSLog(@"点击了删除按钮");
    }];
    [self addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
    
    
    
}




#pragma mark - 添加控件方法
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat magin = PHOTOMARGIN;
    CGFloat lastBtnMaxX = 0 ;
    //进行btn的排序
    long count = self.picArr.count;
    CGFloat btnW = PHOTOWH;
    CGFloat btnH = btnW;
//    int maxColumns = 3; // 一行最多显示4张图片
//    CGFloat margin = (self.frame.size.width - maxColumns * btnW) / (maxColumns + 1);
    CGFloat btnY = (self.contentSize.height-btnW)/2.0;
    CGFloat margin = PHOTOMARGIN;
    for (int i = 0; i<count; i++) {
        UIButton *btn = self.picArr[i];
        CGFloat btnX = magin + (magin+btnW)*i;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        if (i==count-1) {
            lastBtnMaxX = CGRectGetMaxX(btn.frame);
        }
//        CGFloat btnX = margin + (i % maxColumns) * (btnW + margin);
//        CGFloat btnY = (i / maxColumns) * (btnH + margin);
    }
    
    //放置添加按钮
    _addBtn.frame = (CGRect){lastBtnMaxX+PHOTOMARGIN,(self.contentSize.height-PHOTOWH)/2.0,PHOTOWH,PHOTOWH};
    //放置减少按钮
    _cancelBtn.frame = (CGRect){lastBtnMaxX+PHOTOWH+PHOTOMARGIN*2,btnY,PHOTOWH,PHOTOWH};
    //这里编辑添加后的的尺寸
    self.contentSize= (CGSize){CGRectGetMaxX( _cancelBtn.frame)+magin,self.frame.size.height};
}


@end
