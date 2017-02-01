//
//  Cell2.m
//  naivegrid
//
//  Created by Apirom Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Cell2.h"
#import <QuartzCore/QuartzCore.h> 

@implementation Cell2

@synthesize bgView;
@synthesize thumbnail;
@synthesize title;
@synthesize price;

- (id)init {
    if (self = [super init]) {
		
        self.frame = CGRectMake(0, 0, 200, 200);
		
		[[NSBundle mainBundle] loadNibNamed:@"Cell2" owner:self options:nil];
		
        [self addSubview:self.view];
		/*
		self.thumbnail.layer.cornerRadius = 4.0;
		self.thumbnail.layer.masksToBounds = YES;
		self.thumbnail.layer.borderColor = [UIColor lightGrayColor].CGColor;
		self.thumbnail.layer.borderWidth = 1.0;
         */
	}
    return self;
}

@end
