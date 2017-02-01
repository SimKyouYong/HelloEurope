//
//  MoneyPayDetailVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 21..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MoneyPayDetailVC.h"

@interface MoneyPayDetailVC ()

@end

@implementation MoneyPayDetailVC

@synthesize moneyDetailDic;
@synthesize moneyDetailCheck;

@synthesize nameText;
@synthesize phoneText;
@synthesize emailtext;
@synthesize dateText;
@synthesize keyText;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    nameText.text = [moneyDetailDic objectForKey:@"user_id"];
    phoneText.text = [moneyDetailDic objectForKey:@"user_phone"];
    emailtext.text = [moneyDetailDic objectForKey:@"user_email"];
    dateText.text = [moneyDetailDic objectForKey:@"user_date"];
    keyText.text = [moneyDetailDic objectForKey:@"key"];
    
    if([moneyDetailCheck isEqualToString:@"1"]){
        nameText.text = [moneyDetailDic objectForKey:@"USER_NAME"];
        phoneText.text = [moneyDetailDic objectForKey:@"USER_PHONE"];
        emailtext.text = [moneyDetailDic objectForKey:@"USER_EMAIL"];
        dateText.text = [moneyDetailDic objectForKey:@"USER_DATE"];
        keyText.text = [moneyDetailDic objectForKey:@"USER_KEY"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
