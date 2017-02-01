//
//  InfoIntroVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 17..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "InfoIntroVC.h"
#import "GlobalHeader.h"
#import "DrawerNavigation.h"

@interface InfoIntroVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation InfoIntroVC
@synthesize webView;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    NSURL *infoURL = [NSURL URLWithString:@"http://coaineu.cafe24.com/Hellow/html/hellow_introduce.html"];
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
