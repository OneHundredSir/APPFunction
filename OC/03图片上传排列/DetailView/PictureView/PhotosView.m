//
//  PictureView.m
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "PhotosView.h"
#import <ReactiveCocoa.h>
#import <Masonry.h>

#define PHOTOWH 80
#define PHOTOMARGIN 10

@interface PhotosView ()

@property(nonatomic,strong)NSMutableArray *picArr;

@property(nonatomic,strong)UIButton *addBtn;
@property(nonatomic,strong)UIButton *cancelBtn;

@end

@implementation PhotosView

@synthesize picArr = _picArr;



#pragma mark - setter / getter


-(void)setPicArr:(NSMutableArray *)picArr
{
    _picArr = picArr;
    NSLog(@"输入的图片");
}

-(NSMutableArray *)picArr
{
    if (!_picArr) {
        _picArr = [@[] mutableCopy];
    }
//    if (![_picArr containsObject:_addBtn]) {
//        //进行btn的排序
//        [_picArr addObject:_addBtn];
//        [_picArr addObject:_cancelBtn];
//    }
    return _picArr;
}


#pragma mark - private
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupUI];
    }
    return self;
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
        btn.backgroundColor = H_UI_RandomColor;
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
    
    CGRect frameRect = self.frame;
    CGFloat lastBtnMaxX = 0 ;

    //复制多一个临时的数组主要为了添加/删除按钮
    NSMutableArray *tmpArr = [self.picArr mutableCopy];
    [tmpArr addObject:_addBtn];
    [tmpArr addObject:_cancelBtn];
    
    //获取添加的数组数目
    long count = tmpArr.count;
    int maxColumns = 4; // 一行最多显示4张图片
    CGFloat btnW = PHOTOWH;
    CGFloat btnH = btnW;

    CGFloat magin = (CGRectGetWidth(self.frame)-maxColumns*btnW)/(maxColumns+1);

#if 0
    for (int i = 0; i<count; i++) {
        NSInteger row = i / maxColumns;
        NSInteger column = i %maxColumns;
        NSLog(@"打印的行%d和列%d,还有总数%d",row,column,count);
        UIButton *btn = self.picArr[i];
        CGFloat btnX = magin + (magin+btnW)*column;
        CGFloat btnY = magin + (magin+btnW)*row;
        

        if (i == count-1) {
            [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(btnY);
                make.left.equalTo(self).offset(btnX);
                make.width.and.height.mas_equalTo(btnW);
                make.bottom.equalTo(self).offset(magin);
            }];
            return;
        }
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(btnY);
            make.left.equalTo(self).offset(btnX);
            make.width.and.height.mas_equalTo(btnW);
        }];
        lastBtn = btn;
        /*
         CGFloat btnX = magin + (magin+btnW)*column;
         CGFloat btnY = magin + (magin+btnW)*row;
         btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
         if (i==count-1) {
         lastBtnMaxX = CGRectGetMaxX(btn.frame);
         }
         */
    }
#else
    
    
    for (int i = 0; i<count; i++) {
        NSInteger row = i / maxColumns;
        NSInteger column = i %maxColumns;
        NSLog(@"打印的行%d和列%d,还有总数%d",row,column,count);
        UIButton *btn = tmpArr[i];
        CGFloat btnX = magin + (magin+btnW)*column;
        CGFloat btnY = magin + (magin+btnW)*row;
        btn.frame = (CGRect){btnX,btnY,PHOTOWH,PHOTOWH};
        lastBtnMaxX = CGRectGetMaxX(btn.frame);
    }
//    //放置添加按钮
//    _addBtn.frame = (CGRect){lastBtnMaxX+PHOTOMARGIN,PHOTOMARGIN,PHOTOWH,PHOTOWH};
//    //放置减少按钮
//    _cancelBtn.frame = (CGRect){lastBtnMaxX+PHOTOWH+PHOTOMARGIN*2,PHOTOMARGIN,PHOTOWH,PHOTOWH};
    //这里编辑添加后的的尺寸
//    self.contentSize= (CGSize){CGRectGetMaxX( _cancelBtn.frame)+magin,self.frame.size.height};
    frameRect.size.height = CGRectGetMaxY(_cancelBtn.frame)+magin;
    self.frame = frameRect;
#endif
        
        
}


@end
