//
//  SettingVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 17..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingVC : UIViewController{
    NSUserDefaults *defaults;
}

@property (weak, nonatomic) IBOutlet UIButton *autoLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *pushAlarmButton;
@property (weak, nonatomic) IBOutlet UIButton *alarmEventButton;
@property (weak, nonatomic) IBOutlet UIButton *msgButton;
@property (weak, nonatomic) IBOutlet UIButton *comentButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *versionText;

- (IBAction)backButton:(id)sender;
- (IBAction)autoLoginButton:(id)sender;
- (IBAction)pushAlarmButton:(id)sender;
- (IBAction)alarmEventButton:(id)sender;
- (IBAction)msgButton:(id)sender;
- (IBAction)comentButton:(id)sender;
- (IBAction)likeButton:(id)sender;

@end
