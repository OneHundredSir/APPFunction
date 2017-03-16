//
//  ItemDetailView.m
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "ItemDetailView.h"


#define DITEMHIGHLIGHTCOLOR 0xA8855F
#define DITEMDEFAULTCOLOR 0x6d6968
#define DITEMDEFAULTFONSIZE         16          //字体大小

#define DITEMTOPMARGIN              10          //顶部
#define DITEMTITLELEFTMARGIN        80          //名称左边
#define DITEMDETAILLEFTMARGIN       10          //内容左边
#define DITEMDETAILRIGHTMARGIN      10          //内容边距
#define DITEMBOTTOMMARGIN           10          //底部边距
@interface ItemDetailView ()
@property(nonatomic,strong)UILabel *titleLB;
@property(nonatomic,strong)UILabel *detailLB;

//颜色部分
@property(nonatomic,strong)UIColor *titleColor;
@property(nonatomic,strong)UIColor *detailColor;


@end
@implementation ItemDetailView
{
    BOOL _didSetupConstraints; //进行一次自动化布局
}

#pragma mark - public
-(instancetype)initWithTitle:(NSString *)title andDetail:(NSString *)detail
{
    if (self = [super init]) {
        self.titleColor = UIColorFromHexValue(DITEMDEFAULTCOLOR);
        self.detailColor = UIColorFromHexValue(DITEMDEFAULTCOLOR);
        self.title = title;
        self.detail = detail;
        [self setupUI];
    }
    return self;
}

-(void)setIsDiff:(BOOL)isDiff
{
    _isDiff  = isDiff;
    if (isDiff) {
        _detailLB.textColor = UIColorFromHexValue(DITEMHIGHLIGHTCOLOR);
    }
    
    
}



#pragma mark - private

-(void)setupUI
{
    
    self.backgroundColor = [UIColor clearColor];
    //01.标题
    if (!_titleLB) {
        _titleLB = [[UILabel alloc] init];
        _titleLB.numberOfLines = 0;
        _titleLB.font = [UIFont systemFontOfSize:DITEMDEFAULTFONSIZE];
        _titleLB.textColor = self.titleColor;
        _titleLB.backgroundColor = [UIColor clearColor];
        _titleLB.text = self.title;
        [self addSubview:_titleLB];
    }
    
    //03.电话
    if (!_detailLB) {
        _detailLB = [[UILabel alloc] init];
        _detailLB.numberOfLines = 0;
        _detailLB.font = [UIFont systemFontOfSize:DITEMDEFAULTFONSIZE];
        _titleLB.backgroundColor = [UIColor clearColor];
        _detailLB.textColor = self.detailColor;
        _detailLB.text = self.detail;
        [self addSubview:_detailLB];
    }
    
    //这是使用页面
    [_titleLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mas_top).offset(DITEMTOPMARGIN);
        make.left.mas_equalTo(self.mas_left);
        
    }];
    
    [_detailLB mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLB.mas_top);
        make.left.equalTo(self).offset(DITEMTITLELEFTMARGIN);
        make.right.equalTo(self.mas_right).with.offset(-DITEMDETAILRIGHTMARGIN);
//        make.width.lessThanOrEqualTo(@300);
        make.bottom.equalTo(self).offset(-DITEMBOTTOMMARGIN);
    }];
    //根据自己实际情况添加垂直方向的优先级!
//    [_titleLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
//    [_detailLB setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
}


@end
