//
//  AudioGudioDetailCell.h
//  HelloEurope
//
//  Created by Joseph on 2016. 5. 18..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioGudioDetailCell : UITableViewCell{
    UILabel *titleText1;
    UIImageView *leftImage;
    UIImageView *centerImage;
    UIView *centerView;
    
    UIImageView *thumbImage;
    UILabel *titleText2;
    UILabel *titleText2_sub;
    UILabel *countryName;
    UILabel *contentText;
    UIView *leftView;
    UIButton *audioButton;
    UIButton *cellSelectedBtn;
}

@property (nonatomic) UILabel *titleText1;
@property (nonatomic) UIImageView *leftImage;
@property (nonatomic) UIImageView *centerImage;
@property (nonatomic) UIView *centerView;

@property (nonatomic) UIImageView *icon;
@property (nonatomic) UIImageView *thumbImage;
@property (nonatomic) UILabel *titleText2;
@property (nonatomic) UILabel *titleText2_sub;
@property (nonatomic) UILabel *countryName;
@property (nonatomic) UILabel *contentText;
@property (nonatomic) UIView *leftView;
@property (nonatomic) UIButton *audioButton;
@property (nonatomic) UIButton *cellSelectedBtn;

@end
