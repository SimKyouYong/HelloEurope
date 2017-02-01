//
//  MemberAgreeVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberAgreeVC : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView1;
@property (weak, nonatomic) IBOutlet UITextView *textView2;

- (IBAction)submitButton:(id)sender;
- (IBAction)cancelButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *agreeCheck1;
- (IBAction)agreeCheck1:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *agreeCheck2;
- (IBAction)agreeCheck2:(id)sender;

- (IBAction)backButton:(id)sender;

@end
