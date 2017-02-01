//
//  HelloTalkListWriteVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 28..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "HelloTalkListWriteVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "CommonUtil.h"
#import "UIView+Toast.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface HelloTalkListWriteVC ()

@end

@implementation HelloTalkListWriteVC

@synthesize delegate;
@synthesize topNumber;
@synthesize countryStr;
@synthesize editStr;
@synthesize editDic;
@synthesize talkWriteView1;
@synthesize talkNameView1;
@synthesize cityTextView1;
@synthesize titleTextView1;
@synthesize talkWriteScrollView1;
@synthesize contentTextView1;
@synthesize talkWriteView2;
@synthesize cityTextView2;
@synthesize titleTextView2;
@synthesize contentTextView2;
@synthesize dateText;
@synthesize timeText;
@synthesize meetText;
@synthesize memoText;
@synthesize talkWriteScrollView2;
@synthesize talkWriteView3;
@synthesize cityTextView3;
@synthesize titleTextView3;
@synthesize contentTextView3;
@synthesize foodAddText;
@synthesize foodTourCompnayText;
@synthesize foodTourNameText;
@synthesize foodPriceText;
@synthesize talkWriteScrollView3;
@synthesize talkWriteView4;
@synthesize cityTextView4;
@synthesize titleTextView4;
@synthesize contentTextView4;
@synthesize tourCompnayText;
@synthesize tourNameText;
@synthesize tourPriceText;
@synthesize talkWriteScrollView4;
@synthesize talkWriteView5;
@synthesize cityTextView5;
@synthesize titleTextView5;
@synthesize contentTextView5;
@synthesize sleepNameText;
@synthesize addText;
@synthesize menuText;
@synthesize talkWriteScrollView5;
@synthesize popupView;
@synthesize datePicker;
@synthesize datePickerBarView;
@synthesize timePicker;
@synthesize timePickerBarView;
@synthesize writePopupView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    editImageSaveCheck = 0;
    
    [self imageFileDel];
    
    [self talkViewLoad:topNumber];
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 40, HEIGHT_FRAME/2 - 40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(24, 22, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    [self.view addSubview:loadingView];
    loadingView.hidden = YES;
    
    if([editStr isEqualToString:@"edit"]){
        [self editImageSave];
    }else{
       [self imageInit];
    }
    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"완료" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    
    UIToolbar *toolbar = [[UIToolbar alloc] init];
    [toolbar setBarStyle:UIBarStyleBlackTranslucent];
    [toolbar setItems:[NSArray arrayWithObjects:leftSpace, done, nil]];
    [toolbar sizeToFit];
    
    [contentTextView1 setInputAccessoryView:toolbar];
    contentTextView1.text = @"내용을 입력해주세요.";
    contentTextView1.textColor = [UIColor lightGrayColor];
    
    [contentTextView2 setInputAccessoryView:toolbar];
    contentTextView2.text = @"내용을 입력해주세요.";
    contentTextView2.textColor = [UIColor lightGrayColor];
    
    [contentTextView3 setInputAccessoryView:toolbar];
    contentTextView3.text = @"내용을 입력해주세요.";
    contentTextView3.textColor = [UIColor lightGrayColor];
    
    [contentTextView4 setInputAccessoryView:toolbar];
    contentTextView4.text = @"내용을 입력해주세요.";
    contentTextView4.textColor = [UIColor lightGrayColor];
    
    [contentTextView5 setInputAccessoryView:toolbar];
    contentTextView5.text = @"내용을 입력해주세요.";
    contentTextView5.textColor = [UIColor lightGrayColor];
}

- (void)imageFileDel{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
    NSArray *filelist = [fileManager contentsOfDirectoryAtPath:documentPath error:NULL];
    for(int i = 0; i < [filelist count]; i++){
        NSString *fileName = [filelist objectAtIndex:i];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@", DOCUMENT_DIRECTORY, PHOTO_FOLDER, fileName];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

// 새로 작성
- (void)imageInit{
    for(int i = 0; i < 10; i++){
        thumbImage[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0+i*100, 0, 100, 80)];
        thumbImage[i].exclusiveTouch = YES;
        thumbImage[i].multipleTouchEnabled = NO;
        thumbImage[i].hidden = NO;
        thumbImage[i].tag = i+1;
        thumbImage[i].image = [UIImage imageNamed:@""];
        thumbImage[i].userInteractionEnabled = YES;
        if(topNumber == 0 || topNumber == 1 || topNumber == 4){
            talkWriteScrollView1.hidden = NO;
            [talkWriteScrollView1 addSubview:thumbImage[i]];
        }else if(topNumber == 2){
            talkWriteScrollView2.hidden = NO;
            [talkWriteScrollView2 addSubview:thumbImage[i]];
        }else if(topNumber == 3){
            talkWriteScrollView3.hidden = NO;
            [talkWriteScrollView3 addSubview:thumbImage[i]];
        }else if(topNumber == 5){
            talkWriteScrollView4.hidden = NO;
            [talkWriteScrollView4 addSubview:thumbImage[i]];
        }else if(topNumber == 6){
            talkWriteScrollView5.hidden = NO;
            [talkWriteScrollView5 addSubview:thumbImage[i]];
        }
        
        UITapGestureRecognizer *imageTab = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(selectImage:)];
        imageTab.numberOfTapsRequired = 1;
        imageTab.view.tag = i+1;
        [thumbImage[i] addGestureRecognizer:imageTab];
    }
}

// 수정모드시 이미지 저장(값이 있으면)
- (void)editImageSave{
    editImageSaveCheck = 1;
    if(![[editDic objectForKey:@"Image_url"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_url"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld0.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    if(![[editDic objectForKey:@"Image_urlone"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_urlone"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld1.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    if(![[editDic objectForKey:@"Image_urltwo"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_urltwo"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld2.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    if(![[editDic objectForKey:@"Image_url4"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_url4"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld3.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    if(![[editDic objectForKey:@"Image_url5"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_url5"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld4.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    if(![[editDic objectForKey:@"Image_url6"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_url6"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld5.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    if(![[editDic objectForKey:@"Image_url7"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_url7"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld6.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    if(![[editDic objectForKey:@"Image_url8"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_url8"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld7.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    if(![[editDic objectForKey:@"Image_url9"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_url9"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld8.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    if(![[editDic objectForKey:@"Image_url10"] isEqualToString:@""]){
        NSString *urlString = [NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [editDic objectForKey:@"Image_url10"]];
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        [NSURLConnection connectionWithRequest:request delegate:self];
        NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
        NSString *fileName = [NSString stringWithFormat:@"temp_%ld9.jpg", (long)[CommonUtil getTodayTimeStamp]];
        NSString *localFileSave = [documentPath stringByAppendingPathComponent:fileName];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlString]];
        [imageData writeToFile:localFileSave atomically:YES];
    }
    [self editImageInit];
}

// 수정모드시
- (void)editImageInit{
    [self imageRe];
    
    NSLog(@"edit : %@", editDic);
    if(topNumber == 0 || topNumber == 1 || topNumber == 4){
        cityTextView1.text = [editDic objectForKey:@"City"];
        titleTextView1.text = [editDic objectForKey:@"Title"];
        contentTextView1.text = [editDic objectForKey:@"Body"];
    }else if(topNumber == 2){
        cityTextView2.text = [editDic objectForKey:@"City"];
        titleTextView2.text = [editDic objectForKey:@"Title"];
        contentTextView2.text = [editDic objectForKey:@"Body"];
        dateText.text = [editDic objectForKey:@"Meet_day"];
        timeText.text = [editDic objectForKey:@"Meet_time"];
        meetText.text = [editDic objectForKey:@"Meet_place"];
        memoText.text = [editDic objectForKey:@"Meet_memo"];
    }else if(topNumber == 3){
        cityTextView3.text = [editDic objectForKey:@"City"];
        titleTextView3.text = [editDic objectForKey:@"Title"];
        contentTextView3.text = [editDic objectForKey:@"Body"];
        foodAddText.text = [editDic objectForKey:@"Address"];
        foodTourCompnayText.text = [editDic objectForKey:@"Sale_st"];
        foodTourNameText.text = [editDic objectForKey:@"Menu"];
        foodPriceText.text = [editDic objectForKey:@"Price"];
    }else if(topNumber == 5){
        cityTextView4.text = [editDic objectForKey:@"City"];
        titleTextView4.text = [editDic objectForKey:@"Title"];
        contentTextView4.text = [editDic objectForKey:@"Body"];
        tourCompnayText.text = [editDic objectForKey:@"Tour_compy"];
        tourNameText.text = [editDic objectForKey:@"Tour_type"];
        tourPriceText.text = [editDic objectForKey:@"Price"];
    }else if(topNumber == 6){
        cityTextView5.text = [editDic objectForKey:@"City"];
        titleTextView5.text = [editDic objectForKey:@"Title"];
        contentTextView5.text = [editDic objectForKey:@"Body"];
        sleepNameText.text = [editDic objectForKey:@"Room_type"];
        addText.text = [editDic objectForKey:@"Address"];
        menuText.text = [editDic objectForKey:@"Menu"];
    }
}

// 이미지 재배치
- (void)imageRe{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
    photoArr = [fileManager contentsOfDirectoryAtPath:documentPath error:NULL];
    for(int j = 0; j < 10; j++){
        thumbImage[j].image = [UIImage imageNamed:@""];
    }
    for(int i = 0; i < 10; i++){
        thumbImage[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0+i*100, 0, 100, 80)];
        thumbImage[i].exclusiveTouch = YES;
        thumbImage[i].multipleTouchEnabled = NO;
        thumbImage[i].hidden = NO;
        thumbImage[i].tag = i+1;
        if(i < [photoArr count]){
            NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@", DOCUMENT_DIRECTORY, PHOTO_FOLDER, [photoArr objectAtIndex:i]];
            NSData *imageData = [[NSData alloc] initWithContentsOfFile:filePath];
            thumbImage[i].image = [UIImage imageWithData:imageData];
        }else{
            thumbImage[i].image = [UIImage imageNamed:@""];
        }
        thumbImage[i].userInteractionEnabled = YES;
        if(topNumber == 0 || topNumber == 1 || topNumber == 4){
            talkWriteScrollView1.hidden = NO;
            [talkWriteScrollView1 addSubview:thumbImage[i]];
        }else if(topNumber == 2){
            talkWriteScrollView2.hidden = NO;
            [talkWriteScrollView2 addSubview:thumbImage[i]];
        }else if(topNumber == 3){
            talkWriteScrollView3.hidden = NO;
            [talkWriteScrollView3 addSubview:thumbImage[i]];
        }else if(topNumber == 5){
            talkWriteScrollView4.hidden = NO;
            [talkWriteScrollView4 addSubview:thumbImage[i]];
        }else if(topNumber == 6){
            talkWriteScrollView5.hidden = NO;
            [talkWriteScrollView5 addSubview:thumbImage[i]];
        }
        
        UITapGestureRecognizer *imageTab = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(selectImage:)];
        imageTab.numberOfTapsRequired = 1;
        imageTab.view.tag = i+1;
        [thumbImage[i] addGestureRecognizer:imageTab];
    }
    
    if(topNumber == 0 || topNumber == 1 || topNumber == 4){
        [talkWriteScrollView1 setContentSize:CGSizeMake(100*[photoArr count], 80)];
    }else if(topNumber == 2){
        [talkWriteScrollView2 setContentSize:CGSizeMake(100*[photoArr count], 80)];
    }else if(topNumber == 3){
        [talkWriteScrollView3 setContentSize:CGSizeMake(100*[photoArr count], 80)];
    }else if(topNumber == 5){
        [talkWriteScrollView4 setContentSize:CGSizeMake(100*[photoArr count], 80)];
    }else if(topNumber == 6){
        [talkWriteScrollView5 setContentSize:CGSizeMake(100*[photoArr count], 80)];
    }
}

- (void)delImage{
    for(int i = 0; i < 10; i++){
        thumbImage[i].image = [UIImage imageNamed:@""];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)talkViewLoad:(NSInteger)index{
    if([editStr isEqualToString:@"edit"]){
        [self editImageInit];
    }else{
        [self delImage];
        [self imageInit];
    }
    
    talkWriteScrollView1.hidden = YES;
    talkWriteScrollView2.hidden = YES;
    talkWriteScrollView3.hidden = YES;
    talkWriteScrollView4.hidden = YES;
    talkWriteScrollView5.hidden = YES;
    
    talkWriteView1.hidden = YES;
    talkWriteView2.hidden = YES;
    talkWriteView3.hidden = YES;
    talkWriteView4.hidden = YES;
    talkWriteView5.hidden = YES;
    
    if(index == 0){
        talkWriteView1.hidden = NO;
        talkNameView1.text = @"여행스토리";
        topName = @"여행스토리";
    }else if(index == 1){
        talkWriteView1.hidden = NO;
        talkNameView1.text = @"질문";
        topName = @"질문";
    }else if(index == 2){
        talkWriteView2.hidden = NO;
        topName = @"동행";
    }else if(index == 3){
        talkWriteView3.hidden = NO;
        topName = @"맛집";
    }else if(index == 4){
        talkWriteView1.hidden = NO;
        talkNameView1.text = @"교통";
        topName = @"교통";
    }else if(index == 5){
        talkWriteView4.hidden = NO;
        topName = @"투어리뷰";
    }else if(index == 6){
        talkWriteView5.hidden = NO;
        topName = @"숙소리뷰";
    }
}

#pragma mark -
#pragma mark Button Action

- (IBAction)backButton:(id)sender {
    [self imageFileDel];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)uploadButton:(id)sender {
    editImageSaveCheck = 0;
    loadingView.hidden = NO;
    [activityView startAnimating];
    writePopupView.hidden = NO;

    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
    photoArr = [fileManager contentsOfDirectoryAtPath:documentPath error:NULL];
    
    [self performSelector:@selector(uploadLoadingView) withObject:nil afterDelay:0.5];
}

- (void)uploadLoadingView{
    for(NSInteger j = 0; j < 10; j++){
        imageName[j] = @"";
    }
    
    if([photoArr count] != 0){
        photoArrNum = 0;
        [self imageUpload];
    }else{
        [self contentUpload];
    }
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSLog(@"%.2f Percent complete", (CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite * 100.0f);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    //NSString *returnString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    //NSLog(@"%@", returnString);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    if(editImageSaveCheck == 1){
        return;
    }
    photoArrNum++;
    if(photoArrNum == [photoArr count]){
        [self contentUpload];
    }else{
        [self imageUpload];
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"이미지 업로드에 실패하였습니다." preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {}];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
    
    loadingView.hidden = YES;
    [activityView stopAnimating];
    writePopupView.hidden = YES;
}

- (void)imageUpload{
    imageName[photoArrNum] = [photoArr objectAtIndex:photoArrNum];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@", DOCUMENT_DIRECTORY, PHOTO_FOLDER, imageName[photoArrNum]];
    NSData *imageData = [[NSData alloc] initWithContentsOfFile:filePath];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKIMAGE_URL];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    NSString *boundary = [NSString stringWithString:@"*****"];
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    NSMutableData *body = [NSMutableData data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file\"; filename=\"%@\"\r\n", imageName[photoArrNum]] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[NSData dataWithData:imageData]];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:body];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSRange strRange;
    strRange = [returnString rangeOfString:@"success"];
    if (strRange.location != NSNotFound) {
        if(editImageSaveCheck == 1){
            return;
        }
        photoArrNum++;
        if(photoArrNum == [photoArr count]){
            [self contentUpload];
        }else{
            [self imageUpload];
        }
    }else{
        [self.navigationController.view makeToast:@"글쓰기에 실패하였습니다. 다시 시도해주세요."];
    }
}

- (void)contentUpload{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *e_city = @"";
    NSString *e_tag = topName;
    NSString *e_title = @"";
    NSString *e_body = @"";
    NSString *self_id = [defaults stringForKey:KEY_INDEX];
    NSString *self_nickname = [defaults stringForKey:KEY_NAME];
    NSString *country = countryStr;
    NSString *tour_compy = @"";
    NSString *tour_type = @"";
    NSString *sale_st = @"";
    NSString *sale_en = @"";
    NSString *room_type = @"";
    NSString *price = @"";
    NSString *address = @"";
    NSString *menu = @"";
    NSString *meet_day = @"";
    NSString *meet_time = @"";
    NSString *meet_place = @"";
    NSString *meet_memo = @"";
    NSString *key_Index = @"";

    if(topNumber == 0 || topNumber == 1 || topNumber == 4){
        e_city = cityTextView1.text;
        e_title = titleTextView1.text;
        e_body = contentTextView1.text;
    }else if(topNumber == 2){
        e_city = cityTextView2.text;
        e_title = titleTextView2.text;
        e_body = contentTextView2.text;
        meet_day = dateText.text;
        meet_time = timeText.text;
        meet_place = meetText.text;
        meet_memo = memoText.text;
    }else if(topNumber == 3){
        e_city = cityTextView3.text;
        e_title = titleTextView3.text;
        e_body = contentTextView3.text;
        address = foodAddText.text;
        sale_st = foodTourCompnayText.text;
        menu = foodTourNameText.text;
        price = foodPriceText.text;
    }else if(topNumber == 5){
        e_city = cityTextView4.text;
        e_title = titleTextView4.text;
        e_body = contentTextView4.text;
        tour_compy = tourCompnayText.text;
        tour_type = tourNameText.text;
        price = tourPriceText.text;
    }else if(topNumber == 6){
        e_city = cityTextView5.text;
        e_title = titleTextView5.text;
        e_body = contentTextView5.text;
        room_type = sleepNameText.text;
        address = addText.text;
        menu = menuText.text;
    }
    
    NSString *urlString = @"";
    NSString * params = @"";
    if([editStr isEqualToString:@"edit"]){
        urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKWRITE_EDIT_URL];
        key_Index = [editDic objectForKey:@"Key_Index"];
        params = [NSString stringWithFormat:@"e_city=%@&e_tag=%@&e_title=%@&e_body=%@&self_id=%@&self_nickname=%@&country=%@&tour_compy=%@&tour_type=%@&sale_st=%@&sale_en=%@&room_type=%@&price=%@&address=%@&menu=%@&img1=%@&img2=%@&img3=%@&img4=%@&img5=%@&img6=%@&img7=%@&img8=%@&img9=%@&img10=%@&meet_day=%@&meet_time=%@&meet_place=%@&meet_memo=%@&key_index=%@", e_city, e_tag, e_title, e_body, self_id, self_nickname, country, tour_compy, tour_type, sale_st, sale_en, room_type, price, address, menu, imageName[0], imageName[1], imageName[2], imageName[3], imageName[4], imageName[5], imageName[6], imageName[7], imageName[8], imageName[9], meet_day, meet_time, meet_place, meet_memo, key_Index];
        //NSLog(@"params : %@", params);
    }else{
        urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKWRITE_URL];
        params = [NSString stringWithFormat:@"e_city=%@&e_tag=%@&e_title=%@&e_body=%@&self_id=%@&self_nickname=%@&country=%@&tour_compy=%@&tour_type=%@&sale_st=%@&sale_en=%@&room_type=%@&price=%@&address=%@&menu=%@&image_name1=%@&image_name2=%@&image_name3=%@&image_name4=%@&image_name5=%@&image_name6=%@&image_name7=%@&image_name8=%@&image_name9=%@&image_name10=%@&meet_day=%@&meet_time=%@&meet_place=%@&meet_memo=%@&key_index=%@", e_city, e_tag, e_title, e_body, self_id, self_nickname, country, tour_compy, tour_type, sale_st, sale_en, room_type, price, address, menu, imageName[0], imageName[1], imageName[2], imageName[3], imageName[4], imageName[5], imageName[6], imageName[7], imageName[8], imageName[9], meet_day, meet_time, meet_place, meet_memo, key_Index];
        //NSLog(@"params : %@", params);
    }
    
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            [self imageFileDel];
            
            if([editStr isEqualToString:@"edit"]){
                NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKREFRESH_URL];
                NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
                NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
                
                NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
                NSString *params = [NSString stringWithFormat:@"key_index=%@&self_id=%@", [editDic objectForKey:@"Key_Index"], [defaults stringForKey:KEY_INDEX]];
                [urlRequest setHTTPMethod:@"POST"];
                [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
                
                NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    //NSLog(@"Response:%@ %@\n", response, error);
                    if(error == nil)
                    {
                        if (data != nil) {
                            xmlParser = [[NSXMLParser alloc] initWithData:data];
                            xmlParser.delegate = self;
                            xmlArrData = [[NSMutableArray alloc] init];
                            xmlDic = [[NSMutableDictionary alloc] init];
                            foundValue = [[NSMutableString alloc] init];
                            [xmlParser parse];
                        }
                    }
                }];
                [dataTask resume];
            }else{
                [self.navigationController popViewControllerAnimated:YES];
            }
            
        }else{
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"글쓰기가 실패하였습니다." preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {}];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        loadingView.hidden = YES;
        [activityView stopAnimating];
        writePopupView.hidden = YES;
    }];
    [dataTask resume];
}

- (IBAction)photoButton:(id)sender {
    /*
    UIImagePickerController *photoController = [[UIImagePickerController alloc] init];
    photoController.delegate = self;
    photoController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoController.allowsEditing = NO;
    [self presentViewController:photoController animated:YES completion:nil];
    */
    
    if([photoArr count] == 10){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"최대 10장만 추가할 수 있습니다."
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
        [alert show];
        return;
    }
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 10 - [photoArr count]; //Set the maximum number of images to select to 100
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //Supports image and movie types
    
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

#pragma mark -
#pragma mark ActionSheet

- (void)actionSheetChooseButton{
    UIActionSheet *menu = [[UIActionSheet alloc] init];
    menu.title = @"선택하세요.";
    menu.delegate = self;
    
    [menu addButtonWithTitle:@"여행스토리"];
    [menu addButtonWithTitle:@"질문"];
    [menu addButtonWithTitle:@"동행"];
    [menu addButtonWithTitle:@"맛집"];
    [menu addButtonWithTitle:@"교통"];
    [menu addButtonWithTitle:@"투어리뷰"];
    [menu addButtonWithTitle:@"숙소리뷰"];
    [menu addButtonWithTitle:@"취소"];
    [menu showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        topNumber = 0;
        [self talkViewLoad:0];
    }else if(buttonIndex == 1){
        topNumber = 1;
        [self talkViewLoad:1];
    }else if(buttonIndex == 2){
        topNumber = 2;
        [self talkViewLoad:2];
    }else if(buttonIndex == 3){
        topNumber = 3;
        [self talkViewLoad:3];
    }else if(buttonIndex == 4){
        topNumber = 4;
        [self talkViewLoad:4];
    }else if(buttonIndex == 5){
        topNumber = 5;
        [self talkViewLoad:5];
    }else if(buttonIndex == 6){
        topNumber = 6;
        [self talkViewLoad:6];
    }
    
    [self textViewZero];
}

// View1
- (IBAction)talkNameButtonView1:(id)sender {
    [self actionSheetChooseButton];
}

// View2
- (IBAction)talkNameButtonView2:(id)sender {
    [self actionSheetChooseButton];
}

// View3
- (IBAction)talkNameButtonView3:(id)sender {
    [self actionSheetChooseButton];
}

// View4
- (IBAction)talkNameButtonView5:(id)sender {
    [self actionSheetChooseButton];
}

// View5
- (IBAction)talkNameButtonView4:(id)sender {
    [self actionSheetChooseButton];
}

// DatePicker
- (IBAction)dateButton:(id)sender {
    popupView.hidden = NO;
    datePicker.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseIn animations:^{
        datePickerBarView.hidden = NO;
        datePicker.hidden = NO;
    }completion:^(BOOL finished){}];
}

- (IBAction)datePickerDone:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *formatedDate = @"";
    [dateFormatter setDateFormat:@"yyyy / MM / dd"];
    formatedDate = [dateFormatter stringFromDate:datePicker.date];
    dateText.text = formatedDate;
}

- (IBAction)datePickerBarDoneButton:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy / MM / dd"];
    NSString *formatedDate = [dateFormatter stringFromDate:datePicker.date];
    dateText.text = formatedDate;
    
    [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseIn animations:^{
        datePickerBarView.hidden = YES;
        datePicker.hidden = YES;
    }completion:^(BOOL finished){}];
    popupView.hidden = YES;
}

// TimePicker
- (IBAction)timeButton:(id)sender {
    popupView.hidden = NO;
    timePicker.backgroundColor = [UIColor whiteColor];
    [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseIn animations:^{
        timePickerBarView.hidden = NO;
        timePicker.hidden = NO;
    }completion:^(BOOL finished){}];
}

- (IBAction)timePickerDone:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *formatedDate = @"";
    [dateFormatter setDateFormat:@"h : mm a"];
    formatedDate = [dateFormatter stringFromDate:timePicker.date];
    timeText.text = formatedDate;
}

- (IBAction)timePickerBarDoneButton:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"h : mm a"];
    NSString *formatedDate = [dateFormatter stringFromDate:timePicker.date];
    timeText.text = formatedDate;
    
    [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseIn animations:^{
        timePickerBarView.hidden = YES;
        timePicker.hidden = YES;
    }completion:^(BOOL finished){}];
    popupView.hidden = YES;
}

#pragma mark -
#pragma mark Image ScrollView

- (void)initScrollView1:(NSInteger)num pageNumber:(NSInteger)number{
    writePageControl1.currentPage = 0;
    
    CGRect bounds = talkWriteScrollView1.bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    
    [talkWriteScrollView1 scrollRectToVisible:bounds animated:NO];
    controllers1 = [[NSMutableArray alloc]init];
    
    for(int idx = 0 ; idx < number ; idx++){
        [controllers1 addObject:[NSNull null]];
    }
    
    CGSize contentSize = CGSizeMake(100 * number, 80);
    
    [talkWriteScrollView1 setContentSize:contentSize];
    [talkWriteScrollView1 setPagingEnabled:YES];
    [talkWriteScrollView1 setBounces:NO];
    [talkWriteScrollView1 setScrollsToTop:NO];
    [talkWriteScrollView1 setScrollEnabled:YES];
    talkWriteScrollView1.showsHorizontalScrollIndicator = NO;
    talkWriteScrollView1.showsVerticalScrollIndicator = NO;
    
    [writePageControl1 setNumberOfPages:number];
    [writePageControl1 setCurrentPage:0];
}

- (void)initScrollView2:(NSInteger)num pageNumber:(NSInteger)number{
    writePageControl2.currentPage = 0;
    
    CGRect bounds = talkWriteScrollView2.bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    
    [talkWriteScrollView2 scrollRectToVisible:bounds animated:NO];
    controllers2 = [[NSMutableArray alloc]init];
    
    for(int idx = 0 ; idx < number ; idx++){
        [controllers2 addObject:[NSNull null]];
    }
    
    CGSize contentSize = CGSizeMake(100 * number, 80);
    
    [talkWriteScrollView2 setContentSize:contentSize];
    [talkWriteScrollView2 setPagingEnabled:YES];
    [talkWriteScrollView2 setBounces:NO];
    [talkWriteScrollView2 setScrollsToTop:NO];
    [talkWriteScrollView2 setScrollEnabled:YES];
    talkWriteScrollView2.showsHorizontalScrollIndicator = NO;
    talkWriteScrollView2.showsVerticalScrollIndicator = NO;
    
    [writePageControl2 setNumberOfPages:number];
    [writePageControl2 setCurrentPage:0];
}

- (void)initScrollView3:(NSInteger)num pageNumber:(NSInteger)number{
    writePageControl3.currentPage = 0;
    
    CGRect bounds = talkWriteScrollView3.bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    
    [talkWriteScrollView3 scrollRectToVisible:bounds animated:NO];
    controllers3 = [[NSMutableArray alloc]init];
    
    for(int idx = 0 ; idx < number ; idx++){
        [controllers3 addObject:[NSNull null]];
    }
    
    CGSize contentSize = CGSizeMake(100 * number, 80);
    
    [talkWriteScrollView3 setContentSize:contentSize];
    [talkWriteScrollView3 setPagingEnabled:YES];
    [talkWriteScrollView3 setBounces:NO];
    [talkWriteScrollView3 setScrollsToTop:NO];
    [talkWriteScrollView3 setScrollEnabled:YES];
    talkWriteScrollView3.showsHorizontalScrollIndicator = NO;
    talkWriteScrollView3.showsVerticalScrollIndicator = NO;
    
    [writePageControl3 setNumberOfPages:number];
    [writePageControl3 setCurrentPage:0];
}

- (void)initScrollView4:(NSInteger)num pageNumber:(NSInteger)number{
    writePageControl4.currentPage = 0;
    
    CGRect bounds = talkWriteScrollView4.bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    
    [talkWriteScrollView4 scrollRectToVisible:bounds animated:NO];
    controllers4 = [[NSMutableArray alloc]init];
    
    for(int idx = 0 ; idx < number ; idx++){
        [controllers4 addObject:[NSNull null]];
    }
    
    CGSize contentSize = CGSizeMake(100 * number, 80);
    
    [talkWriteScrollView4 setContentSize:contentSize];
    [talkWriteScrollView4 setPagingEnabled:YES];
    [talkWriteScrollView4 setBounces:NO];
    [talkWriteScrollView4 setScrollsToTop:NO];
    [talkWriteScrollView4 setScrollEnabled:YES];
    talkWriteScrollView4.showsHorizontalScrollIndicator = NO;
    talkWriteScrollView4.showsVerticalScrollIndicator = NO;
    
    [writePageControl4 setNumberOfPages:number];
    [writePageControl4 setCurrentPage:0];
}

- (void)initScrollView5:(NSInteger)num pageNumber:(NSInteger)number{
    writePageControl5.currentPage = 0;
    
    CGRect bounds = talkWriteScrollView5.bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    
    [talkWriteScrollView5 scrollRectToVisible:bounds animated:NO];
    controllers5 = [[NSMutableArray alloc]init];
    
    for(int idx = 0 ; idx < number ; idx++){
        [controllers5 addObject:[NSNull null]];
    }
    
    CGSize contentSize = CGSizeMake(100 * number, 80);
    
    [talkWriteScrollView5 setContentSize:contentSize];
    [talkWriteScrollView5 setPagingEnabled:YES];
    [talkWriteScrollView5 setBounces:NO];
    [talkWriteScrollView5 setScrollsToTop:NO];
    [talkWriteScrollView5 setScrollEnabled:YES];
    talkWriteScrollView5.showsHorizontalScrollIndicator = NO;
    talkWriteScrollView5.showsVerticalScrollIndicator = NO;
    
    [writePageControl5 setNumberOfPages:number];
    [writePageControl5 setCurrentPage:0];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(topNumber == 0 || topNumber == 1 || topNumber == 4){
        CGFloat pageHeight = CGRectGetHeight(talkWriteScrollView1.frame);
        NSUInteger page = floor((talkWriteScrollView1.contentOffset.x - pageHeight / [photoArr count]) / pageHeight) + 1;
        writePageControl1.currentPage = page;
    }else if(topNumber == 2){
        CGFloat pageHeight = CGRectGetHeight(talkWriteScrollView2.frame);
        NSUInteger page = floor((talkWriteScrollView2.contentOffset.x - pageHeight / [photoArr count]) / pageHeight) + 1;
        writePageControl2.currentPage = page;
    }else if(topNumber == 3){
        CGFloat pageHeight = CGRectGetHeight(talkWriteScrollView3.frame);
        NSUInteger page = floor((talkWriteScrollView3.contentOffset.x - pageHeight / [photoArr count]) / pageHeight) + 1;
        writePageControl3.currentPage = page;
    }else if(topNumber == 5){
        CGFloat pageHeight = CGRectGetHeight(talkWriteScrollView4.frame);
        NSUInteger page = floor((talkWriteScrollView4.contentOffset.x - pageHeight / [photoArr count]) / pageHeight) + 1;
        writePageControl4.currentPage = page;
    }else if(topNumber == 6){
        CGFloat pageHeight = CGRectGetHeight(talkWriteScrollView5.frame);
        NSUInteger page = floor((talkWriteScrollView5.contentOffset.x - pageHeight / [photoArr count]) / pageHeight) + 1;
        writePageControl5.currentPage = page;
    }
}

#pragma mark -
#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [images addObject:image];
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        } else {
            NSLog(@"Uknown asset type");
        }
    }
    
    for(int i = 0; i < [images count]; i++){
        thumbImage[i + [photoArr count]].image = [images objectAtIndex:i];
        
        NSData *pngData = UIImageJPEGRepresentation([images objectAtIndex:i], 1.0);
        NSString *filePath = [NSString stringWithFormat:@"%@/%@/temp_%ld%d.jpg", DOCUMENT_DIRECTORY, PHOTO_FOLDER, (long)[CommonUtil getTodayTimeStamp], i];
        [pngData writeToFile:filePath atomically:YES];
    }
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
    photoArr = [fileManager contentsOfDirectoryAtPath:documentPath error:NULL];

    if(topNumber == 0 || topNumber == 1 || topNumber == 4){
        [self initScrollView1:0 pageNumber:[photoArr count]];
    }else if(topNumber == 2){
        [self initScrollView2:0 pageNumber:[photoArr count]];
    }else if(topNumber == 3){
        [self initScrollView3:0 pageNumber:[photoArr count]];
    }else if(topNumber == 5){
        [self initScrollView4:0 pageNumber:[photoArr count]];
    }else if(topNumber == 6){
        [self initScrollView5:0 pageNumber:[photoArr count]];
    }
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    /*
    float fDevideValue = 1.0f;
    if (rotateImage.size.width >= rotateImage.size.height && rotateImage.size.width >= 600) {
        fDevideValue = rotateImage.size.width / 600;
    }
    else if (rotateImage.size.height > rotateImage.size.width && rotateImage.size.height >= 600) {
        fDevideValue = rotateImage.size.height / 600;
    }
    */
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
    photoArr = [fileManager contentsOfDirectoryAtPath:documentPath error:NULL];

    CGRect imageRect = CGRectMake(0.0f, 0.0f, rotateImage.size.width, rotateImage.size.height);
    UIImage *tempImage = [self resizedImage:rotateImage inRect:imageRect];
    thumbImage[[photoArr count]].image = tempImage;
    
    NSData *pngData = UIImageJPEGRepresentation(tempImage, 1.0);
    NSString *filePath = [NSString stringWithFormat:@"%@/%@/temp_%ld.jpg", DOCUMENT_DIRECTORY, PHOTO_FOLDER, (long)[CommonUtil getTodayTimeStamp]];
    [pngData writeToFile:filePath atomically:YES];
    
    if(topNumber == 0 || topNumber == 1 || topNumber == 4){
        [self initScrollView1:0 pageNumber:[photoArr count]];
    }else if(topNumber == 2){
        [self initScrollView2:0 pageNumber:[photoArr count]];
    }else if(topNumber == 3){
        [self initScrollView3:0 pageNumber:[photoArr count]];
    }else if(topNumber == 5){
        [self initScrollView4:0 pageNumber:[photoArr count]];
    }else if(topNumber == 6){
        [self initScrollView5:0 pageNumber:[photoArr count]];
    }
}

- (void)selectImage:(UIGestureRecognizer *)gestureRecognizer{
    NSInteger index = gestureRecognizer.view.tag;
    
    if(thumbImage[index - 1].image == nil){
        return;
    }
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"삭제하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"아니요" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"예" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {
                             thumbImage[index - 1].image = [UIImage imageNamed:@""];
                             NSFileManager * fileManager = [NSFileManager defaultManager];
                             NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
                             photoArr = [fileManager contentsOfDirectoryAtPath:documentPath error:NULL];
                            
                             NSString *fileName = [photoArr objectAtIndex:index - 1];
                             NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@", DOCUMENT_DIRECTORY, PHOTO_FOLDER, fileName];
                             [fileManager removeItemAtPath:filePath error:nil];
                             [self imageRe];
                         }];
    
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark -
#pragma mark TextField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSInteger textY = 0;
    if(textField == meetText){
        if(WIDTH_FRAME == 414){
            textY = -178;
        }else if(WIDTH_FRAME == 375){
            textY = -170;
        }else{
            textY = -170;
        }
    }else if(textField == memoText){
        if(WIDTH_FRAME == 414){
            textY = -216;
        }else if(WIDTH_FRAME == 375){
            textY = -214;
        }else{
            textY = -214;
        }
    }else if(textField == foodAddText){
        if(WIDTH_FRAME == 414){
            textY = -114;
        }else if(WIDTH_FRAME == 375){
            textY = -112;
        }else{
            textY = -104;
        }
    }else if(textField == foodTourCompnayText){
        if(WIDTH_FRAME == 414){
            textY = -150;
        }else if(WIDTH_FRAME == 375){
            textY = -138;
        }else{
            textY = -138;
        }
    }else if(textField == foodTourNameText){
        if(WIDTH_FRAME == 414){
            textY = -184;
        }else if(WIDTH_FRAME == 375){
            textY = -174;
        }else{
            textY = -174;
        }
    }else if(textField == foodPriceText){
        if(WIDTH_FRAME == 414){
            textY = -218;
        }else if(WIDTH_FRAME == 375){
            textY = -214;
        }else{
            textY = -214;
        }
    }else if(textField == tourCompnayText || textField == sleepNameText){
        if(WIDTH_FRAME == 414){
            textY = -146;
        }else if(WIDTH_FRAME == 375){
            textY = -138;
        }else{
            textY = -138;
        }
    }else if(textField == tourNameText || textField == addText){
        if(WIDTH_FRAME == 414){
            textY = -184;
        }else if(WIDTH_FRAME == 375){
            textY = -178;
        }else{
            textY = -178;
        }
    }else if(textField == tourPriceText || textField == menuText){
        if(WIDTH_FRAME == 414){
            textY = -222;
        }else if(WIDTH_FRAME == 375){
            textY = -214;
        }else{
            textY = -214;
        }
    }
    
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 textY,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.view.frame = CGRectMake(self.view.frame.origin.x,
                                 0,
                                 self.view.frame.size.width,
                                 self.view.frame.size.height);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)done{
    [contentTextView1 resignFirstResponder];
    [contentTextView2 resignFirstResponder];
    [contentTextView3 resignFirstResponder];
    [contentTextView4 resignFirstResponder];
    [contentTextView5 resignFirstResponder];
    
    [self textViewZero];
}

#pragma mark -
#pragma mark TextView Delegate

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if([contentTextView1.text isEqualToString:@"내용을 입력해주세요."]){
        contentTextView1.text = @"";
        contentTextView1.textColor = [UIColor blackColor];
    }
    if([contentTextView2.text isEqualToString:@"내용을 입력해주세요."]){
        contentTextView2.text = @"";
        contentTextView2.textColor = [UIColor blackColor];
    }
    if([contentTextView3.text isEqualToString:@"내용을 입력해주세요."]){
        contentTextView3.text = @"";
        contentTextView3.textColor = [UIColor blackColor];
    }
    if([contentTextView4.text isEqualToString:@"내용을 입력해주세요."]){
        contentTextView4.text = @"";
        contentTextView4.textColor = [UIColor blackColor];
    }
    if([contentTextView5.text isEqualToString:@"내용을 입력해주세요."]){
        contentTextView5.text = @"";
        contentTextView5.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    [self textViewZero];
}

// 텍스트뷰 값이 0일때 처리
- (void)textViewZero{
    if(contentTextView1.text.length == 0){
        contentTextView1.textColor = [UIColor lightGrayColor];
        contentTextView1.text = @"내용을 입력해주세요.";
    }
    if(contentTextView2.text.length == 0){
        contentTextView2.textColor = [UIColor lightGrayColor];
        contentTextView2.text = @"내용을 입력해주세요.";
    }
    if(contentTextView3.text.length == 0){
        contentTextView3.textColor = [UIColor lightGrayColor];
        contentTextView3.text = @"내용을 입력해주세요.";
    }
    if(contentTextView4.text.length == 0){
        contentTextView4.textColor = [UIColor lightGrayColor];
        contentTextView4.text = @"내용을 입력해주세요.";
    }
    if(contentTextView5.text.length == 0){
        contentTextView5.textColor = [UIColor lightGrayColor];
        contentTextView5.text = @"내용을 입력해주세요.";
    }
}

#pragma mark -
#pragma mark NSXMLParserDelegate method

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    // Initialize the neighbours data array.
    xmlArrData = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [delegate editSend:xmlDic];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"word"]) {
        elementType = eEditItem;
    }
    
    [foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (elementType != eEditItem)
        return;
    
    if ([elementName isEqualToString:@"Key_Index"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Title"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Body"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Date"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Comment_ea"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Comment_id"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Comment_nickname"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_url"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_urlone"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_urltwo"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_url4"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_url5"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_url6"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_url7"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_url8"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_url9"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Image_url10"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Self_id"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Self_nickname"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"choo"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"City"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Tag"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Meet_day"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Meet_time"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Meet_place"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Meet_etc"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Meet_memo"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Meet_phone"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Meet_point"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Country"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Danger"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Tour_compy"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Tour_type"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Price"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Address"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Sale_st"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Sale_end"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Menu"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Room_type"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"Good"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"word"]) {
        [xmlArrData addObject:[NSDictionary dictionaryWithDictionary:xmlDic]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (elementType == eEditItem) {
        [foundValue appendString:string];
    }
}

@end
