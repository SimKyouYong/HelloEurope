//
//  HelloTalkListVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TalkListView1.h"
#import "TalkListView2.h"
#import "TalkListView3.h"
#import "TalkListView4.h"
#import "TalkListView5.h"
#import "TalkListView6.h"
#import "TalkListView7.h"

typedef enum {
    etNone = 0,
    etItem
} eElementType;

@interface HelloTalkListVC : UIViewController<UIScrollViewDelegate, NSXMLParserDelegate, talkListView1Delegate, talkListView2Delegate, talkListView3Delegate, talkListView4Delegate, talkListView5Delegate, talkListView6Delegate, talkListView7Delegate, UIActionSheetDelegate>{
    TalkListView1 *talkListView1;
    TalkListView2 *talkListView2;
    TalkListView3 *talkListView3;
    TalkListView4 *talkListView4;
    TalkListView5 *talkListView5;
    TalkListView6 *talkListView6;
    TalkListView7 *talkListView7;
    
    NSMutableArray *controllers;
    
    NSString *topName;
    
    NSUserDefaults *defaults;
    
    NSInteger topNum;
    
    // XML Parser
    eElementType elementType;
    NSXMLParser *xmlParser;
    NSMutableArray *xmlArrData;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    NSInteger xmlIndex;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

@property (assign, nonatomic) NSString *countryStr;

@property (weak, nonatomic) IBOutlet UIScrollView *talkScrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *talkPageControl;

@property (weak, nonatomic) IBOutlet UIView *popupView;

@property (weak, nonatomic) IBOutlet UIButton *topButton1;
@property (weak, nonatomic) IBOutlet UIButton *topButton2;
@property (weak, nonatomic) IBOutlet UIButton *topButton3;
@property (weak, nonatomic) IBOutlet UIButton *topButton4;
@property (weak, nonatomic) IBOutlet UIButton *topButton5;
@property (weak, nonatomic) IBOutlet UIButton *topButton6;
@property (weak, nonatomic) IBOutlet UIButton *topButton7;

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

- (IBAction)backButton:(id)sender;
- (IBAction)topButton1:(id)sender;
- (IBAction)topButton2:(id)sender;
- (IBAction)topButton3:(id)sender;
- (IBAction)topButton4:(id)sender;
- (IBAction)topButton5:(id)sender;
- (IBAction)topButton6:(id)sender;
- (IBAction)topButton7:(id)sender;
- (IBAction)writeButton:(id)sender;
- (IBAction)sortButton:(id)sender;
- (IBAction)searchButton:(id)sender;

@end
