//
//  TableViewCell.m
//  Cell-Masonry
//
//  Created by 贾则栋 on 16/3/25.
//  Copyright © 2016年 贾则栋. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    NSLog(@"%s", __func__);
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.mainView = [[UIView alloc] init];
        self.mainView.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:self.mainView];
        
        WS(ws);
        [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(ws.contentView.mas_top);
            make.left.equalTo(ws.contentView.mas_left);
            make.right.equalTo(ws.contentView.mas_right);
            make.height.mas_equalTo(@40);
        }];
        
        self.appendView = [[UIView alloc] init];
        self.appendView.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.appendView];
    }
    return self;
}

- (void)configHeight
{
    NSLog(@"%@----%s", self.isExpanded?@"yes":@"no", __func__);
    
    WS(ws);
    [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView.mas_top);
        make.left.equalTo(ws.contentView.mas_left);
        make.right.equalTo(ws.contentView.mas_right);
        if (self.isExpanded) {
            make.height.mas_equalTo(@60);
        }
        else {
            make.height.mas_equalTo(@40);
        }
    }];
    
    [self.appendView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.contentView.mas_bottom);
        make.left.equalTo(ws.contentView.mas_left);
        make.right.equalTo(ws.contentView.mas_right);
        if (self.isExpanded) {
            make.height.mas_equalTo(@20);
        }
    }];
}

- (void)refreshHeight
{
    self.isExpanded = !self.isExpanded;
//    NSLog(@"%@", self.isExpanded?@"yes":@"no");
    
    [self configHeight];
    
    [self.contentView setNeedsUpdateConstraints];
    [self.contentView updateConstraintsIfNeeded];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.contentView layoutIfNeeded];
    }];
}

@end


@implementation Model


@end
