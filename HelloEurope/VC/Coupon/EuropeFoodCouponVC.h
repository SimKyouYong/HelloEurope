//
//  EuropeFoodCouponVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol europeFoodDelegate <NSObject>
@required
- (void)europeFoodAdHidden;
@end

typedef enum {
    foodNone = 0,
    foodItem
} eElementTypeeuroFood;

@interface EuropeFoodCouponVC : UIViewController<NSXMLParserDelegate>{
    UIButton *topButton1;
    UIButton *topButton2;
    UIButton *topButton3;
    
    NSString *tagStr;
    
    // XML Parser
    eElementTypeeuroFood elementType;
    NSXMLParser *xmlParser;
    NSMutableArray *xmlArrData;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    
    NSMutableArray *tableListArr;
}

@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UITableView *europeFoodTableView;

@property (nonatomic, weak) id <europeFoodDelegate> delegate;

@end
