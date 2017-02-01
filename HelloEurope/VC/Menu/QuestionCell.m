//
//  QuestionCell.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 18..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "QuestionCell.h"
#import "GlobalHeader.h"

@implementation QuestionCell

@synthesize titleText;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        titleText = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIDTH_FRAME - 40, 40)] ;
        [titleText setBackgroundColor:[UIColor clearColor]];
        titleText.textColor = [UIColor colorWithRed:85 green:194 blue:193 alpha:1];
        titleText.textAlignment = NSTextAlignmentLeft;
        titleText.numberOfLines = 0;
        titleText.font = [UIFont systemFontOfSize:15];
        [self addSubview:titleText];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, WIDTH_FRAME, 0.5)];
        lineView.backgroundColor = [UIColor grayColor];
        [self addSubview:lineView];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
