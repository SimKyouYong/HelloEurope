//
//  MemberJoinVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberJoinVC : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *memberJoinScrollView;

@property (weak, nonatomic) IBOutlet UIView *joinView;

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *idText;
@property (weak, nonatomic) IBOutlet UITextField *pwText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *birthText;

- (IBAction)joinButton:(id)sender;
- (IBAction)Button:(id)sender;
- (IBAction)backButton:(id)sender;

@end
