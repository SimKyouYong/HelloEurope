//
//  ImagePreviewController.m
//  SmartPaperless
//
//  Created by Joseph on 2014. 6. 19..
//  Copyright (c) 2014년 Joseph. All rights reserved.
//

#import "ImagePreviewController.h"
#import "GlobalHeader.h"
#import <QuartzCore/QuartzCore.h>

#define SHOW_PREVIEW NO

#ifndef CGWidth
#define CGWidth(rect)                   rect.size.width
#endif

#ifndef CGHeight
#define CGHeight(rect)                  rect.size.height
#endif

#ifndef CGOriginX
#define CGOriginX(rect)                 rect.origin.x
#endif

#ifndef CGOriginY
#define CGOriginY(rect)                 rect.origin.y
#endif

@interface ImagePreviewController ()
@end

@implementation ImagePreviewController

@synthesize delegate;
@synthesize imageCropper;
@synthesize preview;
@synthesize previewImage;

- (id)init
{
    self = [super init];
    if (self) {
        boundsText = [[UILabel alloc] initWithFrame:CGRectMake(212, 638, 600, 56)];
        [boundsText setBackgroundColor:[UIColor clearColor]];
        boundsText.textColor = [UIColor colorWithRed:170/ 255.0 green:170 / 255.0 blue:170 / 255.0 alpha:255 / 255];
        boundsText.textAlignment = NSTextAlignmentCenter;
        //titleLabel.font = [UIFont systemFontOfSize:22];
        boundsText.font = [UIFont fontWithName:@"System" size:17.0];
        //[self.view addSubview:boundsText];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"tactile_noise"]];
    self.imageCropper = [[BJImageCropper alloc] initWithImage:previewImage andMaxSize:CGSizeMake(700,700)];//WIDTH_FRAME * 2, HEIGHT_FRAME + 200)];
    [self.view addSubview:self.imageCropper];
    self.imageCropper.center = self.view.center;
    self.imageCropper.imageView.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.imageCropper.imageView.layer.shadowRadius = 3.0f;
    self.imageCropper.imageView.layer.shadowOpacity = 0.8f;
    self.imageCropper.imageView.layer.shadowOffset = CGSizeMake(1, 1);
    
    [self.imageCropper addObserver:self forKeyPath:@"crop" options:NSKeyValueObservingOptionNew context:nil];
    
    if (SHOW_PREVIEW) {
        self.preview = [[UIImageView alloc] initWithFrame:CGRectMake(10,10,self.imageCropper.crop.size.width * 0.1, self.imageCropper.crop.size.height * 0.1)];
        self.preview.image = [self.imageCropper getCroppedImage];
        self.preview.clipsToBounds = YES;
        self.preview.layer.borderColor = [[UIColor whiteColor] CGColor];
        self.preview.layer.borderWidth = 2.0;
        [self.view addSubview:self.preview];
    }
    
    cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelButton setFrame:CGRectMake(10, HEIGHT_FRAME - 40, 40, 40)];
    [cancelButton setBackgroundColor:[UIColor clearColor]];
    [cancelButton addTarget:self action:@selector(cancelPressed:) forControlEvents:UIControlEventTouchUpInside];
    [cancelButton setTitle:@"취소" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:cancelButton];
    
    submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitButton setFrame:CGRectMake(WIDTH_FRAME - 40, HEIGHT_FRAME - 40, 40, 40)];
    [submitButton setBackgroundColor:[UIColor clearColor]];
    [submitButton addTarget:self action:@selector(submitPressed:) forControlEvents:UIControlEventTouchUpInside];
    [submitButton setTitle:@"확인" forState:UIControlStateNormal];
    [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:submitButton];
    
    [self updateDisplay];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self updateDisplay];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)updateDisplay {
    boundsText.text = [NSString stringWithFormat:@"(%f, %f) (%f, %f)", CGOriginX(self.imageCropper.crop), CGOriginY(self.imageCropper.crop), CGWidth(self.imageCropper.crop), CGHeight(self.imageCropper.crop)];
    
    if (SHOW_PREVIEW) {
        self.preview.image = [self.imageCropper getCroppedImage];
        self.preview.frame = CGRectMake(10,10,self.imageCropper.crop.size.width * 0.1, self.imageCropper.crop.size.height * 0.1);
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([object isEqual:self.imageCropper] && [keyPath isEqualToString:@"crop"]) {
        [self updateDisplay];
    }
}

- (void)submitPressed:(UIButton*)sender {
    NSLog(@"%s", __FUNCTION__);

    [delegate setImageToForm:[self.imageCropper getCroppedImage]];
}

- (void)cancelPressed:(UIButton*)sender{
    [delegate setImageCancel:[self.imageCropper getCroppedImage]];
}

@end

