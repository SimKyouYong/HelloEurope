//
//  IntroView.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "IntroView.h"
#import "GlobalHeader.h"

@interface IntroView () <UIScrollViewDelegate>
@property (strong, nonatomic)  UIScrollView *scrollView;
@property UIButton *noLoginButton;
@property UIButton *loginButton;
@property UIButton *memberJoinButton;

@end

@implementation IntroView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        self.backgroundColor = [UIColor blackColor];
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.pagingEnabled = YES;
        [self addSubview:self.scrollView];
        
        [self createViewOne];
        [self createViewTwo];
        [self createViewThree];
        [self createViewFour];
        
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width*4, self.scrollView.frame.size.height);
        
        CGPoint scrollPoint = CGPointMake(0, 0);
        [self.scrollView setContentOffset:scrollPoint animated:YES];
    }
    return self;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat pageWidth = CGRectGetWidth(self.bounds);
    CGFloat pageFraction = self.scrollView.contentOffset.x / pageWidth;
}

- (void)createViewOne{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];

    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    imageview.image = [UIImage imageNamed:@"intro01"];
    [view addSubview:imageview];
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
}


- (void)createViewTwo{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME * 1, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    imageview.image = [UIImage imageNamed:@"intro02"];
    [view addSubview:imageview];
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
}

- (void)createViewThree{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME * 2, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    imageview.image = [UIImage imageNamed:@"intro03"];
    [view addSubview:imageview];
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
}

- (void)createViewFour{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME * 3, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    
    UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    imageview.image = [UIImage imageNamed:@"intro04"];
    [view addSubview:imageview];
    
    // 로그인없이 둘러보기(SKY 수정 버튼 없어짐)
    /*
     self.noLoginButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_FRAME - 259)/2, HEIGHT_FRAME - 140, 259, 40)];
     [self.noLoginButton setImage:[UIImage imageNamed:@"intro04_btn01_off"] forState:UIControlStateNormal];
     [self.noLoginButton setImage:[UIImage imageNamed:@"intro04_btn01_on"] forState:UIControlStateHighlighted];
     [self.noLoginButton addTarget:self action:@selector(noLoginAction:) forControlEvents:UIControlEventTouchUpInside];
     [view addSubview:self.noLoginButton];
     */

    // 로그인
    self.loginButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_FRAME - 127)/2 - 80, HEIGHT_FRAME - 100, 127, 40)];
    [self.loginButton setImage:[UIImage imageNamed:@"intro04_btn02_off"] forState:UIControlStateNormal];
    [self.loginButton setImage:[UIImage imageNamed:@"intro04_btn02_on"] forState:UIControlStateHighlighted];
    [self.loginButton addTarget:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.loginButton];
    
    // 회원가입
    self.memberJoinButton = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_FRAME - 127)/2 + 80, HEIGHT_FRAME - 100, 127, 40)];
    [self.memberJoinButton setImage:[UIImage imageNamed:@"intro04_btn03_off"] forState:UIControlStateNormal];
    [self.memberJoinButton setImage:[UIImage imageNamed:@"intro04_btn03_on"] forState:UIControlStateHighlighted];
    [self.memberJoinButton addTarget:self action:@selector(memberJoinAction:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.memberJoinButton];
    
    self.scrollView.delegate = self;
    [self.scrollView addSubview:view];
}

- (void)noLoginAction:(id)sender {
    [self.delegate noLoginButtonPressed];
}

- (void)loginAction:(id)sender {
    [self.delegate loginButtonPressed];
}

- (void)memberJoinAction:(id)sender {
    [self.delegate memberJoinButtonPressed];
}
@end
