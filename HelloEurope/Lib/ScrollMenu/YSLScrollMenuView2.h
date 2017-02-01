//
//  YSLScrollMenuView2.h
//  YSLContainerViewController2
//
//  Created by yamaguchi on 2015/03/03.
//  Copyright (c) 2015年 h.yamaguchi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YSLScrollMenuViewDelegate2 <NSObject>

- (void)scrollMenuViewSelectedIndex:(NSInteger)index;
- (void)menuSelectScroll:(NSInteger)index;

@end

@interface YSLScrollMenuView2 : UIView<UIGestureRecognizerDelegate>{
    UIButton *itemImage1;
    UIButton *itemImage2;
    UIButton *itemImage3;
    UIButton *itemImage4;
}

@property (nonatomic, weak) id <YSLScrollMenuViewDelegate2> delegate;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSArray *itemTitleArray;
@property (nonatomic, strong) NSArray *itemViewArray;

@property (nonatomic, strong) UIColor *viewbackgroudColor;
@property (nonatomic, strong) UIFont *itemfont;
@property (nonatomic, strong) UIColor *itemTitleColor;
@property (nonatomic, strong) UIColor *itemSelectedTitleColor;
@property (nonatomic, strong) UIColor *itemIndicatorColor;

- (void)setShadowView;

- (void)setIndicatorViewFrameWithRatio:(CGFloat)ratio isNextItem:(BOOL)isNextItem toIndex:(NSInteger)toIndex;

- (void)setItemTextColor:(UIColor *)itemTextColor
    seletedItemTextColor:(UIColor *)selectedItemTextColor
            currentIndex:(NSInteger)currentIndex;

- (void)setItemImage:(NSInteger)currentIndex;

@end
