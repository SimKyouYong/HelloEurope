//
//  PasswordSearchVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 6..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "PasswordSearchVC.h"
#import "GlobalHeader.h"
#import "DrawerNavigation.h"

@interface PasswordSearchVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation PasswordSearchVC

@synthesize emailText;

- (void)viewDidLoad {
    [super viewDidLoad];
emailText.text = @"snap0425@gmail.com";
    self.rootNav = (DrawerNavigation *)self.navigationController;
}

- (IBAction)emailButton:(id)sender {
    if(emailText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"e-mail 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, PW_SEARCH_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"email=%@", emailText.text];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest
                                                       completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                           NSLog(@"Response:%@ //%@\n", response, error);
                                                           if(error == nil)
                                                           {
                                                               NSLog(@"Data = %@",data);

                                                               NSString *resultValue = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                               NSLog(@"Data = %@",resultValue);
                                                               if([resultValue isEqualToString:@"false"]){
                                                                   UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"e-mail 다시 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
                                                                   UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                                        {}];
                                                                   [alert addAction:ok];
                                                                   [self presentViewController:alert animated:YES completion:nil];
                                                               }
                                                               if([resultValue isEqualToString:@"true"]){
                                                                   UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"가입된 메일로 비밀번호를 보냈습니다." preferredStyle:UIAlertControllerStyleAlert];
                                                                   UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                                        {
                                                                                            [self.rootNav popViewControllerAnimated:YES];
                                                                                        }];
                                                                   [alert addAction:ok];
                                                                   [self presentViewController:alert animated:YES completion:nil];
                                                               }
                                                           }
                                                       }];
    [dataTask resume];
}

- (IBAction)backButton:(id)sender {
    [self.rootNav popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark TextField

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
