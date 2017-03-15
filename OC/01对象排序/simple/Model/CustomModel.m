//
//  PersonLinkModel.m
//  TableViewDemo
//
//  Created by hundred on 2017/2/28.
//  Copyright © 2017年 hundred. All rights reserved.
//

#import "CustomModel.h"

@implementation CustomModel


-(NSString *)telNumber
{
    //这里做下电话号码处理
    
    return [self dealNumWithCode:_tel] ;
}


//弄一个正则做判断
-(NSString *)dealNumWithCode:(NSString *)mobile
{
    
    if (mobile.length < 11)
    {
        //@"手机号长度只能是11位"
        return @"**********";
    }else{
        /**
         * 移动号段正则表达式
         */
        NSString *CM_NUM = @"^((13[4-9])|(147)|(15[0-2,7-9])|(178)|(18[2-4,7-8]))\\d{8}|(1705)\\d{7}$";
        /**
         * 联通号段正则表达式
         */
        NSString *CU_NUM = @"^((13[0-2])|(145)|(15[5-6])|(176)|(18[5,6]))\\d{8}|(1709)\\d{7}$";
        /**
         * 电信号段正则表达式
         */
        NSString *CT_NUM = @"^((133)|(153)|(177)|(18[0,1,9]))\\d{8}$";
        NSPredicate *pred1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM_NUM];
        BOOL isMatch1 = [pred1 evaluateWithObject:mobile];
        NSPredicate *pred2 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU_NUM];
        BOOL isMatch2 = [pred2 evaluateWithObject:mobile];
        NSPredicate *pred3 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT_NUM];
        BOOL isMatch3 = [pred3 evaluateWithObject:mobile];
        
        if (isMatch1 || isMatch2 || isMatch3) {
//            NSLog(@"原来的电话%@",mobile);
            //这里是正常的号码
            mobile = [NSString stringWithFormat:@"%@****%@",
                      [mobile substringWithRange:(NSRange){0,3}],
                      [mobile substringWithRange:(NSRange){6,5}]];
//            NSLog(@"\n截取后的电话号码:%@",mobile);
            return mobile;
        }else{
//            return @"请输入正确的电话号码";
            return @"**********";
        }
    }
}


+(instancetype)oringinData
{
    CustomModel *model = [CustomModel new];
    model.title = @"李伯冰";
    model.tel = @"13535267171";
    model.address  = @"深圳市福田区福华路1018号中航中心21楼";
    model.isPerson = YES;
    return model;
}


-(NSString *)description
{
    return [NSString stringWithFormat:@"name:%@,\ntel:%@,\naddress:%@",_title,_tel,_address];
}

@end
