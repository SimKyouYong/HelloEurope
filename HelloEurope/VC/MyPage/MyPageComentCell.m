//
//  MyPageComentCell.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 21..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPageComentCell.h"
#import "GlobalHeader.h"

@implementation MyPageComentCell

@synthesize bgView;
@synthesize nameLabel;
@synthesize dateLabel;
@synthesize contentLabel;
@synthesize delButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        bgView = [[UIView alloc] init];
        bgView.frame = CGRectMake(0, 0, WIDTH_FRAME - 12, 72);
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 6, WIDTH_FRAME - 100, 16)];
        [nameLabel setBackgroundColor:[UIColor clearColor]];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        nameLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self addSubview:nameLabel];
        
        dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 22, WIDTH_FRAME - 100, 12)];
        [dateLabel setBackgroundColor:[UIColor clearColor]];
        dateLabel.textColor = [UIColor blackColor];
        dateLabel.textAlignment = NSTextAlignmentLeft;
        dateLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:dateLabel];
        
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 36, WIDTH_FRAME - 100, 34)];
        //[contentLabel setBackgroundColor:[UIColor colorWithRed:110.0/255.0 green:227.0/255.0 blue:247.0/255.0 alpha:1.0]];
        contentLabel.textColor = [UIColor blackColor];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [contentLabel setNumberOfLines:0];
        contentLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        [self addSubview:contentLabel];
        
        delButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 50, 10, 27, 27)];
        [delButton setBackgroundImage:[UIImage imageNamed:@"mypage_close_off.png"] forState:UIControlStateNormal];
        [self addSubview:delButton];
    }
    return self;
}

@end
