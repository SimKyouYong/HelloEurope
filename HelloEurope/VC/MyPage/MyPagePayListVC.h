//
//  MyPagePayListVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ePayNone = 0,
    ePayItem
} eElementPayType;

@interface MyPagePayListVC : UIViewController<NSXMLParserDelegate>{
    NSMutableArray *payArr;
    
    NSUserDefaults *defaults;
    
    // XML Parser
    eElementPayType elementType;
    NSXMLParser *xmlParser;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

@property (weak, nonatomic) IBOutlet UITableView *payTableView;

@end
