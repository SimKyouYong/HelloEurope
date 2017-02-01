//
//  HelloTalkDetailVC.h
//  HelloEurope
//
//  Created by Joseph on 2016. 5. 1..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePreviewController.h"

typedef enum {
    eDetailNone = 0,
    eItem
} eElementTypeDetail;

@interface HelloTalkDetailVC : UIViewController<UIScrollViewDelegate, NSXMLParserDelegate, UITableViewDelegate, UITableViewDataSource, NSURLConnectionDataDelegate, ImagePreviewViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UIActionSheetDelegate>{
    UIImageView *thumbImage[10];
    
    NSInteger imagePageCount;
    NSInteger topImagePageCount;
    CGFloat labelHeight;
    NSInteger textHeight;
    
    UIImageView *iconImage;
    UILabel *nameText;
    UILabel *timeText;
    UILabel *tagText;
    UILabel *titleText;
    UIButton *editButton;
    UIScrollView *topImageScrollView;
    NSMutableArray *topControllers;
    UIPageControl *topImagePageControl;
    UIScrollView *imageScrollView;
    NSMutableArray *controllers;
    UIPageControl *imagePageControl;
    UILabel *contentText;
    UIImageView *comentImage;
    UIImageView *likeImage;
    UILabel *comentCountText;
    UILabel *likeCount;
    UITableView *comentTableView;
    
    // XML Parser
    eElementTypeDetail elementType;
    NSXMLParser *xmlParser;
    NSMutableArray *xmlArrData;
    NSMutableDictionary *xmlDic;
    NSMutableString *foundValue;
    NSString *currentElement;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
    
    NSData *comentData;
    NSString *comentFileName;
    NSString *comentFilePath;
    UIImageView *comentImageView;
    
    NSInteger emptyNum;
    
    NSMutableDictionary *editDetailDic;
}

@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;
@property (weak, nonatomic) IBOutlet UITextField *comentText;
@property (weak, nonatomic) IBOutlet UIView *popupView;

@property (assign, nonatomic) NSMutableDictionary *detailDic;
@property (assign, nonatomic) NSInteger topNumber;
@property (assign, nonatomic) NSString *countryStr;
@property (assign, nonatomic) NSString *titleBg;

@property (weak, nonatomic) IBOutlet UIImageView *titlMenuImage;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

- (IBAction)backButton:(id)sender;
- (IBAction)photoButton:(id)sender;
- (IBAction)sendButton:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *photoView;
@property (weak, nonatomic) IBOutlet UIImageView *photoImage;
- (IBAction)photoViewClose:(id)sender;

@end
