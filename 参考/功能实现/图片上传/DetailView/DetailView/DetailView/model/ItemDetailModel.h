//
//  ItemDetailModel.h
//  DetailView
//
//  Created by hundred on 2017/3/15.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemDetailModel : NSObject

@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *detail;
@property(nonatomic,assign)BOOL isDiff;
@end
