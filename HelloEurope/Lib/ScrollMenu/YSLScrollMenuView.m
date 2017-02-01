//
//  YSLScrollMenuView.m
//  YSLContainerViewController
//
//  Created by yamaguchi on 2015/03/03.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import "YSLScrollMenuView.h"
#import "GlobalHeader.h"

static const CGFloat kYSLScrollMenuViewWidth  = 60;
static const CGFloat kYSLScrollMenuViewMargin = 10;
static const CGFloat kYSLIndicatorHeight = 3;

@interface YSLScrollMenuView ()

@property (nonatomic, strong) UIView *indicatorView;

@end

@implementation YSLScrollMenuView


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // default
        _viewbackgroudColor = [UIColor whiteColor];
        _itemfont = [UIFont systemFontOfSize:16];
        _itemTitleColor = [UIColor colorWithRed:0.866667 green:0.866667 blue:0.866667 alpha:1.0];
        
        self.backgroundColor = _viewbackgroudColor;
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return self;
}

#pragma mark -
#pragma mark Setter

- (void)setViewbackgroudColor:(UIColor *)viewbackgroudColor
{
    if (!viewbackgroudColor) { return; }
    _viewbackgroudColor = viewbackgroudColor;
    self.backgroundColor = viewbackgroudColor;
}

- (void)setItemfont:(UIFont *)itemfont
{
    if (!itemfont) { return; }
    _itemfont = itemfont;
    for (UILabel *label in _itemTitleArray) {
        label.font = itemfont;
    }
}

- (void)setItemTitleColor:(UIColor *)itemTitleColor
{
    if (!itemTitleColor) { return; }
    _itemTitleColor = itemTitleColor;
    for (UILabel *label in _itemTitleArray) {
        label.textColor = itemTitleColor;
    }
}

- (void)setItemIndicatorColor:(UIColor *)itemIndicatorColor
{
    if (!itemIndicatorColor) { return; }
    _itemIndicatorColor = itemIndicatorColor;
    _indicatorView.backgroundColor = itemIndicatorColor;
}

- (void)setItemTitleArray:(NSArray *)itemTitleArray
{
    if (_itemTitleArray != itemTitleArray) {
        _itemTitleArray = itemTitleArray;
        NSMutableArray *views = [NSMutableArray array];
        
        for (int i = 0; i < itemTitleArray.count; i++) {
            CGRect frame = CGRectMake(0, 0, kYSLScrollMenuViewWidth, CGRectGetHeight(self.frame));
            UILabel *itemView = [[UILabel alloc] initWithFrame:frame];
            //[self.scrollView addSubview:itemView];
            itemView.tag = i;
            itemView.text = itemTitleArray[i];
            itemView.userInteractionEnabled = YES;
            itemView.backgroundColor = [UIColor clearColor];
            itemView.textAlignment = NSTextAlignmentCenter;
            itemView.font = self.itemfont;
            itemView.textColor = _itemTitleColor;
            [views addObject:itemView];
            
            NSInteger sizeWidth = 0;
            if([UIScreen mainScreen].bounds.size.width == 414){
                sizeWidth = 103;
            }else if([UIScreen mainScreen].bounds.size.width == 375){
                sizeWidth = 94;
            }else{
                sizeWidth = 80;
            }
            
            itemImage1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, sizeWidth, 37)];
            [itemImage1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [itemImage1 setImage:[UIImage imageNamed:itemTitleArray[0]] forState:UIControlStateNormal];
            itemImage1.tag = 0;
            itemImage1.frame = CGRectMake(0, 0, sizeWidth, 37);
            [self.scrollView addSubview:itemImage1];
            
            itemImage2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, sizeWidth, 37)];
            [itemImage2 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [itemImage2 setImage:[UIImage imageNamed:itemTitleArray[1]] forState:UIControlStateNormal];
            itemImage2.tag = 1;
            itemImage2.frame = CGRectMake(sizeWidth, 0, sizeWidth, 37);
            [self.scrollView addSubview:itemImage2];
            
            itemImage3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, sizeWidth, 37)];
            [itemImage3 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [itemImage3 setImage:[UIImage imageNamed:itemTitleArray[2]] forState:UIControlStateNormal];
            itemImage3.tag = 2;
            itemImage3.frame = CGRectMake(sizeWidth*2, 0, sizeWidth, 37);
            [self.scrollView addSubview:itemImage3];
            
            itemImage4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, sizeWidth, 37)];
            [itemImage4 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
            [itemImage4 setImage:[UIImage imageNamed:itemTitleArray[3]] forState:UIControlStateNormal];
            itemImage4.tag = 3;
            itemImage4.frame = CGRectMake(sizeWidth*3, 0, sizeWidth, 37);
            [self.scrollView addSubview:itemImage4];
        }
        
        self.itemViewArray = [NSArray arrayWithArray:views];
    }
}

#pragma mark -
#pragma mark public

- (void)setIndicatorViewFrameWithRatio:(CGFloat)ratio isNextItem:(BOOL)isNextItem toIndex:(NSInteger)toIndex
{
    CGFloat indicatorX = 0.0;
    if (isNextItem) {
        indicatorX = ((kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth) * ratio ) + (toIndex * kYSLScrollMenuViewWidth) + ((toIndex + 1) * kYSLScrollMenuViewMargin);
    } else {
        indicatorX =  ((kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth) * (1 - ratio) ) + (toIndex * kYSLScrollMenuViewWidth) + ((toIndex + 1) * kYSLScrollMenuViewMargin);
    }
    
    if (indicatorX < kYSLScrollMenuViewMargin || indicatorX > self.scrollView.contentSize.width - (kYSLScrollMenuViewMargin + kYSLScrollMenuViewWidth)) {
        return;
    }
    _indicatorView.frame = CGRectMake(indicatorX, _scrollView.frame.size.height - kYSLIndicatorHeight, kYSLScrollMenuViewWidth, kYSLIndicatorHeight);
    //  NSLog(@"retio : %f",_indicatorView.frame.origin.x);
}

- (void)setItemTextColor:(UIColor *)itemTextColor
    seletedItemTextColor:(UIColor *)selectedItemTextColor
            currentIndex:(NSInteger)currentIndex
{
    if (itemTextColor) { _itemTitleColor = itemTextColor; }
    if (selectedItemTextColor) { _itemSelectedTitleColor = selectedItemTextColor; }
    
    for (int i = 0; i < self.itemViewArray.count; i++) {
        UILabel *label = self.itemViewArray[i];
        if (i == currentIndex) {
            label.alpha = 0.0;
            [UIView animateWithDuration:0.75
                                  delay:0.0
                                options:UIViewAnimationOptionCurveLinear | UIViewAnimationOptionAllowUserInteraction
                             animations:^{
                                 label.alpha = 1.0;
                                 label.textColor = _itemSelectedTitleColor;
                             } completion:^(BOOL finished) {
                             }];
        } else {
            label.textColor = _itemTitleColor;
        }
    }
}

#pragma mark -
#pragma mark private

- (void)setShadowView
{
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(0, self.frame.size.height - 0.5, CGRectGetWidth(self.frame), 0.5);
    view.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:view];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat x = kYSLScrollMenuViewMargin;
    for (NSUInteger i = 0; i < self.itemViewArray.count; i++) {
        CGFloat width = kYSLScrollMenuViewWidth;
        UIView *itemView = self.itemViewArray[i];
        itemView.frame = CGRectMake(x, 0, width, self.scrollView.frame.size.height);
        x += width + kYSLScrollMenuViewMargin;
    }
    self.scrollView.contentSize = CGSizeMake(x, self.scrollView.frame.size.height);
    
    CGRect frame = self.scrollView.frame;
    if (self.frame.size.width > x) {
        frame.origin.x = (self.frame.size.width - x) / 2;
        frame.size.width = x;
    } else {
        frame.origin.x = 0;
        frame.size.width = self.frame.size.width;
    }
    self.scrollView.frame = CGRectMake(0, 0, WIDTH_FRAME, 50);//frame;
}

#pragma mark -
#pragma mark Selector

- (void)itemViewTapAction:(UITapGestureRecognizer *)Recongnizer
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(scrollMenuViewSelectedIndex:)]) {
        [self.delegate scrollMenuViewSelectedIndex:[(UIGestureRecognizer*) Recongnizer view].tag];
    }
}

- (void)setItemImage:(NSInteger)currentIndex{
    if(currentIndex == 0){
        [itemImage1 setImage:[UIImage imageNamed:@"main_top_menu_01_on"] forState:UIControlStateNormal];
        [itemImage2 setImage:[UIImage imageNamed:@"main_top_menu_02_off"] forState:UIControlStateNormal];
        [itemImage3 setImage:[UIImage imageNamed:@"main_top_menu_03_off"] forState:UIControlStateNormal];
        [itemImage4 setImage:[UIImage imageNamed:@"main_top_menu_04_off"] forState:UIControlStateNormal];
    }else if(currentIndex == 1){
        [itemImage1 setImage:[UIImage imageNamed:@"main_top_menu_01_off"] forState:UIControlStateNormal];
        [itemImage2 setImage:[UIImage imageNamed:@"main_top_menu_02_on"] forState:UIControlStateNormal];
        [itemImage3 setImage:[UIImage imageNamed:@"main_top_menu_03_off"] forState:UIControlStateNormal];
        [itemImage4 setImage:[UIImage imageNamed:@"main_top_menu_04_off"] forState:UIControlStateNormal];
    }else if(currentIndex == 2){
        [itemImage1 setImage:[UIImage imageNamed:@"main_top_menu_01_off"] forState:UIControlStateNormal];
        [itemImage2 setImage:[UIImage imageNamed:@"main_top_menu_02_off"] forState:UIControlStateNormal];
        [itemImage3 setImage:[UIImage imageNamed:@"main_top_menu_03_on"] forState:UIControlStateNormal];
        [itemImage4 setImage:[UIImage imageNamed:@"main_top_menu_04_off"] forState:UIControlStateNormal];
    }else if(currentIndex == 3){
        [itemImage1 setImage:[UIImage imageNamed:@"main_top_menu_01_off"] forState:UIControlStateNormal];
        [itemImage2 setImage:[UIImage imageNamed:@"main_top_menu_02_off"] forState:UIControlStateNormal];
        [itemImage3 setImage:[UIImage imageNamed:@"main_top_menu_03_off"] forState:UIControlStateNormal];
        [itemImage4 setImage:[UIImage imageNamed:@"main_top_menu_04_on"] forState:UIControlStateNormal];
    }
}

- (void)buttonAction:(UIButton*)sender{
    [self.delegate menuSelectScroll:sender.tag];
    
    if(sender.tag == 0){
        [itemImage1 setImage:[UIImage imageNamed:@"main_top_menu_01_on"] forState:UIControlStateNormal];
        [itemImage2 setImage:[UIImage imageNamed:@"main_top_menu_02_off"] forState:UIControlStateNormal];
        [itemImage3 setImage:[UIImage imageNamed:@"main_top_menu_03_off"] forState:UIControlStateNormal];
        [itemImage4 setImage:[UIImage imageNamed:@"main_top_menu_04_off"] forState:UIControlStateNormal];
    }else if(sender.tag == 1){
        [itemImage1 setImage:[UIImage imageNamed:@"main_top_menu_01_off"] forState:UIControlStateNormal];
        [itemImage2 setImage:[UIImage imageNamed:@"main_top_menu_02_on"] forState:UIControlStateNormal];
        [itemImage3 setImage:[UIImage imageNamed:@"main_top_menu_03_off"] forState:UIControlStateNormal];
        [itemImage4 setImage:[UIImage imageNamed:@"main_top_menu_04_off"] forState:UIControlStateNormal];
    }else if(sender.tag == 2){
        [itemImage1 setImage:[UIImage imageNamed:@"main_top_menu_01_off"] forState:UIControlStateNormal];
        [itemImage2 setImage:[UIImage imageNamed:@"main_top_menu_02_off"] forState:UIControlStateNormal];
        [itemImage3 setImage:[UIImage imageNamed:@"main_top_menu_03_on"] forState:UIControlStateNormal];
        [itemImage4 setImage:[UIImage imageNamed:@"main_top_menu_04_off"] forState:UIControlStateNormal];
    }else if(sender.tag == 3){
        [itemImage1 setImage:[UIImage imageNamed:@"main_top_menu_01_off"] forState:UIControlStateNormal];
        [itemImage2 setImage:[UIImage imageNamed:@"main_top_menu_02_off"] forState:UIControlStateNormal];
        [itemImage3 setImage:[UIImage imageNamed:@"main_top_menu_03_off"] forState:UIControlStateNormal];
        [itemImage4 setImage:[UIImage imageNamed:@"main_top_menu_04_on"] forState:UIControlStateNormal];
    }
}

@end
