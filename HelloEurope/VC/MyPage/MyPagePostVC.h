//
//  MyPagePostVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ePostNone = 0,
    ePostItem
} eElementPostType;

@interface MyPagePostVC : UIViewController<NSXMLParserDelegate>{
    NSMutableArray *postArr;
    
    NSUserDefaults *defaults;
    
    // XML Parser
    eElementPostType elementType;
    NSXMLParser *xmlParser;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

@property (weak, nonatomic) IBOutlet UITableView *postTableView;

@end
