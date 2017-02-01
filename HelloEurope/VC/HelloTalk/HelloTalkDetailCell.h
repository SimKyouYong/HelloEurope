//
//  HelloTalkDetailCell.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 2..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HelloTalkDetailCell : UITableViewCell{
    UILabel *nameText;
    UILabel *contentText;
    UIImageView *photoImage;
    UIControl *maskPhotoImage;
    UIView *lineView;
}

@property (nonatomic) UILabel *nameText;
@property (nonatomic) UILabel *contentText;
@property (nonatomic) UIImageView *photoImage;
@property (nonatomic) UIControl *maskPhotoImage;
@property (nonatomic) UIView *lineView;

@end
