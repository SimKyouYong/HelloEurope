//
//  MyPagePointVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ePointNone = 0,
    ePointItem
} eElementPointType;

@interface MyPagePointVC : UIViewController<NSXMLParserDelegate>{
    NSMutableArray *pointArr;
    
    NSUserDefaults *defaults;
    
    // XML Parser
    eElementPointType elementType;
    NSXMLParser *xmlParser;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

@property (weak, nonatomic) IBOutlet UITableView *pointTableView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *pointText;

@end
