//
//  LoginVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginVC : UIViewController{
    NSUserDefaults *defaults;
}

@property (weak, nonatomic) IBOutlet UIScrollView *loginScrollView;
@property (weak, nonatomic) IBOutlet UITextField *idText;
@property (weak, nonatomic) IBOutlet UITextField *pwText;
@property (weak, nonatomic) IBOutlet UIButton *loginRememberButton;

- (IBAction)loginRememberButton:(id)sender;
- (IBAction)loginButton:(id)sender;
- (IBAction)memberJoinButton:(id)sender;
- (IBAction)passForgetButton:(id)sender;

@end
