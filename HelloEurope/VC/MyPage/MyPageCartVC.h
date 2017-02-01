//
//  MyPageCartVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    eCartNone = 0,
    eCartItem
} eElementCartType;

@interface MyPageCartVC : UIViewController<NSXMLParserDelegate>{
    NSMutableArray *cartArr;
    
    NSUserDefaults *defaults;
    
    // XML Parser
    eElementCartType elementType;
    NSXMLParser *xmlParser;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

@property (weak, nonatomic) IBOutlet UITableView *cartTableView;

@end