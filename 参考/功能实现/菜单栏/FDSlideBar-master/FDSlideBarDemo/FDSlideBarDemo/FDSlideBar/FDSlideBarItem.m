//
//  FDSlideBarItem.m
//  FDSlideBarDemo
//
//  Created by fergusding on 15/6/4.
//  Copyright (c) 2015年 fergusding. All rights reserved.
//

#import "FDSlideBarItem.h"



#define DEFAULT_TITLE_FONTSIZE 15
#define DEFAULT_TITLE_SELECTED_FONTSIZE 17
#define DEFAULT_TITLE_COLOR [UIColor blackColor]
#define DEFAULT_TITLE_SELECTED_COLOR [UIColor orangeColor]

#define HORIZONTAL_MARGIN 10


typedef NS_ENUM(NSUInteger, ItemType) {
    ButtonItem = 0,
    LabelItem ,
};

@interface FDSlideBarItem ()

@property (copy, nonatomic) NSString *title;
@property(nonatomic,strong) UIButton *btn;
@property (assign, nonatomic) CGFloat fontSize;
@property (assign, nonatomic) CGFloat selectedFontSize;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) UIColor *selectedColor;
@property(nonatomic,strong)NSArray<UIButton *> *buttons;

@end

@implementation FDSlideBarItem
{
    ItemType itemStyle;
}

#pragma mark - Lifecircle

- (instancetype) init {
    if (self = [super init]) {
        _fontSize = DEFAULT_TITLE_FONTSIZE;
        _selectedFontSize = DEFAULT_TITLE_SELECTED_FONTSIZE;
        _color = DEFAULT_TITLE_COLOR;
        _selectedColor = DEFAULT_TITLE_SELECTED_COLOR;
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//在draw上做基本的绘图!
- (void)drawRect:(CGRect)rect {
    if (itemStyle == ButtonItem) {
        CGFloat btnx,btny =0;
        CGRect btnRect = (CGRect){btnx,btny,[self styleSize].width, [self styleSize].height};
        [_btn drawRect:btnRect];
        
    }else if (itemStyle == LabelItem)
    {
    CGFloat titleX = (CGRectGetWidth(self.frame) - [self styleSize].width) * 0.5;
    CGFloat titleY = (CGRectGetHeight(self.frame) - [self styleSize].height) * 0.5;
    
    CGRect titleRect = CGRectMake(titleX, titleY, [self styleSize].width, [self styleSize].height);
    NSDictionary *attributes = @{NSFontAttributeName : [self titleFont], NSForegroundColorAttributeName : [self titleColor]};
    [_title drawInRect:titleRect withAttributes:attributes];
    }
}

#pragma mark - Custom Accessors

- (void)setSelected:(BOOL)selected {
    _selected = selected;
    [self setNeedsDisplay];
}

#pragma mark - Public

-(void)setItemBtn:(UIButton *)btn
{
    
    itemStyle = ButtonItem;
    _btn = btn;
    [self setNeedsDisplay];
}

//设置对应的名称还有图片自动刷新
- (void)setItemTitle:(NSString *)title {
    itemStyle = LabelItem;
    _title = title;
    [self setNeedsDisplay];
}

- (void)setItemTitleFont:(CGFloat)fontSize {
    _fontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTileFont:(CGFloat)fontSize {
    _selectedFontSize = fontSize;
    [self setNeedsDisplay];
}

- (void)setItemTitleColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

- (void)setItemSelectedTitleColor:(UIColor *)color {
    _selectedColor = color;
    [self setNeedsDisplay];
}

#pragma mark - Private

- (CGSize)styleSize {
    CGSize size = (CGSize){0,0};
    if (itemStyle == ButtonItem)
    {
        size = (CGSize){60,40};
    }else if (itemStyle == LabelItem)
    {
        NSDictionary *attributes = @{NSFontAttributeName : [self titleFont]};
        size = [_title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
        size.width = ceil(size.width);
        size.height = ceil(size.height);
    }
    
    return size;
}

- (UIFont *)titleFont {
    UIFont *font;
    if (_selected) {
        font = [UIFont boldSystemFontOfSize:_selectedFontSize];
    } else {
        font = [UIFont systemFontOfSize:_fontSize];
    }
    return font;
}

- (UIColor *)titleColor {
    UIColor *color;
    if (_selected) {
        color = _selectedColor;
    } else {
        color = _color;
    }
    return color;
}

#pragma mark - Public Class Method

+ (CGFloat)widthForTitle:(NSString *)title {
    NSDictionary *attributes = @{NSFontAttributeName : [UIFont systemFontOfSize:DEFAULT_TITLE_FONTSIZE]};
    CGSize size = [title boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    size.width = ceil(size.width) + HORIZONTAL_MARGIN * 2;
    
    return size.width;
}

#pragma mark - Responder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.selected = YES;
    if (self.delegate && [self.delegate respondsToSelector:@selector(slideBarItemSelected:)]) {
        [self.delegate slideBarItemSelected:self];
    }
}

@end
