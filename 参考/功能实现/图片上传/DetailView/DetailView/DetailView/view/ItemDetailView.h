//
//  ItemDetailView.h
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry.h>

//255以内的随机数
#define crm_random255 arc4random_uniform(255)/255.0

//色调部分
#define H_UI_RandomColor [UIColor colorWithRed:crm_random255 green:crm_random255 blue:crm_random255 alpha:1]

#define UIColorFromHexValue(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ItemDetailView : UIView

//内容部分
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;

//颜色部分判断
@property(nonatomic,assign)BOOL isDiff;

-(instancetype)initWithTitle:(NSString *)title andDetail:(NSString *)detail;


@end

/*
使用方法:
 通过init方法设置,并且采用masonry布局


*/
