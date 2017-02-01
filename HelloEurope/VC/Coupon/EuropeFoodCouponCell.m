//
//  EuropeFoodCouponCell.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 27..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "EuropeFoodCouponCell.h"
#import "GlobalHeader.h"

@implementation EuropeFoodCouponCell

@synthesize photoImage;
@synthesize nameText;
@synthesize contentText;
@synthesize timeText;
@synthesize cellSelectedBtn;
@synthesize scontoImage;
@synthesize scontoText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME - 12, 80)];
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 92, 72)];
        photoImage.backgroundColor = [UIColor clearColor];
        [self addSubview:photoImage];
        
        nameText = [[UILabel alloc] initWithFrame:CGRectMake(104, 4, WIDTH_FRAME - 104 - 6, 15)];
        [nameText setBackgroundColor:[UIColor clearColor]];
        nameText.textColor = [UIColor redColor];
        nameText.textAlignment = NSTextAlignmentLeft;
        nameText.font = [UIFont fontWithName:@"Helvetica Bold" size:13.0];
        [self addSubview:nameText];
        
        contentText = [[UILabel alloc] initWithFrame:CGRectMake(104, 22, WIDTH_FRAME - 120 - 6, 24)];
        [contentText setBackgroundColor:[UIColor clearColor]];
        contentText.textColor = [UIColor grayColor];
        contentText.textAlignment = NSTextAlignmentLeft;
        contentText.numberOfLines = 0;
        contentText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:contentText];
        
        timeText = [[UILabel alloc] initWithFrame:CGRectMake(104, 50, WIDTH_FRAME - 120 - 6, 12)];
        [timeText setBackgroundColor:[UIColor clearColor]];
        timeText.textColor = [UIColor grayColor];
        timeText.textAlignment = NSTextAlignmentLeft;
        timeText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:timeText];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, WIDTH_FRAME, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
        cellSelectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME - 12, 80)];
        cellSelectedBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:cellSelectedBtn];
        
        scontoImage = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 43, 0, 43, 43)];
        scontoImage.backgroundColor = [UIColor clearColor];
        scontoImage.image = [UIImage imageNamed:@"food_coupon_sconto"];
        [self addSubview:scontoImage];
        
        scontoText = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 45, 0, 43, 22)];
        [scontoText setBackgroundColor:[UIColor clearColor]];
        scontoText.textColor = [UIColor whiteColor];
        scontoText.textAlignment = NSTextAlignmentRight;
        scontoText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
        [self addSubview:scontoText];
    }
    return self;
}


@end
