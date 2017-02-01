//
//  MyPagePayListCell.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 21..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPagePayListCell.h"
#import "GlobalHeader.h"

@implementation MyPagePayListCell

@synthesize titleLabel;
@synthesize cellSelectButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, WIDTH_FRAME - 140, 80)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        [titleLabel setNumberOfLines:0];
        [self addSubview:titleLabel];
        
        cellSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, 100)];
        [self addSubview:cellSelectButton];
    }
    return self;
}

@end
