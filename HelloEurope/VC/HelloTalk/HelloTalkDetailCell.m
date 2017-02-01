//
//  HelloTalkDetailCell.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 2..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "HelloTalkDetailCell.h"
#import "GlobalHeader.h"

@implementation HelloTalkDetailCell

@synthesize nameText;
@synthesize contentText;
@synthesize photoImage;
@synthesize maskPhotoImage;
@synthesize lineView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        nameText = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 13)];
        [nameText setBackgroundColor:[UIColor clearColor]];
        nameText.textColor = [UIColor purpleColor];
        nameText.textAlignment = NSTextAlignmentLeft;
        nameText.font = [UIFont fontWithName:@"Helvetica Bold" size:12.0];
        [self addSubview:nameText];
        
        contentText = [[UILabel alloc] initWithFrame:CGRectMake(60, 4, WIDTH_FRAME - 70, 13)];
        [contentText setBackgroundColor:[UIColor clearColor]];
        contentText.text = @"";
        contentText.textColor = [UIColor blackColor];
        contentText.textAlignment = NSTextAlignmentLeft;
        contentText.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [self addSubview:contentText];
        
        lineView = [[UIView alloc] initWithFrame:CGRectMake(10, self.frame.size.height, WIDTH_FRAME - 32, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
        
        photoImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 0, 50, 50)];
        photoImage.backgroundColor = [UIColor clearColor];
        [self addSubview:photoImage];
        
        maskPhotoImage = [[UIControl alloc] initWithFrame:CGRectMake(60, 0, 50, 50)];
        [self addSubview:maskPhotoImage];
    }
    return self;
}

@end
