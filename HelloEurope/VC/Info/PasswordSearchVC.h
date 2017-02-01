//
//  PasswordSearchVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 6..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PasswordSearchVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *emailText;

- (IBAction)emailButton:(id)sender;
- (IBAction)backButton:(id)sender;

@end
