//
//  HelloTalkListWriteVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 28..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePreviewController.h"
#import "ELCImagePickerHeader.h"

@protocol HelloTalkEditDelegate <NSObject>

@required
- (void)editSend:(NSMutableDictionary*)editDic;
@end

typedef enum {
    eEditNone = 0,
    eEditItem
} eEditElementType;

@interface HelloTalkListWriteVC : UIViewController<ImagePreviewViewControllerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLConnectionDataDelegate, NSXMLParserDelegate, UIActionSheetDelegate, ELCImagePickerControllerDelegate>{
    NSString *imageName[10];
    UIImageView *thumbImage[10];
    NSArray *photoArr;
    NSInteger photoArrNum;
    
    NSMutableArray *controllers1;
    UIPageControl *writePageControl1;
    NSMutableArray *controllers2;
    UIPageControl *writePageControl2;
    NSMutableArray *controllers3;
    UIPageControl *writePageControl3;
    NSMutableArray *controllers4;
    UIPageControl *writePageControl4;
    NSMutableArray *controllers5;
    UIPageControl *writePageControl5;
    
    NSString *topName;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    
    NSInteger editImageSaveCheck;
    
    // XML Parser Edit
    eEditElementType elementType;
    NSXMLParser *xmlParser;
    NSMutableArray *xmlArrData;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    NSInteger xmlIndex;
}

@property (assign, nonatomic) id<HelloTalkEditDelegate> delegate;

@property (assign, nonatomic) NSInteger topNumber;
@property (assign, nonatomic) NSString *countryStr;
@property (assign, nonatomic) NSString *editStr;
@property (assign, nonatomic) NSMutableDictionary *editDic;

- (IBAction)backButton:(id)sender;
- (IBAction)uploadButton:(id)sender;
- (IBAction)photoButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *talkWriteView1;
@property (weak, nonatomic) IBOutlet UILabel *talkNameView1;
- (IBAction)talkNameButtonView1:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *cityTextView1;
@property (weak, nonatomic) IBOutlet UITextField *titleTextView1;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView1;
@property (weak, nonatomic) IBOutlet UIScrollView *talkWriteScrollView1;

@property (weak, nonatomic) IBOutlet UIView *talkWriteView2;
- (IBAction)talkNameButtonView2:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *cityTextView2;
@property (weak, nonatomic) IBOutlet UITextField *titleTextView2;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView2;
@property (weak, nonatomic) IBOutlet UILabel *dateText;
@property (weak, nonatomic) IBOutlet UILabel *timeText;
- (IBAction)dateButton:(id)sender;
- (IBAction)timeButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *meetText;
@property (weak, nonatomic) IBOutlet UITextField *memoText;
@property (weak, nonatomic) IBOutlet UIScrollView *talkWriteScrollView2;

@property (weak, nonatomic) IBOutlet UIView *talkWriteView3;
- (IBAction)talkNameButtonView3:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *cityTextView3;
@property (weak, nonatomic) IBOutlet UITextField *titleTextView3;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView3;
@property (weak, nonatomic) IBOutlet UITextField *foodAddText;
@property (weak, nonatomic) IBOutlet UITextField *foodTourCompnayText;
@property (weak, nonatomic) IBOutlet UITextField *foodTourNameText;
@property (weak, nonatomic) IBOutlet UITextField *foodPriceText;
@property (weak, nonatomic) IBOutlet UIScrollView *talkWriteScrollView3;

@property (weak, nonatomic) IBOutlet UIView *talkWriteView4;
- (IBAction)talkNameButtonView4:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *cityTextView4;
@property (weak, nonatomic) IBOutlet UITextField *titleTextView4;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView4;
@property (weak, nonatomic) IBOutlet UITextField *tourCompnayText;
@property (weak, nonatomic) IBOutlet UITextField *tourNameText;
@property (weak, nonatomic) IBOutlet UITextField *tourPriceText;
@property (weak, nonatomic) IBOutlet UIScrollView *talkWriteScrollView4;

@property (weak, nonatomic) IBOutlet UIView *talkWriteView5;
- (IBAction)talkNameButtonView5:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *cityTextView5;
@property (weak, nonatomic) IBOutlet UITextField *titleTextView5;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView5;
@property (weak, nonatomic) IBOutlet UITextField *sleepNameText;
@property (weak, nonatomic) IBOutlet UITextField *addText;
@property (weak, nonatomic) IBOutlet UITextField *menuText;
@property (weak, nonatomic) IBOutlet UIScrollView *talkWriteScrollView5;

@property (weak, nonatomic) IBOutlet UIView *popupView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIView *datePickerBarView;
- (IBAction)datePickerDone:(id)sender;
- (IBAction)datePickerBarDoneButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIView *timePickerBarView;
- (IBAction)timePickerDone:(id)sender;
- (IBAction)timePickerBarDoneButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *writePopupView;

@end
