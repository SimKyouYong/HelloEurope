//
//  LoginVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "LoginVC.h"
#import "GlobalHeader.h"
#import "DrawerNavigation.h"
#import "PasswordSearchVC.h"
#import "MemberAgreeVC.h"
#import "MainVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@interface LoginVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation LoginVC

@synthesize loginScrollView;
@synthesize idText;
@synthesize pwText;
@synthesize loginRememberButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    if([[defaults stringForKey:REMEMBER_IDPW_SAVE] isEqualToString:@"YES"]){
        idText.text = [defaults stringForKey:KEY_USER_ID];
        pwText.text = [defaults stringForKey:KEY_USER_PW];
        loginRememberButton.selected = 1;
    }else{
        loginRememberButton.selected = 0;
    }
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if(WIDTH_FRAME == 320){
        if(HEIGHT_FRAME == 480){
            [loginScrollView setContentSize:CGSizeMake(275, 480)];
        }else{
            loginScrollView.scrollEnabled = NO;
        }
    }else{
        loginScrollView.scrollEnabled = NO;
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)loginRememberButton:(id)sender {
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [defaults setObject:@"YES" forKey:REMEMBER_IDPW_SAVE];
    }else{
        [defaults setObject:@"NO" forKey:REMEMBER_IDPW_SAVE];
    }
}

- (IBAction)loginButton:(id)sender {
    if(idText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"아이디를 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];

        return;
    }
    if(pwText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"비밀번호를 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, LOGIN_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"e_id=%@&e_pw=%@", idText.text, pwText.text];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            if([resultValue isEqualToString:@"false"]){
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"로그인에 실패하였습니다.\n아이디와 비밀번호를 다시 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }else{
                NSArray *arrString= [resultValue componentsSeparatedByString: @","];
                //NSLog(@"%@", resultValue);
                [defaults setObject:[arrString objectAtIndex:0] forKey:KEY_INDEX];
                [defaults setObject:[arrString objectAtIndex:1] forKey:KEY_NAME];
                [defaults setObject:[arrString objectAtIndex:2] forKey:KEY_USER_ID];
                [defaults setObject:[arrString objectAtIndex:3] forKey:KEY_USER_PW];
                [defaults setObject:[arrString objectAtIndex:4] forKey:KEY_USER_EMAIL];
                [defaults setObject:[arrString objectAtIndex:5] forKey:KEY_USER_PHONE];
                [defaults setObject:[arrString objectAtIndex:6] forKey:KEY_USER_BIRTH];
                [defaults setObject:[arrString objectAtIndex:7] forKey:DEVICE_TOKEN];
                [defaults setObject:[arrString objectAtIndex:8] forKey:KEY_CHOO];           // 북마크
                [defaults setObject:[arrString objectAtIndex:9] forKey:KEY_MY_EA];          // 포스트
                [defaults setObject:[arrString objectAtIndex:10] forKey:KEY_LEVEL];         // 포인트
                [defaults setObject:[arrString objectAtIndex:11] forKey:KEY_IMAGE];         // 이미지
                
                LOGIN_CHECK = 1;
                MainVC *_mainVC = [self.storyboard instantiateViewControllerWithIdentifier:@"mainVC"];
                [self.rootNav pushViewController:_mainVC animated:NO];
            }
            
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"로그인에 실패하였습니다.\n아이디와 비밀번호를 다시 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }];
    [dataTask resume];
}

- (IBAction)memberJoinButton:(id)sender {
    MemberAgreeVC *_memberAgreeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"memberAgreeVC"];
    [self.rootNav pushViewController:_memberAgreeVC animated:YES];
}

- (IBAction)passForgetButton:(id)sender {
    PasswordSearchVC *_passwordSearchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"passwordSearchVC"];
    [self.rootNav pushViewController:_passwordSearchVC animated:YES];
}

#pragma mark -
#pragma mark TextField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSInteger textY = 0;
    if(textField == idText){
        textY = -50;
    }else if(textField == pwText){
        textY = -100;
    }
    if(WIDTH_FRAME == 414){
        textY = 0;
    }
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                  textY,
                                  self.view.frame.size.width,
                                  self.view.frame.size.height);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
