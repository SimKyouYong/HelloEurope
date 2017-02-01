//
//  Info2VC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 17..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "Info2VC.h"
#import "DrawerNavigation.h"

@interface Info2VC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation Info2VC

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    NSURL *infoURL = [NSURL URLWithString:@"http://coaineu.cafe24.com/Hellow/html/hellow_personal_new.html"];
    NSURLRequest *infoURLReq = [NSURLRequest requestWithURL:infoURL];
    [webView loadRequest:infoURLReq];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.rootNav popViewControllerAnimated:NO];
}

@end
