//
//  PicturePickerCell.h
//  picturePicker
//
//  Created by maple on 16/10/26.
//  Copyright © 2016年 maple. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PicturePickerCell;
@protocol PicturePickerCellDelegate <NSObject>

- (void)picturePickerCellDidClickAdd:(PicturePickerCell *)cell;
- (void)picturePickerCellDidClickClose:(PicturePickerCell *)cell;

@end

@interface PicturePickerCell : UICollectionViewCell

@property (nonatomic, weak) id<PicturePickerCellDelegate> delegate;

@property (nonatomic, strong) UIImage *image;

@end
