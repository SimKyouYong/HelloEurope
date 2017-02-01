//
//  TalkListCommonCell.m
//  HelloEurope
//
//  Created by Joseph on 2016. 4. 28..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "TalkListCommonCell.h"
#import "GlobalHeader.h"

@implementation TalkListCommonCell

@synthesize iconImage;
@synthesize nameText;
@synthesize timeText;
@synthesize idText;
@synthesize titleText;
@synthesize thumnailImage1;
@synthesize thumnailImage2;
@synthesize thumnailImage3;
@synthesize bottomImage1;
@synthesize bottomImage2;
@synthesize bottomImage3;
@synthesize bottomText1;
@synthesize bottomText2;
@synthesize bottomText3;
@synthesize likeBtn;
@synthesize reportBtn;
@synthesize cellSelectedBtn;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(10, 10, WIDTH_FRAME - 20, 180)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(28, 20, 27, 27)];
        [iconImage setImage:[UIImage imageNamed:@"talk_list_cell_icon1"]];
        [self addSubview:iconImage];
        
        nameText = [[UILabel alloc] initWithFrame:CGRectMake(70, 22, 100, 10)];
        [nameText setBackgroundColor:[UIColor clearColor]];
        nameText.textColor = [UIColor blackColor];
        nameText.textAlignment = NSTextAlignmentLeft;
        nameText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:nameText];
        
        timeText = [[UILabel alloc] initWithFrame:CGRectMake(70, 34, 100, 10)];
        [timeText setBackgroundColor:[UIColor clearColor]];
        timeText.textColor = [UIColor blackColor];
        timeText.textAlignment = NSTextAlignmentLeft;
        timeText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:timeText];
        
        idText = [[UILabel alloc] initWithFrame:CGRectMake(15, 60, 52, 16)];
        [idText setBackgroundColor:[UIColor clearColor]];
        idText.textColor = [UIColor colorWithRed:110.0f/255.0f green:227.0f/255.0f blue:247.0f/255.0f alpha:1.0];
        idText.textAlignment = NSTextAlignmentCenter;
        idText.font = [UIFont fontWithName:@"Helvetica Bold" size:12.0];
        [self addSubview:idText];
        
        titleText = [[UILabel alloc] initWithFrame:CGRectMake(75, 60, WIDTH_FRAME - 85, 16)];
        [titleText setBackgroundColor:[UIColor clearColor]];
        titleText.textColor = [UIColor blackColor];
        titleText.textAlignment = NSTextAlignmentLeft;
        titleText.font = [UIFont fontWithName:@"Helvetica Bold" size:12.0];
        [self addSubview:titleText];
        
        NSInteger thumnailWid = 0;
        if(WIDTH_FRAME == 414){
            thumnailWid = 121;
        }else if(WIDTH_FRAME == 375){
            thumnailWid = 108;
        }else{
            thumnailWid = 90;
        }
        thumnailImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 90, thumnailWid, 70)];
        thumnailImage1.backgroundColor = [UIColor clearColor];
        [self addSubview:thumnailImage1];
        
        thumnailImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(thumnailImage1.frame.origin.x + thumnailWid + 5, 90, thumnailWid, 70)];
        thumnailImage2.backgroundColor = [UIColor clearColor];
        [self addSubview:thumnailImage2];
        
        thumnailImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(thumnailImage2.frame.origin.x + thumnailWid + 5, 90, thumnailWid, 70)];
        thumnailImage3.backgroundColor = [UIColor clearColor];
        [self addSubview:thumnailImage3];
        
        bottomImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 170, 15, 12)];
        bottomImage1.image = [UIImage imageNamed:@"talk_list_cell_icon9_on"];
        [self addSubview:bottomImage1];
        
        bottomImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(70, 170, 15, 12)];
        bottomImage2.image = [UIImage imageNamed:@"talk_list_cell_icon8_off"];
        [self addSubview:bottomImage2];
        
        bottomImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(120, 170, 15, 12)];
        bottomImage3.image = [UIImage imageNamed:@"talk_list_cell_icon10_off"];
        //[self addSubview:bottomImage3];
        
        bottomText1 = [[UILabel alloc] initWithFrame:CGRectMake(38, 170, 28, 12)];
        [bottomText1 setBackgroundColor:[UIColor clearColor]];
        bottomText1.textColor = [UIColor blackColor];
        bottomText1.textAlignment = NSTextAlignmentLeft;
        bottomText1.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:bottomText1];
        
        bottomText2 = [[UILabel alloc] initWithFrame:CGRectMake(88, 170, 28, 12)];
        [bottomText2 setBackgroundColor:[UIColor clearColor]];
        bottomText2.textColor = [UIColor blackColor];
        bottomText2.textAlignment = NSTextAlignmentLeft;
        bottomText2.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:bottomText2];
        
        bottomText3 = [[UILabel alloc] initWithFrame:CGRectMake(138, 170, 28, 12)];
        [bottomText3 setBackgroundColor:[UIColor clearColor]];
        bottomText3.textColor = [UIColor blackColor];
        bottomText3.textAlignment = NSTextAlignmentLeft;
        bottomText3.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:bottomText3];
        
        cellSelectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, WIDTH_FRAME - 20, 190)];
        [self addSubview:cellSelectedBtn];
        
        likeBtn = [[UIButton alloc] initWithFrame:CGRectMake(65, 165, 30, 20)];
        [self addSubview:likeBtn];
        
        reportBtn = [[UIButton alloc] initWithFrame:CGRectMake(120, 170, 50, 12)];
        [reportBtn setTitle:@"신고하기" forState:UIControlStateNormal];
        [reportBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        reportBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:reportBtn];
    }
    return self;
}

@end
