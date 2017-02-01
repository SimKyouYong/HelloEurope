//
//  SettingVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 17..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "SettingVC.h"
#import "DrawerNavigation.h"
#import "GlobalHeader.h"

@interface SettingVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation SettingVC

@synthesize autoLoginButton;
@synthesize pushAlarmButton;
@synthesize alarmEventButton;
@synthesize msgButton;
@synthesize comentButton;
@synthesize likeButton;
@synthesize versionText;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    if([[defaults stringForKey:REMEMBER_IDPW_SAVE] isEqualToString:@"YES"]){
        autoLoginButton.selected = 1;
    }else{
        autoLoginButton.selected = 0;
    }
    if([[defaults stringForKey:SETTING_PUSH] isEqualToString:@"YES"]){
        pushAlarmButton.selected = 1;
    }else{
        pushAlarmButton.selected = 0;
    }
    if([[defaults stringForKey:SETTING_ALARMEVENT] isEqualToString:@"YES"]){
        alarmEventButton.selected = 1;
    }else{
        alarmEventButton.selected = 0;
    }
    if([[defaults stringForKey:SETTING_MSG] isEqualToString:@"YES"]){
        msgButton.selected = 1;
    }else{
        msgButton.selected = 0;
    }
    if([[defaults stringForKey:SETTING_COMMENT] isEqualToString:@"YES"]){
        comentButton.selected = 1;
    }else{
        comentButton.selected = 0;
    }
    if([[defaults stringForKey:SETTING_LIKE] isEqualToString:@"YES"]){
        likeButton.selected = 1;
    }else{
        likeButton.selected = 0;
    }
    versionText.text = [[[NSBundle bundleForClass:[self class]] infoDictionary] objectForKey:@"CFBundleVersion"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Button

- (IBAction)backButton:(id)sender {
    [self.rootNav popViewControllerAnimated:NO];
}

- (IBAction)autoLoginButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [defaults setObject:@"YES" forKey:REMEMBER_IDPW_SAVE];
    }else{
        [defaults setObject:@"NO" forKey:REMEMBER_IDPW_SAVE];
    }
}

- (IBAction)pushAlarmButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [defaults setObject:@"YES" forKey:SETTING_PUSH];
    }else{
        [defaults setObject:@"NO" forKey:SETTING_PUSH];
    }
}

- (IBAction)alarmEventButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [defaults setObject:@"YES" forKey:SETTING_ALARMEVENT];
    }else{
        [defaults setObject:@"NO" forKey:SETTING_ALARMEVENT];
    }
}

- (IBAction)msgButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [defaults setObject:@"YES" forKey:SETTING_MSG];
    }else{
        [defaults setObject:@"NO" forKey:SETTING_MSG];
    }
}

- (IBAction)comentButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [defaults setObject:@"YES" forKey:SETTING_COMMENT];
    }else{
        [defaults setObject:@"NO" forKey:SETTING_COMMENT];
    }
}

- (IBAction)likeButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [defaults setObject:@"YES" forKey:SETTING_LIKE];
    }else{
        [defaults setObject:@"NO" forKey:SETTING_LIKE];
    }
}

@end
