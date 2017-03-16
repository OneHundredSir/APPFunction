//
//  TableViewCell.h
//  Cell-Masonry
//
//  Created by 贾则栋 on 16/3/25.
//  Copyright © 2016年 贾则栋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

#define WS(weakSelf) __weak typeof(self)weakSelf = self

@interface TableViewCell : UITableViewCell

@property (nonatomic, assign) BOOL isExpanded;
@property (nonatomic, strong) NSIndexPath *beforeIndexPath;

@property (nonatomic, strong) UIView *mainView;
@property (nonatomic, strong) UIView *appendView;

- (void)configHeight;

- (void)refreshHeight;

@end


@interface Model : NSObject

@property (nonatomic, assign) BOOL isExpanded;

@end