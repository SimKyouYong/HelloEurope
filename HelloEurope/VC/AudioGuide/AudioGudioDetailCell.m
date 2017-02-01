//
//  AudioGudioDetailCell.m
//  HelloEurope
//
//  Created by Joseph on 2016. 5. 18..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "AudioGudioDetailCell.h"
#import "GlobalHeader.h"

@implementation AudioGudioDetailCell

@synthesize titleText1;
@synthesize leftImage;
@synthesize centerImage;
@synthesize centerView;

@synthesize icon;
@synthesize thumbImage;
@synthesize titleText2;
@synthesize countryName;
@synthesize contentText;
@synthesize leftView;
@synthesize audioButton;
@synthesize cellSelectedBtn;
@synthesize titleText2_sub;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    
        //상단 타이틀 (오전코스)
        titleText1 = [[UILabel alloc] initWithFrame:CGRectMake(50, 10, WIDTH_FRAME - 50 - 20, 20)];
        [titleText1 setBackgroundColor:[UIColor clearColor]];
        titleText1.textColor = [UIColor grayColor];
        titleText1.textAlignment = NSTextAlignmentCenter;
        titleText1.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        [self addSubview:titleText1];
        
        //맨위에 있는 이미지 동그라미
        leftImage = [[UIImageView alloc] initWithFrame:CGRectMake(6, 6, 25, 28)];
        leftImage.backgroundColor = [UIColor clearColor];
        leftImage.image = [UIImage imageNamed:@"audio_detail_list_01"];
        [self addSubview:leftImage];
        
        centerImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 11, 11, 18)];
        centerImage.backgroundColor = [UIColor clearColor];
        centerImage.image = [UIImage imageNamed:@"audio_detail_list_03"];
        [self addSubview:centerImage];
        
        centerView = [[UIView alloc] initWithFrame:CGRectMake(35, 30, WIDTH_FRAME - 50 - 20, 0.5)];
        centerView.backgroundColor = [UIColor grayColor];
        [self addSubview:centerView];
        
        //마지막 리스트 아이콘 동그라미
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(25, 0, 40, 40)];
        icon.backgroundColor = [UIColor clearColor];
        icon.image = [UIImage imageNamed:@"audio_detail_list_02"];
        [self addSubview:icon];
        
        //바르셀로나 인트로 글씨
        titleText2 = [[UILabel alloc] initWithFrame:CGRectMake(72, 2, 200, 20)];
        [titleText2 setBackgroundColor:[UIColor clearColor]];
        titleText2.textColor = [UIColor grayColor];
        titleText2.textAlignment = NSTextAlignmentLeft;
        titleText2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self addSubview:titleText2];
        
        titleText2_sub = [[UILabel alloc] initWithFrame:CGRectMake(72, 15, 200, 20)];
        [titleText2_sub setBackgroundColor:[UIColor clearColor]];
        titleText2_sub.textColor = [UIColor grayColor];
        titleText2_sub.textAlignment = NSTextAlignmentLeft;
        titleText2_sub.font = [UIFont fontWithName:@"Helvetica" size:11.0];
        titleText2_sub.text = @"test";
        [self addSubview:titleText2_sub];
        
        //서버 이미지 땡겨오는거
        thumbImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 38, 92, 72)];
        thumbImage.backgroundColor = [UIColor redColor];
        [self addSubview:thumbImage];
        
        //[스페인]바르셀로나
        countryName = [[UILabel alloc] initWithFrame:CGRectMake(130, 35, WIDTH_FRAME - 130 - 10, 20)];
        [countryName setBackgroundColor:[UIColor clearColor]];
        countryName.textColor = [UIColor colorWithRed:(85/255.0) green:(194/255.0) blue:(193/255.0) alpha:1];
        countryName.textAlignment = NSTextAlignmentLeft;
        countryName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self addSubview:countryName];
        
        //상세글
        contentText = [[UILabel alloc] initWithFrame:CGRectMake(130, 33 + countryName.frame.size.height, WIDTH_FRAME - 130 - 10, 35)];
        [contentText setBackgroundColor:[UIColor clearColor]];
        contentText.textColor = [UIColor grayColor];
        contentText.textAlignment = NSTextAlignmentLeft;
        contentText.numberOfLines = 3;
        contentText.font = [UIFont fontWithName:@"Helvetica" size:9.0];
        [self addSubview:contentText];
        
        leftView = [[UIView alloc] initWithFrame:CGRectMake(18, 0, 0.5, HEIGHT_FRAME)];
        leftView.backgroundColor = [UIColor grayColor];
        [self addSubview:leftView];
        
        cellSelectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, 0, WIDTH_FRAME - 50, 109)];
        [self addSubview:cellSelectedBtn];
        
        audioButton = [[UIButton alloc] initWithFrame:CGRectMake(130, 55 + contentText.frame.size.height, 100, 38)];
        [audioButton setImage:[UIImage imageNamed:@"audio_detail_audio_off"] forState:UIControlStateNormal];
        [audioButton setImage:[UIImage imageNamed:@"audio_detail_audio_on"] forState:UIControlStateHighlighted];
        audioButton.backgroundColor = [UIColor clearColor];
        [self addSubview:audioButton];
        
    }
    return self;
}

@end
