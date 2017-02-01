//
//  MyPageComentVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    eComentNone = 0,
    eComentItem
} eElementComentType;

@interface MyPageComentVC : UIViewController<NSXMLParserDelegate>{
    NSMutableArray *comentArr;
    
    NSUserDefaults *defaults;
    
    // XML Parser
    eElementComentType elementType;
    NSXMLParser *xmlParser;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

@property (weak, nonatomic) IBOutlet UITableView *comentTableView;

@end
