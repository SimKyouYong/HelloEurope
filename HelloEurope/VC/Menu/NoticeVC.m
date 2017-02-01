//
//  NoticeVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 17..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "NoticeVC.h"
#import "DrawerNavigation.h"

@interface NoticeVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation NoticeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.rootNav popViewControllerAnimated:NO];
}

@end
