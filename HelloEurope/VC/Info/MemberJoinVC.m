//
//  MemberJoinVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MemberJoinVC.h"
#import "GlobalHeader.h"
#import "DrawerNavigation.h"
#import "LoginVC.h"

@interface MemberJoinVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation MemberJoinVC

@synthesize memberJoinScrollView;
@synthesize joinView;
@synthesize nameText;
@synthesize idText;
@synthesize pwText;
@synthesize emailText;
@synthesize phoneText;
@synthesize birthText;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if(WIDTH_FRAME == 320){
        if(HEIGHT_FRAME == 480){
            [memberJoinScrollView setContentSize:CGSizeMake(275, 400)];
        }else{
            memberJoinScrollView.scrollEnabled = NO;
        }
    }else{
        memberJoinScrollView.scrollEnabled = NO;
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)Button:(id)sender{
    [nameText resignFirstResponder];
    [idText resignFirstResponder];
    [pwText resignFirstResponder];
    [emailText resignFirstResponder];
    [phoneText resignFirstResponder];
    [birthText resignFirstResponder];
}

- (IBAction)backButton:(id)sender {
    [self.rootNav popViewControllerAnimated:YES];
}

- (IBAction)joinButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    if(nameText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"이름을 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
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
    if(emailText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"e-mail 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    if(phoneText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"전화번호를 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    /*
    if(birthText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"생년월일을 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
     */
    birthText.text = @"";
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, MEMBERJOIN_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"e_name=%@&e_id=%@&e_pw=%@&e_email=%@&e_phone=%@&e_birth=%@&reg_id=%@", nameText.text, idText.text, pwText.text, emailText.text, phoneText.text, birthText.text, [defaults stringForKey:DEVICE_TOKEN]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        if(error == nil){
            NSString *resultValue = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            NSLog(@"Data = %@",resultValue);
            if([resultValue isEqualToString:@"false"]){
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"회원가입에 실패하였습니다." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
            if([resultValue isEqualToString:@"true"]){
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"회원가입에 성공하였습니다." preferredStyle:UIAlertControllerStyleAlert];
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {
                                         LoginVC *_loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
                                         [self.rootNav pushViewController:_loginVC animated:NO];
                                     }];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }];
    [dataTask resume];
}

#pragma mark -
#pragma mark TextField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSInteger textY = 0;
    if(textField == nameText){
        textY = 0;
    }else if(textField == idText){
        textY = 0;
    }else if(textField == pwText){
        textY = -50;
    }else if(textField == emailText){
        textY = -100;
    }else if(textField == phoneText){
        textY = -150;
    }else if(textField == birthText){
        textY = -200;
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
