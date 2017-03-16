//
//  PicturePickerCollectionViewController.m
//  picturePicker
//
//  Created by maple on 16/10/26.
//  Copyright © 2016年 maple. All rights reserved.
//

#import "PicturePickerCollectionViewController.h"
#import "PicturePickerCell.h"
#import "TZImagePickerController.h"

@interface PicturePickerCollectionViewController ()<PicturePickerCellDelegate, TZImagePickerControllerDelegate>
/// 布局
@property (nonatomic, weak) UICollectionViewFlowLayout *layout;
/// 图片数组
@property (nonatomic, strong) NSMutableArray *imageArray;
/// 图片选择器
@property (nonatomic, strong) TZImagePickerController *picker;
@end

@implementation PicturePickerCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
static CGFloat const ItemMargin = 5;  // item之间的间距
static CGFloat const CollectionViewMargin = 10; // collectionView的间距
static NSInteger const maxPhotoCount = 9; // 最多选择9张图片
static NSInteger const numberOfColumn = 3; // 一行显示几列

- (instancetype)init
{
    // 计算itemSize
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat itemWH = (screenW - ItemMargin * (numberOfColumn - 1) - CollectionViewMargin * 2) / numberOfColumn;
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    layout.minimumLineSpacing = ItemMargin;
    layout.minimumInteritemSpacing = ItemMargin;
    self.layout = layout;
    return [super initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.contentInset = UIEdgeInsetsMake(0, CollectionViewMargin, 0, CollectionViewMargin);
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(PicturePickerCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    // 图片个数 < 9时，显示末尾的 “+”
    NSInteger count = 0;
    if(self.imageArray.count < maxPhotoCount)
        count = self.imageArray.count + 1;
    else
        count = maxPhotoCount;
    return count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PicturePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    // 有图片显示图片，无图片显示 “+”
    if(indexPath.item < self.imageArray.count)
        cell.image = self.imageArray[indexPath.item];
    else
        cell.image = nil;
    return cell;
}

#pragma mark - PicturePickerCellDelegate
- (void)picturePickerCellDidClickAdd:(PicturePickerCell *)cell
{
    // 弹出图片选择器
    [self presentViewController:self.picker animated:YES completion:nil];
}

- (void)picturePickerCellDidClickClose:(PicturePickerCell *)cell
{
    // 根据cell的下标，删去数组中对应的图片
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    [self.imageArray removeObjectAtIndex:indexPath.item];
    [self.collectionView reloadData];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos
{
    self.imageArray = [NSMutableArray arrayWithArray:photos];
    [self.collectionView reloadData];
}

#pragma mark - getter
- (NSMutableArray *)imageArray
{
    if(_imageArray == nil)
    {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

- (TZImagePickerController *)picker
{
    if(_picker == nil)
    {
        _picker = [[TZImagePickerController alloc] initWithMaxImagesCount:maxPhotoCount delegate:self];
    }
    return _picker;
}

@end
