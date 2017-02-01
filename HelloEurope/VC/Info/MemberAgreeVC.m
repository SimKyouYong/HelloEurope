//
//  MemberAgreeVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MemberAgreeVC.h"
#import "MemberJoinVC.h"
#import "DrawerNavigation.h"

@interface MemberAgreeVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation MemberAgreeVC

@synthesize textView1;
@synthesize textView2;
@synthesize agreeCheck1;
@synthesize agreeCheck2;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
}

#pragma mark -
#pragma mark Button Action

- (IBAction)submitButton:(id)sender {
    if(agreeCheck1.selected == 1 && agreeCheck2.selected == 1){
        MemberJoinVC *_memberJoinVC = [self.storyboard instantiateViewControllerWithIdentifier:@"memberJoinVC"];
        [self.rootNav pushViewController:_memberJoinVC animated:YES];
    }else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"모두 동의하셔야 합니다." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

- (IBAction)cancelButton:(id)sender {
    [self.rootNav popViewControllerAnimated:YES];
}

- (IBAction)agreeCheck1:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [agreeCheck1 setImage:[UIImage imageNamed:@"join_service_on"] forState:UIControlStateNormal];
    }else{
       [agreeCheck1 setImage:[UIImage imageNamed:@"join_service_off"] forState:UIControlStateNormal];
    }
}

- (IBAction)agreeCheck2:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [agreeCheck2 setImage:[UIImage imageNamed:@"join_agree_on"] forState:UIControlStateNormal];
    }else{
        [agreeCheck2 setImage:[UIImage imageNamed:@"join_agree_off"] forState:UIControlStateNormal];
    }
}

- (IBAction)backButton:(id)sender {
    [self.rootNav popViewControllerAnimated:YES];
}

@end
