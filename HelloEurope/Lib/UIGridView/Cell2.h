//
//  Cell2.h
//  naivegrid
//
//  Created by Apirom Na Nakorn on 3/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridViewCell.h"

@interface Cell2 : UIGridViewCell {

}

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic, retain) IBOutlet UIImageView *thumbnail;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *price;

@end
