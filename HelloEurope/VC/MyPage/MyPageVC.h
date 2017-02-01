//
//  MyPageVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 17..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImagePreviewController.h"

@interface MyPageVC : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, ImagePreviewViewControllerDelegate>{
    NSUserDefaults *defaults;
    
    NSString *imgName;
}

@property (weak, nonatomic) IBOutlet UIScrollView *myPageScrollView;
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameText;

- (IBAction)backButton:(id)sender;

- (IBAction)myPostButton:(id)sender;
- (IBAction)msgAlarmButton:(id)sender;
- (IBAction)comentAlarmButton:(id)sender;

- (IBAction)cartButton:(id)sender;
- (IBAction)payButton:(id)sender;
- (IBAction)bookMarkButton:(id)sender;
- (IBAction)pointButton:(id)sender;

- (IBAction)cameraButton:(id)sender;

@end
