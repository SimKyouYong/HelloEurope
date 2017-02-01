//
//  Drawer.h
//  CCKFNavDrawer
//
//  Created by calvin on 2/2/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>

@protocol DrawerDelegate <NSObject>
@required
- (void)DrawerSelection:(NSInteger)selectionIndex;
@end

@interface DrawerView : UIView<UIActionSheetDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver, UIScrollViewDelegate>{
    UIView *pointView;
    
    UIButton *payBtn1;
    UIButton *payBtn2;
    UIButton *payBtn3;
    UIButton *payBtn4;
    UIButton *payBtn5;
    UIButton *payBtn6;
    UIButton *payBtn7;
    
    UIButton *payEmptyBtn1;
    UIButton *payEmptyBtn2;
    UIButton *payEmptyBtn3;
    UIButton *payEmptyBtn4;
    UIButton *payEmptyBtn5;
    UIButton *payEmptyBtn6;
    UIButton *payEmptyBtn7;
    
    NSString *pointValue;
    NSString *pointName;
    
    NSUserDefaults *defaults;
    
    NSString *inappBundelId;
    
    UIActivityIndicatorView *activityView;
    UIView *loadingView;
}

- (void)reloadText;
@property (weak, nonatomic) IBOutlet UIScrollView *menuScrollView;

@property (weak, nonatomic) IBOutlet UIView *popupView;

@property (weak, nonatomic)id<DrawerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *idText;
@property (weak, nonatomic) IBOutlet UILabel *nameText;
@property (weak, nonatomic) IBOutlet UILabel *comentText;
@property (weak, nonatomic) IBOutlet UILabel *postText;
@property (weak, nonatomic) IBOutlet UILabel *bookmarkText;
@property (weak, nonatomic) IBOutlet UILabel *pointText;

- (IBAction)myPageButton:(id)sender;
- (IBAction)pointButton:(id)sender;

- (IBAction)introduceButton:(id)sender;

- (IBAction)oneoneButton:(id)sender;
- (IBAction)adQButton:(id)sender;
- (IBAction)logoutButton:(id)sender;
- (IBAction)settingButton:(id)sender;
- (IBAction)bottomButton1:(id)sender;
- (IBAction)bottomButton2:(id)sender;

@end
