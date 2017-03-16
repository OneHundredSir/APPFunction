//
//  ViewController.m
//  picturePicker
//
//  Created by maple on 16/10/26.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "ViewController.h"
#import "PicturePickerCollectionViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)push
{
    PicturePickerCollectionViewController *picker = [[PicturePickerCollectionViewController alloc] init];
    [self.navigationController pushViewController:picker animated:YES];
}

@end
