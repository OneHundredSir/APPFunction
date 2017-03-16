//
//  TableViewController.m
//  Cell-Masonry
//
//  Created by 贾则栋 on 16/3/25.
//  Copyright © 2016年 贾则栋. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"

@interface TableViewController ()

@property (nonatomic, strong) Model *model;
@property (nonatomic, strong) NSMutableArray *flagArr;
@property (nonatomic, strong) NSIndexPath *beforeSelectedIndexPath;
@property (nonatomic, strong) TableViewCell *beforeCell;

@end

@implementation TableViewController

// 初始化数组
- (NSMutableArray *)flagArr
{
    if (_flagArr == nil) {
        _flagArr = [[NSMutableArray alloc] init];
    }
    return _flagArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    for (int i=0; i < 9; i++) {
        Model *model = [[Model alloc] init];
        model.isExpanded = NO;
        [self.flagArr addObject:model];
    }
    
    self.beforeSelectedIndexPath = nil;
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}

// 行内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s, indexPath:%ld", __func__, (long)indexPath.row);
    
    static NSString *cellID = @"CELLID";
    
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (!cell) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    // tableview选中后的颜色控制
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    NSLog(@"1--hash: %lu", (unsigned long)cell.hash);
    
    return cell;
}

// 行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s, indexPath:%ld", __func__, (long)indexPath.row);
    
    Model *model = self.flagArr[indexPath.row];
    if (model.isExpanded) {
        return 60;
    }
    else {
       return 40;
    }
}

// 选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s, indexPath:%ld", __func__, (long)indexPath.row);
    
    Model *model = self.flagArr[indexPath.row];
    model.isExpanded = !model.isExpanded;
    
    // 更新上一选中cell折展状态
    if (self.beforeSelectedIndexPath != nil && self.beforeSelectedIndexPath != indexPath) {
        model = self.flagArr[self.beforeSelectedIndexPath.row];
        if (model.isExpanded) {
            model.isExpanded = NO;
        }
    }
    self.beforeSelectedIndexPath = indexPath;
    
    TableViewCell *cell = (TableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell refreshHeight];
    
    if (self.beforeCell != nil && self.beforeCell != cell) {
        if (self.beforeCell.isExpanded) {
            [self.beforeCell refreshHeight];
        }
    }
    self.beforeCell = cell;
    
    // 非同一cell
//    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [tableView reloadData];
 
//    NSLog(@"2--hash: %lu", (unsigned long)cell.hash);
}




@end
