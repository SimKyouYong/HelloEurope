//
//  MyPagePointCell.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 21..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPagePointCell.h"
#import "GlobalHeader.h"

@implementation MyPagePointCell

@synthesize titleLabel;
@synthesize comentLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 6, WIDTH_FRAME - 80, 20)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        [self addSubview:titleLabel];
        
        comentLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 30, WIDTH_FRAME - 80, 20)];
        [comentLabel setBackgroundColor:[UIColor clearColor]];
        comentLabel.textColor = [UIColor blackColor];
        comentLabel.textAlignment = NSTextAlignmentLeft;
        comentLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [comentLabel setNumberOfLines:0];
        [self addSubview:comentLabel];
    }
    return self;
}

@end
