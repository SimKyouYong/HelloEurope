//
//  ImagePreviewController.h
//  SmartPaperless
//
//  Created by Joseph on 2014. 6. 19..
//  Copyright (c) 2014년 Joseph. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "BJImageCropper.h"

@protocol ImagePreviewViewControllerDelegate <NSObject>

@required
- (void)setImageToForm:(UIImage *)cropImage;
- (void)setImageCancel:(UIImage *)cropImage;
@end

// 사진 촬영 후에 미리보기를 통해 사용할 영역을 CROP하는 화면 
@interface ImagePreviewController : UIViewController{
    BJImageCropper *imageCropper;
    UILabel *boundsText;

    UIButton *cancelButton;
    UIButton *submitButton;
}

@property (strong, nonatomic) id<ImagePreviewViewControllerDelegate> delegate;
@property (nonatomic, strong) BJImageCropper *imageCropper;
@property (nonatomic, strong) UIImageView *preview;
@property (nonatomic, strong) UIImage *previewImage;

@end

