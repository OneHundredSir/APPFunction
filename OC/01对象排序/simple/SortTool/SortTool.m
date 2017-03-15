//
//  SortTool.m
//  simple
//
//  Created by hundred on 2017/3/14.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "SortTool.h"

@implementation SortTool

//数组进行本地化排序!
+ (NSDictionary *)sortedArrayWithChineseObject:(NSMutableArray *)mArray  withPropertyNameSEL:(SEL)nameSEL {
    
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    NSInteger index, sectionTitlesCount = [[indexCollation sectionTitles] count];
    NSMutableArray *suoYinArr = [[NSMutableArray alloc] initWithArray:[indexCollation sectionTitles]];
    
    //临时数据，存放section对应的userObjs数组数据
    NSMutableArray *newSectionsArray = [[NSMutableArray alloc] initWithCapacity:sectionTitlesCount];
    
    //设置sections数组初始化：元素包含userObjs数据的空数据
    for (index = 0; index < sectionTitlesCount; index++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [newSectionsArray addObject:array];
    }
    
    //分组
    for (id object in mArray) {
        //根据timezone的localename，获得对应的的section number
        NSInteger sectionNumber = [indexCollation sectionForObject:object collationStringSelector:nameSEL];
        //根据sectionNumber获取数组
        NSMutableArray *sectionUserObjs = [newSectionsArray objectAtIndex:sectionNumber];
        //添加对象到对应的数组中
        [sectionUserObjs addObject:object];
    }
    
    //获取空的数组的index
    NSMutableArray *willDeleteAry = [NSMutableArray new];
    for (int i = 0; i < newSectionsArray.count; i ++) {
        NSArray *tempAry = newSectionsArray[i];
        if (tempAry.count == 0) {
            [willDeleteAry addObject:[NSString stringWithFormat:@"%d",i]];
        }
    }
    //删除空的数组
    for (NSInteger i = willDeleteAry.count; i > 0; i -- ) {
        NSInteger index = [willDeleteAry[i - 1] integerValue];
        [newSectionsArray removeObjectAtIndex:index];
        [suoYinArr removeObjectAtIndex:index];
    }
    
    //该字典中存放分组排序呢后的索引及数据
    NSDictionary *dict = @{kToolsGroupAryKey:newSectionsArray,kToolsIndexAryKey:suoYinArr};
    
    
    return dict;
    
}


@end
