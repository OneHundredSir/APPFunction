//
//  PictureView.m
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "PhotosView.h"
#import "AppDelegate.h"
#import <ReactiveCocoa.h>
#import <Masonry.h>

#import "ZZPhotoKit.h"

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


#pragma mark 初始化按钮
-(void)setupButtons
{
    //    添加按钮
    UIButton *addbtn = [[UIButton alloc]init];
    addbtn.backgroundColor = [UIColor blueColor];
    [addbtn setTitle:@"添加" forState:UIControlStateNormal];
    [addbtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    addbtn.tag = 1;
    [[addbtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        [self alertAction];
        
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
            [btn removeFromSuperview];
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


-(void)alertAction
{
    //获取当前的view
    UIViewController *viewController = ((AppDelegate *)[UIApplication sharedApplication].delegate).window.rootViewController;
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相片选择方式" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZZCameraController *cameraController = [[ZZCameraController alloc]init];
        cameraController.takePhotoOfMax = 8;
        
        cameraController.isSaveLocal = NO;
        [cameraController showIn:viewController result:^(id responseObject){
            
            for ( ZZCamera *photo in (NSArray *)responseObject) {
                
                NSLog(@"相机的对象%@",photo.image);
                
                UIButton *btn = [UIButton new];
                [btn setImage:photo.image forState:UIControlStateNormal];
                [self.picArr addObject:btn];
                [self addSubview:btn];
                 
            }
            //            NSLog(@"重载");
//            [_collectionView reloadData];
            
        }];
//        UIButton *btn = [UIButton new];
//        [self.picArr addObject:btn];
//        btn.backgroundColor = H_UI_RandomColor;
//        [self addSubview:btn];
        NSLog(@"点击了相机按钮");
    }];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ZZPhotoController *photoController = [[ZZPhotoController alloc]init];
        photoController.selectPhotoOfMax = 8;
        //设置相册中完成按钮旁边小圆点颜色。
        //        photoController.roundColor = [UIColor greenColor];
        
        [photoController showIn:viewController result:^(id responseObject){
            
            
            for (ZZPhoto *photo in (NSArray *)responseObject) {
                UIButton *btn = [UIButton new];
                [btn setImage:photo.originImage forState:UIControlStateNormal];
                [self.picArr addObject:btn];
                [self addSubview:btn];
            }
            
        }];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:photoAction];
    [alertController addAction:cameraAction];
    [alertController addAction:cancelAction];
    
    [viewController presentViewController:alertController animated:YES completion:nil];
    
    
}


#pragma mark - 添加控件动态布局的方法
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIButton *lastBtn;
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

#if 1
    //方法一: 使用layout 布局
    for (int i = 0; i<count; i++) {
        NSInteger row = i / maxColumns;
        NSInteger column = i %maxColumns;
        UIButton *btn = tmpArr[i];
        CGFloat btnX = magin + (magin+btnW)*column;
        CGFloat btnY = magin + (magin+btnW)*row;
        if (i == count-1) {
            [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(btnY);
                make.left.equalTo(self).offset(btnX);
                make.width.and.height.mas_equalTo(btnW);
                make.bottom.equalTo(self).offset(-magin);
            }];
            return;
        }
        [btn mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(btnY);
            make.left.equalTo(self).offset(btnX);
            make.width.and.height.mas_equalTo(btnW);
        }];
        lastBtn = btn;

    }
#else
    CGRect frameRect = self.frame;
    CGFloat lastBtnMaxX = 0 ;
    //方法二: 使用frame 布局,坏处就是外部不能使用layout布局
    for (int i = 0; i<count; i++) {
        NSInteger row = i / maxColumns;
        NSInteger column = i %maxColumns;
        UIButton *btn = tmpArr[i];
        CGFloat btnX = magin + (magin+btnW)*column;
        CGFloat btnY = magin + (magin+btnW)*row;
        btn.frame = (CGRect){btnX,btnY,PHOTOWH,PHOTOWH};
        lastBtnMaxX = CGRectGetMaxX(btn.frame);
    }

    frameRect.size.height = CGRectGetMaxY(_cancelBtn.frame)+magin;
    self.frame = frameRect;
#endif
        
        
}


@end
