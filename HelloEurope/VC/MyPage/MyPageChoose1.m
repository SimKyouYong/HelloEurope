//
//  MyPageChoose1.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPageChoose1.h"
#import "YSLContainerViewController2.h"
#import "MyPagePostVC.h"
#import "MyPageMsgVC.h"
#import "MyPageComentVC.h"
#import "MyPageBookmarkVC.h"

@interface MyPageChoose1 () <YSLContainerViewControllerDelegate2>

@end

@implementation MyPageChoose1

@synthesize vcNum;
@synthesize backButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    MyPagePostVC *myPagePostVC = [[MyPagePostVC alloc] initWithNibName:@"MyPagePostVC" bundle:nil];
    
    MyPageMsgVC *myPageMsgVC = [[MyPageMsgVC alloc] initWithNibName:@"MyPageMsgVC" bundle:nil];
    
    MyPageComentVC *myPageComentVC = [[MyPageComentVC alloc] initWithNibName:@"MyPageComentVC" bundle:nil];
    
    MyPageBookmarkVC *myPageBookmarkVC = [[MyPageBookmarkVC alloc] initWithNibName:@"MyPageBookmarkVC" bundle:nil];
    
    if([vcNum isEqualToString:@"1"]){
        myPagePostVC.title = @"mypage02_btn01_on.png";
        myPageMsgVC.title = @"mypage02_btn02_off.png";
        myPageComentVC.title = @"mypage02_btn03_off.png";
        myPageBookmarkVC.title = @"mypage02_btn04_off.png";
    }else if([vcNum isEqualToString:@"2"]){
        myPagePostVC.title = @"mypage02_btn01_off.png";
        myPageMsgVC.title = @"mypage02_btn02_on.png";
        myPageComentVC.title = @"mypage02_btn03_off.png";
        myPageBookmarkVC.title = @"mypage02_btn04_off.png";
    }else if([vcNum isEqualToString:@"3"]){
        myPagePostVC.title = @"mypage02_btn01_off.png";
        myPageMsgVC.title = @"mypage02_btn02_off.png";
        myPageComentVC.title = @"mypage02_btn03_on.png";
        myPageBookmarkVC.title = @"mypage02_btn04_off.png";
    }else if([vcNum isEqualToString:@"4"]){
        myPagePostVC.title = @"mypage02_btn01_off.png";
        myPageMsgVC.title = @"mypage02_btn02_off.png";
        myPageComentVC.title = @"mypage02_btn03_off.png";
        myPageBookmarkVC.title = @"mypage02_btn04_on.png";
    }
    
    // ContainerView
    float statusHeight = 50;
    float navigationHeight = 0;
    
    YSLContainerViewController2 *containerVC = [[YSLContainerViewController2 alloc]initWithControllers:@[myPagePostVC,myPageMsgVC,myPageComentVC,myPageBookmarkVC]
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
