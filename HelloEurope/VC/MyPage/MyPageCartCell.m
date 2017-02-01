//
//  MyPageCartCell.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 21..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPageCartCell.h"
#import "GlobalHeader.h"

@implementation MyPageCartCell

@synthesize titleLabel;
@synthesize comentLabel;
@synthesize cellSelectButton;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        UIView *bgView = [[UIView alloc] init];
        bgView.frame = CGRectMake(0, 0, WIDTH_FRAME - 12, 100);
        bgView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bgView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 10, WIDTH_FRAME - 130, 20)];
        [titleLabel setBackgroundColor:[UIColor clearColor]];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        [self addSubview:titleLabel];
        
        comentLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 40, WIDTH_FRAME - 130, 54)];
        [comentLabel setBackgroundColor:[UIColor clearColor]];
        comentLabel.textColor = [UIColor grayColor];
        comentLabel.textAlignment = NSTextAlignmentLeft;
        comentLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        [comentLabel setNumberOfLines:0];
        [self addSubview:comentLabel];
        
        cellSelectButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, 100)];
        [self addSubview:cellSelectButton];
    }
    return self;
}

@end
