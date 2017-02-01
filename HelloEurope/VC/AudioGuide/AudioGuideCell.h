//
//  AudioGuideCell.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 16..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioGuideCell : UITableViewCell{
    UIImageView *photoImage;
    UILabel *nameText;
    UILabel *contentText;
    UIButton *cellSelectedBtn;
}

@property (nonatomic) UIImageView *photoImage;
@property (nonatomic) UILabel *nameText;
@property (nonatomic) UILabel *contentText;
@property (nonatomic) UIButton *cellSelectedBtn;

@end
