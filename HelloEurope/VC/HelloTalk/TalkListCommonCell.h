//
//  TalkListCommonCell.h
//  HelloEurope
//
//  Created by Joseph on 2016. 4. 28..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TalkListCommonCell : UITableViewCell{
    UIImageView *iconImage;
    UILabel *nameText;
    UILabel *timeText;
    UILabel *idText;
    UILabel *titleText;
    UIImageView *thumnailImage1;
    UIImageView *thumnailImage2;
    UIImageView *thumnailImage3;
    UIImageView *bottomImage1;
    UIImageView *bottomImage2;
    UIImageView *bottomImage3;
    UILabel *bottomText1;
    UILabel *bottomText2;
    UILabel *bottomText3;
    
    UIButton *likeBtn;
    UIButton *reportBtn;
    UIButton *cellSelectedBtn;
}

@property (nonatomic) UIImageView *iconImage;
@property (nonatomic) UILabel *nameText;
@property (nonatomic) UILabel *timeText;
@property (nonatomic) UILabel *idText;
@property (nonatomic) UILabel *titleText;
@property (nonatomic) UIImageView *thumnailImage1;
@property (nonatomic) UIImageView *thumnailImage2;
@property (nonatomic) UIImageView *thumnailImage3;
@property (nonatomic) UIImageView *bottomImage1;
@property (nonatomic) UIImageView *bottomImage2;
@property (nonatomic) UIImageView *bottomImage3;
@property (nonatomic) UILabel *bottomText1;
@property (nonatomic) UILabel *bottomText2;
@property (nonatomic) UILabel *bottomText3;
@property (nonatomic) UIButton *likeBtn;
@property (nonatomic) UIButton *reportBtn;
@property (nonatomic) UIButton *cellSelectedBtn;

@end
