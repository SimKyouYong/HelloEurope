//
//  MyPageChoose2.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPageChoose2.h"
#import "YSLContainerViewController3.h"
#import "MyPageCartVC.h"
#import "MyPagePayListVC.h"
#import "MyPagePointVC.h"

@interface MyPageChoose2 () <YSLContainerViewControllerDelegate3>

@end

@implementation MyPageChoose2

@synthesize vcNum;
@synthesize backButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyPageCartVC *myPageCartVC = [[MyPageCartVC alloc] initWithNibName:@"MyPageCartVC" bundle:nil];
    
    MyPagePayListVC *myPagePayListVC = [[MyPagePayListVC alloc] initWithNibName:@"MyPagePayListVC" bundle:nil];
    
    MyPagePointVC *myPagePointVC = [[MyPagePointVC alloc] initWithNibName:@"MyPagePointVC" bundle:nil];
    
    if([vcNum isEqualToString:@"1"]){
        myPageCartVC.title = @"mypage06_btn01_on";
        myPagePayListVC.title = @"mypage06_btn02_off";
        myPagePointVC.title = @"mypage06_btn03_off";
    }else if([vcNum isEqualToString:@"2"]){
        myPageCartVC.title = @"mypage06_btn01_off";
        myPagePayListVC.title = @"mypage06_btn02_on";
        myPagePointVC.title = @"mypage06_btn03_off";
    }else if([vcNum isEqualToString:@"3"]){
        myPageCartVC.title = @"mypage06_btn01_off";
        myPagePayListVC.title = @"mypage06_btn02_off";
        myPagePointVC.title = @"mypage06_btn03_on";
    }
    
    // ContainerView
    float statusHeight = 50;
    float navigationHeight = 0;
    
    YSLContainerViewController3 *containerVC = [[YSLContainerViewController3 alloc]initWithControllers:@[myPageCartVC,myPagePayListVC,myPagePointVC]
                                                                                          topBarHeight:statusHeight + navigationHeight
                                                                                  parentViewController:self vcNUM:vcNum];
    containerVC.delegate = self;
    [self.view addSubview:containerVC.view];
    
    [self.view bringSubviewToFront:backButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark YSLContainerViewControllerDelegate

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller{
    NSLog(@"current Index : %ld",(long)index);
    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
