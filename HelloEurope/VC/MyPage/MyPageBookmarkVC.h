//
//  MyPageBookmarkVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    eBookmarkNone = 0,
    eBookmarkItem
} eElementBookmarkType;

@interface MyPageBookmarkVC : UIViewController<NSXMLParserDelegate>{
    NSMutableArray *bookmarkArr;
    
    NSUserDefaults *defaults;
    
    // XML Parser
    eElementBookmarkType elementType;
    NSXMLParser *xmlParser;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

@property (weak, nonatomic) IBOutlet UITableView *bookmarkTableView;

@end
