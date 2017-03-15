//
//  PersonLinkModel.h
//  TableViewDemo
//
//  Created by hundred on 2017/2/28.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomModel : NSObject

@property(nonatomic,strong)NSString *title;      //名称
@property(nonatomic,strong)NSString *tel; //电话号码
@property(nonatomic,strong)NSString *address;   //地址
@property(nonatomic,assign)BOOL isPerson;       //是否显示个人


+(instancetype)oringinData;
@end
