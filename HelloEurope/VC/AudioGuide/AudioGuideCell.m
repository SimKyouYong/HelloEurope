//
//  AudioGuideCell.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 16..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "AudioGuideCell.h"
#import "GlobalHeader.h"

@implementation AudioGuideCell

@synthesize photoImage;
@synthesize nameText;
@synthesize contentText;
@synthesize cellSelectedBtn;

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
        
        nameText = [[UILabel alloc] initWithFrame:CGRectMake(104, 14, WIDTH_FRAME - 104 - 6, 18)];
        [nameText setBackgroundColor:[UIColor clearColor]];
        nameText.textColor = [UIColor redColor];
        nameText.textAlignment = NSTextAlignmentLeft;
        nameText.font = [UIFont fontWithName:@"Helvetica Bold" size:15.0];
        [self addSubview:nameText];
        
        contentText = [[UILabel alloc] initWithFrame:CGRectMake(104, 36, WIDTH_FRAME - 120 - 6, 30)];
        [contentText setBackgroundColor:[UIColor clearColor]];
        contentText.textColor = [UIColor grayColor];
        contentText.textAlignment = NSTextAlignmentLeft;
        contentText.numberOfLines = 0;
        contentText.font = [UIFont fontWithName:@"Helvetica Bold" size:13.0];
        [self addSubview:contentText];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 80, WIDTH_FRAME - 12, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
        cellSelectedBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME - 12, 80)];
        cellSelectedBtn.backgroundColor = [UIColor clearColor];
        [self addSubview:cellSelectedBtn];
    }
    return self;
}

@end
