//
//  MyPageBookmarkCell.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 21..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPageBookmarkCell.h"
#import "GlobalHeader.h"

@implementation MyPageBookmarkCell

@synthesize thumbImage;
@synthesize nameLabel;
@synthesize dateLabel;
@synthesize idLabel;
@synthesize titleLabel;
@synthesize bottomImage1;
@synthesize bottomText1;
@synthesize bottomImage2;
@synthesize bottomText2;
@synthesize selectButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc] init];
        bgView.frame = CGRectMake(0, 0, WIDTH_FRAME - 12, 190);
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        thumbImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 20, 27, 27)];
        thumbImage.backgroundColor = [UIColor clearColor];
        thumbImage.image = [UIImage imageNamed:@"mypage01_icon.png"];
        //[self addSubview:thumbImage];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 22, 100, 10)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:nameLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 34, 100, 10)];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:dateLabel];
        
        idLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 52, 16)];
        //[idLabel setBackgroundColor:[UIColor colorWithRed:110.0/255.0 green:227.0/255.0 blue:247.0/255.0 alpha:1.0]];
        idLabel.textColor = [UIColor colorWithRed:110.0/255.0 green:227.0/255.0 blue:247.0/255.0 alpha:1.0];
        idLabel.textAlignment = NSTextAlignmentLeft;
        idLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:12.0];
        [self addSubview:idLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 60, WIDTH_FRAME - 100, 16)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:12.0];
        [self addSubview:titleLabel];
        
        bottomImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 170, 15, 12)];
        bottomImage1.backgroundColor = [UIColor clearColor];
        bottomImage1.image = [UIImage imageNamed:@"mypage_post_coment_btn_on.png"];
        [self addSubview:bottomImage1];
        
        bottomText1 = [[UILabel alloc] initWithFrame:CGRectMake(38, 170, 28, 12)];
        bottomText1.textColor = [UIColor blackColor];
        bottomText1.textAlignment = NSTextAlignmentLeft;
        bottomText1.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:bottomText1];
        
        bottomImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 170, 15, 12)];
        bottomImage2.backgroundColor = [UIColor clearColor];
        bottomImage2.image = [UIImage imageNamed:@"talk_list_cell_icon8_off.png"];
        [self addSubview:bottomImage2];
        
        bottomText2 = [[UILabel alloc] initWithFrame:CGRectMake(88, 170, 28, 12)];
        bottomText2.textColor = [UIColor blackColor];
        bottomText2.textAlignment = NSTextAlignmentLeft;
        bottomText2.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:bottomText2];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.frame.size.height, WIDTH_FRAME - 32, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        //[self addSubview:lineView];
        
        selectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, 190)];
        [self addSubview:selectButton];
    }
    return self;
}

@end
