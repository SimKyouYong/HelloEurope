//
//  MyPageVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 17..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPageVC.h"
#import "DrawerNavigation.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "MyPagePostVC.h"
#import "MyPageComentVC.h"
#import "MyPageBookmarkVC.h"
#import "MyPageCartVC.h"
#import "MyPagePayListVC.h"
#import "MyPagePointVC.h"
#import "UIView+Toast.h"
#import "ImagePreviewController.h"
#import "MyPageChoose1.h"
#import "MyPageChoose2.h"

@interface MyPageVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation MyPageVC

@synthesize myPageScrollView;
@synthesize profileImage;
@synthesize nameText;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/MY_IMG/%@", [defaults stringForKey:KEY_IMAGE]]]];
    profileImage.clipsToBounds = YES;
    profileImage.layer.cornerRadius = 32.0;
    profileImage.layer.masksToBounds = YES;
    profileImage.image = [UIImage imageWithData:imageData];
    if([defaults stringForKey:KEY_IMAGE].length == 0){
        profileImage.image = [UIImage imageNamed:@"mypage01_icon.png"];
    }
    
    nameText.text = [defaults stringForKey:KEY_NAME];
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    
    if(WIDTH_FRAME == 320){
        if(HEIGHT_FRAME == 480){
            [myPageScrollView setContentSize:CGSizeMake(WIDTH_FRAME - 20, 240)];
        }else{
            myPageScrollView.scrollEnabled = NO;
        }
    }else{
        myPageScrollView.scrollEnabled = NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Button Action

- (IBAction)backButton:(id)sender {
    [self.rootNav popViewControllerAnimated:NO];
}

- (IBAction)myPostButton:(id)sender {
    MyPageChoose1 *_myPageChoose1 = [self.storyboard instantiateViewControllerWithIdentifier:@"_myPageChoose1"];
    _myPageChoose1.vcNum = @"1";
    [self.navigationController pushViewController:_myPageChoose1 animated:YES];
}

- (IBAction)msgAlarmButton:(id)sender {
    //[self.navigationController.view makeToast:@"준비중입니다."];
    MyPageChoose1 *_myPageChoose1 = [self.storyboard instantiateViewControllerWithIdentifier:@"_myPageChoose1"];
    _myPageChoose1.vcNum = @"2";
    [self.rootNav pushViewController:_myPageChoose1 animated:YES];
}

- (IBAction)comentAlarmButton:(id)sender {
    MyPageChoose1 *_myPageChoose1 = [self.storyboard instantiateViewControllerWithIdentifier:@"_myPageChoose1"];
    _myPageChoose1.vcNum = @"3";
    [self.rootNav pushViewController:_myPageChoose1 animated:YES];
}

- (IBAction)bookMarkButton:(id)sender {
    MyPageChoose1 *_myPageChoose1 = [self.storyboard instantiateViewControllerWithIdentifier:@"_myPageChoose1"];
    _myPageChoose1.vcNum = @"4";
    [self.rootNav pushViewController:_myPageChoose1 animated:YES];
}

- (IBAction)cartButton:(id)sender {
    MyPageChoose2 *_myPageChoose2 = [self.storyboard instantiateViewControllerWithIdentifier:@"_myPageChoose2"];
    _myPageChoose2.vcNum = @"1";
    [self.rootNav pushViewController:_myPageChoose2 animated:YES];
}

- (IBAction)payButton:(id)sender {
    MyPageChoose2 *_myPageChoose2 = [self.storyboard instantiateViewControllerWithIdentifier:@"_myPageChoose2"];
    _myPageChoose2.vcNum = @"2";
    [self.rootNav pushViewController:_myPageChoose2 animated:YES];
}

- (IBAction)pointButton:(id)sender {
    MyPageChoose2 *_myPageChoose2 = [self.storyboard instantiateViewControllerWithIdentifier:@"_myPageChoose2"];
    _myPageChoose2.vcNum = @"3";
    [self.rootNav pushViewController:_myPageChoose2 animated:YES];
}

- (IBAction)cameraButton:(id)sender {
    UIImagePickerController *photoController = [[UIImagePickerController alloc] init];
    photoController.delegate = self;
    photoController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoController.allowsEditing = NO;
    [self presentViewController:photoController animated:YES completion:nil];
}

#pragma mark -
#pragma mark ImagePicker

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:NO completion:nil];
    
    ImagePreviewController *imagePreviewVC = [[ImagePreviewController alloc] init];
    imagePreviewVC.delegate = self;
    imagePreviewVC.previewImage = [info valueForKey:UIImagePickerControllerOriginalImage];
    [self presentViewController:imagePreviewVC animated:NO completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)setImageCancel:(UIImage *)cropImage{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (UIImage*)resizedImage:(UIImage*)inImage inRect:(CGRect)thumbRect {
    UIGraphicsBeginImageContext(thumbRect.size);
    [inImage drawInRect:thumbRect];
    
    return UIGraphicsGetImageFromCurrentImageContext();
}

- (void)setImageToForm:(UIImage *)cropImage
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *rotateImage = cropImage;
    
    float fDevideValue = 1.0f;
    if (rotateImage.size.width >= rotateImage.size.height && rotateImage.size.width >= 600) {
        fDevideValue = rotateImage.size.width / 600;
    }
    else if (rotateImage.size.height > rotateImage.size.width && rotateImage.size.height >= 600) {
        fDevideValue = rotateImage.size.height / 600;
    }
 
    CGRect imageRect = CGRectMake(0.0f, 0.0f, rotateImage.size.width/fDevideValue, rotateImage.size.height/fDevideValue);
    UIImage *tempImage = [self resizedImage:rotateImage inRect:imageRect];
    //UIImage *tempImage = rotateImage;
    
    NSData *pngData = UIImageJPEGRepresentation(tempImage, 0.8);
    imgName = @"profile_thumb.jpg";
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, MY_PROFILE_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"*****"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file\"; filename=\"%@\"\r\n", imgName] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:pngData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSRange strRange;
    strRange = [returnString rangeOfString:@"success"];
    if (strRange.location != NSNotFound) {
        [self contentUpload];
    }else{
        [self.navigationController.view makeToast:@"이미지 업로드에 실패하였습니다."];
    }
}

- (void)contentUpload{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, MY_PROFILE_URL2];
    NSString * params = @"";
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    params = [NSString stringWithFormat:@"self_id=%@&file_name=%@", [defaults stringForKey:KEY_INDEX], imgName];
    //NSLog(@"params : %@", params);
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        NSLog(@"%ld", statusCode);
        if (statusCode == 200) {
            [defaults setObject:imgName forKey:KEY_IMAGE];
            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/MY_IMG/%@", imgName]]];//[defaults stringForKey:KEY_IMAGE]]]];
            profileImage.clipsToBounds = YES;
            profileImage.layer.cornerRadius = 32.0;
            profileImage.layer.masksToBounds = YES;
            profileImage.image = [UIImage imageWithData:imageData];
            
        }else{
            [self.navigationController.view makeToast:@"이미지 업로드에 실패하였습니다."];
        }
    }];
    [dataTask resume];
}

@end
