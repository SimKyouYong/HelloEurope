//
//  HelloTalkSearchVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 10. 12..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    eSearchNone = 0,
    eSearchItem
} eSearchElementType;

@interface HelloTalkSearchVC : UIViewController<NSXMLParserDelegate>{
    // XML Parser Edit
    eSearchElementType elementType;
    NSXMLParser *xmlParser;
    NSMutableArray *xmlArrData;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    NSInteger xmlIndex;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

@property (weak, nonatomic) IBOutlet UITableView *searchTable;
@property (weak, nonatomic) IBOutlet UITextField *searchText;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property (assign, nonatomic) NSString *searchCountryStr;
@property (assign, nonatomic) NSInteger searchTopNumber;

- (IBAction)searchButton:(id)sender;
- (IBAction)backButton:(id)sender;

@end
