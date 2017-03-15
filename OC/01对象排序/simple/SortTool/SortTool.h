//
//  SortTool.h
//  simple
//
//  Created by hundred on 2017/3/14.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import <Foundation/Foundation.h>
//必须导入这个库才可以使用对应的排序!
#import <UIKit/UIKit.h>

#define kToolsIndexAryKey @"LCIndexAryKey"     //索引
#define kToolsGroupAryKey @"LCGroupAryKey"  //排序后的分组

@interface SortTool : NSObject

/**
 对数组排序
 
 @param mArray      需要排序的数组
 @param proretyName 数组中对象需要排序的属性
 
 @return 排序后的索引及gourpAry 字典形式 kToolsIndexAryKey kToolsGroupAryKey
 */
+ (NSDictionary *)sortedArrayWithChineseObject:(NSMutableArray *)mArray  withPropertyNameSEL:(SEL)nameSEL ;


@end
