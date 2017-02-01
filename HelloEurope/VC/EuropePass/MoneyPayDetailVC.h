//
//  MoneyPayDetailVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 21..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoneyPayDetailVC : UIViewController

@property (assign, nonatomic) NSDictionary *moneyDetailDic;
@property (assign, nonatomic) NSString *moneyDetailCheck;

@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *phoneText;
@property (weak, nonatomic) IBOutlet UILabel *emailtext;
@property (weak, nonatomic) IBOutlet UILabel *dateText;
@property (weak, nonatomic) IBOutlet UILabel *keyText;

- (IBAction)backButton:(id)sender;

@end
