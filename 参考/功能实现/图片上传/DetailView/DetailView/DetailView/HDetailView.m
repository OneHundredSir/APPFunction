//
//  HDetailViewItem.m
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "HDetailView.h"
#import "ItemDetailView.h"
#import "ItemDetailModel.h"
#import <MJExtension.h>



#define DEFAULTMARGIN 5
@interface HDetailView ()

@property(nonatomic,strong)NSArray *modelArr;


@end

@implementation HDetailView
{
    ItemDetailView *lastView;
}

-(instancetype)initWithArray:(NSArray *)dicArr
{
    if (self = [super init])
    {
        self.modelArr = dicArr;
        [self setupItems];
    }
    return self;
}


#pragma mark - private

//数据转模型
-(void)setModelArr:(NSArray *)modelArr
{
    NSMutableArray *tmpArr = [@[] mutableCopy];
    for (NSDictionary *dic in modelArr) {
        ItemDetailModel *model = [ItemDetailModel mj_objectWithKeyValues:dic];
        [tmpArr addObject:model];
    }
    _modelArr = tmpArr;
    
}


-(void)setupItems
{
    NSInteger index = 1;
    for (ItemDetailModel *model in self.modelArr)
    {
        ItemDetailView *item = [[ItemDetailView alloc]initWithTitle:model.title
                                                          andDetail:model.detail];
        item.isDiff = model.isDiff;
        [self addSubview:item];
        
        if (index == self.modelArr.count) {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_bottom).offset(DEFAULTMARGIN);
                make.left.equalTo(lastView);
                make.right.equalTo(lastView);
                make.bottom.equalTo(self).offset(DEFAULTMARGIN);
            }];
            return;
        }
        //设置对应的约束
        if (lastView)
        {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(lastView.mas_bottom).offset(DEFAULTMARGIN);
                make.left.equalTo(lastView);
                make.right.equalTo(lastView);
            }];
        }else //第一次设置的时候
        {
            [item mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(DEFAULTMARGIN);
                make.left.equalTo(self).offset(DEFAULTMARGIN);
                make.right.equalTo(self).offset(-DEFAULTMARGIN);
            }];
        }
        lastView = item;
        index++;
    }
}


@end
