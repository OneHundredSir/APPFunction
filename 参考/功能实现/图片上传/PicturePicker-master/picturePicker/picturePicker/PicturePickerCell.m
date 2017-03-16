//
//  PicturePickerCell.m
//  picturePicker
//
//  Created by maple on 16/10/26.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "PicturePickerCell.h"

@interface PicturePickerCell ()

@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;

@end

@implementation PicturePickerCell


- (IBAction)add
{
    if([self.delegate respondsToSelector:@selector(picturePickerCellDidClickAdd:)])
    {
        [self.delegate picturePickerCellDidClickAdd:self];
    }
}

- (IBAction)close
{
    if([self.delegate respondsToSelector:@selector(picturePickerCellDidClickClose:)])
    {
        [self.delegate picturePickerCellDidClickClose:self];
    }
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    // 图片不为空则显示，否则显示 “+”
    if(image != nil)
    {
        self.closeButton.hidden = NO;
        [self.addButton setBackgroundImage:image forState:UIControlStateNormal];
    }
    else
    {
        self.closeButton.hidden = YES;
        [self.addButton setBackgroundImage:[UIImage imageNamed:@"compose_pic_add"] forState:UIControlStateNormal];
    }
}
@end
