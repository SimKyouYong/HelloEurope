//
//  MainVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 16..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopupView.h"

typedef enum {
    eADNone = 0,
    eADItem
} eADElementType;

@interface MainVC : UIViewController<UIActionSheetDelegate, NSXMLParserDelegate>{
    NSInteger loginCheck;
    
    PopupView *popupView;
    
    UIView *bottomTodayCheck;
    UIButton *checkButton;
    NSString *todayStr;
    
    NSUserDefaults *defaults;
    
    UIView *bottomAdView;
    UIImageView *bottomBgView;
    UIButton *bottomButton;
    
    // XML Parser
    eADElementType elementType;
    NSXMLParser *xmlParser;
    NSMutableArray *xmlArrData;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    NSInteger xmlIndex;
}

- (IBAction)menuAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *sortButton;
- (IBAction)sortButton:(id)sender;

@end
