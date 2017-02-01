//
//  EuropeFoodCouponCell.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 27..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EuropeFoodCouponCell : UITableViewCell{
    UIImageView *photoImage;
    UILabel *nameText;
    UILabel *contentText;
    UILabel *timeText;
    UIButton *cellSelectedBtn;
    UIImageView *scontoImage;
    UILabel *scontoText;
}

@property (nonatomic) UIImageView *photoImage;
@property (nonatomic) UILabel *nameText;
@property (nonatomic) UILabel *contentText;
@property (nonatomic) UILabel *timeText;
@property (nonatomic) UIButton *cellSelectedBtn;
@property (nonatomic) UIImageView *scontoImage;
@property (nonatomic) UILabel *scontoText;

@end