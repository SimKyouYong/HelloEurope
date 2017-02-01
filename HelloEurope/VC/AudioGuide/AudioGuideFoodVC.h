//
//  AudioGuideFoodVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 19..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AudioGuideFoodVC : UIViewController{
    NSInteger swipeNum;
    
    CGFloat labelHeight;
    
    UIButton *leftImageView;
    UIButton *centerImageView;
    UIButton *rightImageView;
}

@property (assign, nonatomic) NSDictionary *foodDic;

@property (weak, nonatomic) IBOutlet UIImageView *foodMainImageView;
@property (weak, nonatomic) IBOutlet UIView *foodImageView;

@property (weak, nonatomic) IBOutlet UIScrollView *foodScrollView;

- (IBAction)backButton:(id)sender;

@end
