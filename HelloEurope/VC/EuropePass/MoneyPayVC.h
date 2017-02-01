//
//  MoneyPayVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 21..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    eNone = 0,
    eItem
} eElementTypePay;

@interface MoneyPayVC : UIViewController<NSXMLParserDelegate>{
    // XML Parser
    eElementTypePay elementType;
    NSXMLParser *xmlParser;
    NSMutableArray *xmlArrData;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
}

@property (assign, nonatomic) NSDictionary *moneyDic;
@property (assign, nonatomic) NSString *passCouponStr;

@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UITextField *dateText;

@property (weak, nonatomic) IBOutlet UIDatePicker *pickerView;
@property (weak, nonatomic) IBOutlet UIView *pickerBarView;
- (IBAction)pickerDone:(id)sender;
- (IBAction)picker:(id)sender;

- (IBAction)dateButton:(id)sender;
- (IBAction)payButton:(id)sender;

- (IBAction)backButton:(id)sender;

@end
