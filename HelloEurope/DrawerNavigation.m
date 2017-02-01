//
//  DrawerNavigation.m
//  TheDayBefore
//
//  Created by Joseph on 2015. 4. 3..
//  Copyright (c) 2015년 Joseph. All rights reserved.
//

#import "DrawerNavigation.h"
#import "DrawerView.h"
#import "MyPageVC.h"
#import "NoticeVC.h"
#import "InfoIntroVC.h"
#import "QuestionVC.h"
#import "LoginVC.h"
#import "SettingVC.h"
#import "Info1VC.h"
#import "Info2VC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

#define SHAWDOW_ALPHA 0.5
#define MENU_DURATION 0.3
#define MENU_TRIGGER_VELOCITY 350

@interface DrawerNavigation ()

@property (nonatomic) BOOL isOpen;
@property (nonatomic) float meunHeight;
@property (nonatomic) float menuWidth;
@property (nonatomic) CGRect outFrame;
@property (nonatomic) CGRect inFrame;
@property (strong, nonatomic) UIView *shawdowView;
@property (strong, nonatomic) DrawerView *drawerView;

@end

@implementation DrawerNavigation

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    [self setUpDrawer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark drawer

- (void)setUpDrawer
{
    self.isOpen = NO;
    
    self.drawerView = [[[NSBundle mainBundle] loadNibNamed:@"DrawerView" owner:self options:nil] objectAtIndex:0];
    
    self.drawerView.delegate = self;
    
    self.meunHeight = self.drawerView.frame.size.height;
    self.menuWidth = self.drawerView.frame.size.width;
    self.outFrame = CGRectMake(-self.menuWidth,50,self.menuWidth,self.meunHeight);
    self.inFrame = CGRectMake (0,50,self.menuWidth,self.meunHeight);
    
    // drawer shawdow and assign its gesture
    self.shawdowView = [[UIView alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, self.view.frame.size.height)]; //self.view.frame];
    self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0];
    self.shawdowView.hidden = YES;
    UITapGestureRecognizer *tapIt = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(tapOnShawdow:)];
    [self.shawdowView addGestureRecognizer:tapIt];
    self.shawdowView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.shawdowView];
    
    // add drawer view
    [self.drawerView setFrame:CGRectMake(-self.menuWidth,50,self.menuWidth,self.meunHeight)];//self.outFrame];
    [self.view addSubview:self.drawerView];
    
    // gesture on self.view
    self.pan_gr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(moveDrawer:)];
    self.pan_gr.maximumNumberOfTouches = 1;
    self.pan_gr.minimumNumberOfTouches = 1;
    //self.pan_gr.delegate = self;
    [self.view addGestureRecognizer:self.pan_gr];
    
    [self.view bringSubviewToFront:self.navigationBar];
}

- (void)drawerToggle
{
    if (!self.isOpen) {
        [self openNavigationDrawer];
    }else{
        [self closeNavigationDrawer];
    }
}

#pragma mark -
#pragma mark open and close action

- (void)openNavigationDrawer{
    if(POINT_CHECK == 1){
        return;
    }
    //    NSLog(@"open x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    self.shawdowView.hidden = NO;
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:SHAWDOW_ALPHA];
                     }
                     completion:nil];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0.1
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = CGRectMake (0,50,self.menuWidth,self.meunHeight);//self.inFrame;
                     }
                     completion:nil];
    
    self.isOpen= YES;
    
    [self.drawerView reloadText];
}

- (void)closeNavigationDrawer{
    if(POINT_CHECK == 1){
        return;
    }
    //    NSLog(@"close x=%f",self.menuView.center.x);
    float duration = MENU_DURATION/self.menuWidth*abs(self.drawerView.center.x)+MENU_DURATION/2; // y=mx+c
    
    // shawdow
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.0f];
                     }
                     completion:^(BOOL finished){
                         self.shawdowView.hidden = YES;
                     }];
    
    // drawer
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         self.drawerView.frame = self.outFrame;
                     }
                     completion:nil];
    self.isOpen= NO;
}

#pragma mark -
#pragma mark Gestures

- (void)tapOnShawdow:(UITapGestureRecognizer *)recognizer {
    [self closeNavigationDrawer];
}

-(void)moveDrawer:(UIPanGestureRecognizer *)recognizer
{
    CGPoint translation = [recognizer translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)recognizer velocityInView:self.view];
    //    NSLog(@"velocity x=%f",velocity.x);
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateBegan) {
        //        NSLog(@"start");
        if ( velocity.x > MENU_TRIGGER_VELOCITY && !self.isOpen) {
            [self openNavigationDrawer];
        }else if (velocity.x < -MENU_TRIGGER_VELOCITY && self.isOpen) {
            [self closeNavigationDrawer];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateChanged) {
        //        NSLog(@"changing");
        float movingx = self.drawerView.center.x + translation.x;
        if ( movingx > -self.menuWidth/2 && movingx < self.menuWidth/2){
            
            self.drawerView.center = CGPointMake(movingx, self.drawerView.center.y);
            [recognizer setTranslation:CGPointMake(0,0) inView:self.view];
            
            float changingAlpha = SHAWDOW_ALPHA/self.menuWidth*movingx+SHAWDOW_ALPHA/2; // y=mx+c
            self.shawdowView.hidden = NO;
            self.shawdowView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:changingAlpha];
        }
    }
    
    if([(UIPanGestureRecognizer*)recognizer state] == UIGestureRecognizerStateEnded) {
        //        NSLog(@"end");
        if (self.drawerView.center.x>0){
            [self openNavigationDrawer];
        }else if (self.drawerView.center.x<0){
            [self closeNavigationDrawer];
        }
    }
}

#pragma mark -
#pragma mark DrawerDelegate

- (void)DrawerSelection:(NSInteger)selectionIndex{
    if(selectionIndex == 0){
        MyPageVC *_myPageVC = [self.storyboard instantiateViewControllerWithIdentifier:@"myPageVC"];
        [self pushViewController:_myPageVC animated:NO];
    }else if(selectionIndex == 3){
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:(@"https://nid.naver.com/nidlogin.login?mode=form&url=http://cafe.naver.com/hellu")]];
    }else if(selectionIndex == 4){
        InfoIntroVC *_infoIntroVC = [self.storyboard instantiateViewControllerWithIdentifier:@"infoIntroVC"];
        [self pushViewController:_infoIntroVC animated:NO];
    }else if(selectionIndex == 5){
        QuestionVC *_questionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"questionVC"];
        [self pushViewController:_questionVC animated:NO];
    }else if(selectionIndex == 6){
        [self displayComposerSheet:6];
    }else if(selectionIndex == 7){
        [self displayComposerSheet:7];
    }else if(selectionIndex == 8){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"" message:@"로그아웃 하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {
                                 LoginVC *_loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
                                 [self pushViewController:_loginVC animated:NO];
                             }];
        [alert addAction:cancel];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else if(selectionIndex == 9){
        SettingVC *_settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"settingVC"];
        [self pushViewController:_settingVC animated:NO];
    }else if(selectionIndex == 10){
        Info1VC *_info1VC = [self.storyboard instantiateViewControllerWithIdentifier:@"info1VC"];
        [self pushViewController:_info1VC animated:NO];
    }else if(selectionIndex == 11){
        Info2VC *_info2VC = [self.storyboard instantiateViewControllerWithIdentifier:@"info2VC"];
        [self pushViewController:_info2VC animated:NO];
    }
    [self closeNavigationDrawer];
}

#pragma mark -
#pragma mark push & pop

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    [super pushViewController:viewController animated:animated];
    
    // disable gesture in next vc
    [self.pan_gr setEnabled:NO];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *vc = [super popViewControllerAnimated:animated];
    
    // enable gesture in root vc
    if ([self.viewControllers count]==1){
        [self.pan_gr setEnabled:YES];
    }
    return vc;
}

#pragma mark -
#pragma mark Mail Method

- (void)displayComposerSheet:(NSInteger)index
{
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
        // 델리게이트 지정
        picker.mailComposeDelegate = self;
        
        // 제목
        if(index == 6){
            [picker setSubject:@"[1:1문의]문의 드립니다."];
        }else{
            [picker setSubject:@"[광고/제휴 문의]광고/제휴 문의 드립니다."];
        }
        
        // 수신자
        NSArray *toRecipients = [NSArray arrayWithObject:@"intavola@naver.com"];
        
        // 참조
        //NSArray *ccRecipients = [NSArray arrayWithObjects:@"second@example.com", @"third@example.com", nil];
        //NSArray *bccRecipients = [NSArray arrayWithObject:@"fourth@example.com"];
        
        [picker setToRecipients:toRecipients];
        //[picker setCcRecipients:ccRecipients];
        //[picker setBccRecipients:bccRecipients];
        
        // 이미지
        //NSString *path = [[NSBundle mainBundle] pathForResource:@"rainy" ofType:@"png"];
        //NSData *myData = [NSData dataWithContentsOfFile:path];
        //[picker addAttachmentData:myData mimeType:@"image/png" fileName:@"rainy"];
        
        // 내용
        NSString *emailBody = @"";
        [picker setMessageBody:emailBody isHTML:NO];
        
        // 뷰 호출
        [self presentViewController:picker animated:YES completion:nil];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"메일 계정이 없습니다."
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
        [alert show];
    }
}


// 델리게이트
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    // 결과 값에 따른 상태 활용
    switch (result)
    {
            // 취소
        case MFMailComposeResultCancelled:
            //message.text = @"Result: canceled";
            break;
            // 저장
        case MFMailComposeResultSaved:
            //message.text = @"Result: saved";
            break;
            // 보내기
        case MFMailComposeResultSent:
            //message.text = @"Result: sent";
            break;
            // 실패
        case MFMailComposeResultFailed:
            //message.text = @"Result: failed";
            break;
        default:
            //message.text = @"Result: not sent";
            break;
    }
    // 메일 보내기 창 닫기
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
