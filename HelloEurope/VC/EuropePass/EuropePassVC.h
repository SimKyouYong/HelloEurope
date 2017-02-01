//
//  EuropePassVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"

@protocol europePassDelegate <NSObject>
@required
- (void)europePassAdHidden;
@end

typedef enum {
    eNone = 0,
    eItem
} eElementTypeeuroPass;

@interface EuropePassVC : UIViewController<NSXMLParserDelegate, UIGridViewDelegate>{
    NSString *tagStr;
    
    // XML Parser
    eElementTypeeuroPass elementType;
    NSXMLParser *xmlParser;
    NSMutableArray *xmlArrData;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    
    NSInteger tableRow;
    NSInteger tableX;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    
    UIButton *topBtn1;
    UIButton *topBtn2;
    UIButton *topBtn3;
    UIButton *topBtn4;
}

@property (weak, nonatomic) IBOutlet UIView *topView;

@property (weak, nonatomic) IBOutlet UIGridView *europeTable;

@property (nonatomic, weak) id <europePassDelegate> delegate;

@end
