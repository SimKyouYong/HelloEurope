//
//  AudioGuideDetailVC.m
//  HelloEurope
//
//  Created by Joseph on 2016. 5. 18..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "AudioGuideDetailVC.h"
#import "AppDelegate.h"
#import "AudioGudioDetailCell.h"
#import "AudioGuideFoodVC.h"
#import "AudioGuideMapVC.h"
#import "GlobalHeader.h"

@interface AudioGuideDetailVC ()

@end

@implementation AudioGuideDetailVC

@synthesize cityNameStr;
@synthesize countryNameStr;
@synthesize audioDetailTableView;
@synthesize audioDetailScrollView;
@synthesize detailPopupView;
@synthesize audioDownCancelButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    id AppID = [[UIApplication sharedApplication] delegate];
    audioDetailListArr = [[NSMutableArray alloc] init];
    audioDetailListArr = [AppID selectCityDetailList:cityNameStr];
    
    downloadCount = 0;
    
    for(int i = 0; i < [audioDetailListArr count]; i++){
        NSDictionary *dic = [audioDetailListArr objectAtIndex:i];
        if(![[dic objectForKey:@"mp3_file"] isEqualToString:@""]){
            downloadCount++;
        }
    }
    
    audioDetailFoodListArr = [[NSMutableArray alloc] init];
    audioDetailFoodListArr = [AppID selectFoodCityName:cityNameStr];
    
    UIImageView *thumbImage[[audioDetailFoodListArr count]];
    
    for(int i = 0; i < [audioDetailFoodListArr count]; i++){
        NSDictionary *dic = [audioDetailFoodListArr objectAtIndex:i];
        thumbImage[i] = [[UIImageView alloc] initWithFrame:CGRectMake(2+(i*100 + 4), 3, 96, 70)];
        thumbImage[i].exclusiveTouch = YES;
        thumbImage[i].multipleTouchEnabled = NO;
        thumbImage[i].hidden = NO;
        thumbImage[i].tag = i;
        NSString *foodImageName = [NSString stringWithFormat:@"%@.jpg", [dic objectForKey:@"col_9"]];
        thumbImage[i].image = [UIImage imageNamed:foodImageName];
        thumbImage[i].userInteractionEnabled = YES;
        thumbImage[i].backgroundColor = [UIColor redColor];
        [audioDetailScrollView addSubview:thumbImage[i]];
        
        UITapGestureRecognizer *imageTab = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(selectFoodImage:)];
        imageTab.numberOfTapsRequired = 1;
        imageTab.view.tag = i;
        [thumbImage[i] addGestureRecognizer:imageTab];
    }
    
    CGSize contentSize = CGSizeMake(100 * [audioDetailFoodListArr count], 76);
    [audioDetailScrollView setContentSize:contentSize];
    
    multiProgress = [[UIProgressView alloc] initWithFrame:CGRectMake((WIDTH_FRAME - 200)/2, HEIGHT_FRAME/2 - 25, 200, 50)];
    [self.view addSubview:multiProgress];
    multiProgress.hidden = YES;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(WIDTH_FRAME/2 - 12, HEIGHT_FRAME/2 - 50 - 6, 24, 22);
    [self.view addSubview:activityView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark mp3 Down



#pragma mark -
#pragma mark Button Action

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)audioDownButton:(id)sender {
    //NSLog(@"%@", DOCUMENT_DIRECTORY);
    
    pointStr = @"";
    
    if([countryNameStr isEqualToString:@"독일"] || [countryNameStr isEqualToString:@"스위스"] || [countryNameStr isEqualToString:@"이탈리아"] || [countryNameStr isEqualToString:@"프랑스"] || [countryNameStr isEqualToString:@"오스트리아"]){
        pointStr = @"10";
        if([cityNameStr isEqualToString:@"파리"]){
            pointStr = @"0";
        }else if([cityNameStr isEqualToString:@"피렌체"] || [cityNameStr isEqualToString:@"로마"]){
            pointStr = @"30";
        }
    }else if([countryNameStr isEqualToString:@"영국"] || [countryNameStr isEqualToString:@"헝가리"]){
        pointStr = @"0";
    }else{
        pointStr = @"30";
    }
                                                                                                                                                                                   
    NSString *alertStr = [NSString stringWithFormat:@"포인트 %@이 차감됩니다.\n(기존에 다운 받았다면 차감되지 않음.)", pointStr];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:alertStr
                                                   delegate:self cancelButtonTitle:@"취소" otherButtonTitles:@"확인" ,nil];
    alert.tag = 1236;
    [alert show];
}

- (void)audioDownInit{
    multiProgress.progress = 0;
     
    ASIHTTPRequest *request;
    for(int i=0; i<[audioDetailListArr count]; i++){
        NSDictionary *dic = [audioDetailListArr objectAtIndex:i];
        NSString *mp3Name = [dic objectForKey:@"mp3_file"];
        if(mp3Name.length != 0){
            NSString *fileName = [dic objectForKey:@"mp3_file"];
            if ([fileName isEqualToString:@""] || fileName == nil || fileName.length == 0) {
                fileName = @"Intro";
            }
            NSString *urlDownAddress = [NSString stringWithFormat:@"%@%@.mp3", MP3_URL, fileName];
            NSLog(@"fileName : %@", fileName);
            //NSLog(@"urlDownAddress : %@", urlDownAddress);
     
            [self performSelectorInBackground:@selector(timerMethod) withObject:nil];
     
            request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlDownAddress]];
            [request setDownloadDestinationPath:[DOCUMENT_DIRECTORY stringByAppendingFormat:@"/%@.mp3", fileName]];
            [request setDelegate:self];
            [request setDidFinishSelector:@selector(requestFinished:)];
            [request setDidFailSelector:@selector(requestFailed:)];
            [request startSynchronous];
        }
    }
     
    audioDownCancelButton.hidden = YES;
    detailPopupView.hidden = YES;
    multiProgress.hidden = YES;
    [activityView stopAnimating];
}

- (void)timerMethod{
    float num = 1/(float)downloadCount;
    multiProgress.progress = multiProgress.progress + num;
}

- (void)requestFailed:(ASIHTTPRequest *)request{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"네트워크 오류로 인해 다운로드를 실패하였습니다."
                                                   delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
    [alert show];
}

- (void)requestFinished:(ASIHTTPRequest *)request{
    NSLog(@"suc");
}

- (IBAction)audioMapButton:(id)sender {
    AudioGuideMapVC *audioGuideMapVC = [[AudioGuideMapVC alloc] initWithNibName:@"AudioGuideMapVC" bundle:nil];
    audioGuideMapVC.mapCount = @"2";
    audioGuideMapVC.mapArr = audioDetailListArr;
    [self.navigationController pushViewController:audioGuideMapVC animated:YES];
}

- (IBAction)audioDownCancelButton:(id)sender {
    audioDownCancelButton.hidden = YES;
    detailPopupView.hidden = YES;
    multiProgress.hidden = YES;
    
    NSFileManager * fileManager = [NSFileManager defaultManager];
    for(int i=0; i<[audioDetailListArr count]; i++){
        NSDictionary *dic = [audioDetailListArr objectAtIndex:i];
        if(![[dic objectForKey:@"mp3_file"] isEqualToString:@""]){
            NSString *fileName = [dic objectForKey:@"mp3_file"];
            NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", DOCUMENT_DIRECTORY, fileName];
            if ([fileManager fileExistsAtPath:filePath]){
                [fileManager removeItemAtPath:filePath error:nil];
            }
        }
    }
}

- (void)selectFoodImage:(UIGestureRecognizer *)gestureRecognizer{
    NSInteger index = gestureRecognizer.view.tag;
    
    NSDictionary *dic = [audioDetailFoodListArr objectAtIndex:index];
    
    AudioGuideFoodVC *audioGuideFoodVC = [[AudioGuideFoodVC alloc] initWithNibName:@"AudioGuideFoodVC" bundle:nil];
    audioGuideFoodVC.foodDic = dic;
    [self.navigationController pushViewController:audioGuideFoodVC animated:YES];
    
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [audioDetailListArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *audioDetailDic = [audioDetailListArr objectAtIndex:indexPath.row];
    if([[audioDetailDic objectForKey:@"place_name_kr"] isEqualToString:@""]){
        return 40;
    }
    return 130;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioGudioDetailCell *cell = (AudioGudioDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"AudioGudioDetailCell"];
    
    if (cell == nil){
        cell = [[AudioGudioDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AudioGudioDetailCell"];
    }
    
    [cell setBackgroundView:nil];
    [cell setBackgroundColor:[UIColor clearColor]];

    // 셀 터치 시 파란색 배경 변경 효과 방지
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *audioDetailDic = [audioDetailListArr objectAtIndex:indexPath.row];
    
    if([[audioDetailDic objectForKey:@"place_name_kr"] isEqualToString:@""]){
        cell.titleText1.text = [audioDetailDic objectForKey:@"big_title"];
        cell.titleText1.hidden = NO;
        cell.leftImage.hidden = NO;
        cell.centerImage.hidden = NO;
        cell.centerView.hidden = NO;
        cell.titleText2_sub.hidden = YES;
        cell.icon.hidden = YES;
        cell.thumbImage.hidden = YES;
        cell.titleText2.hidden = YES;
        cell.countryName.hidden = YES;
        cell.contentText.hidden = YES;
        cell.leftView.hidden = YES;
        cell.audioButton.hidden = YES;
        cell.cellSelectedBtn.hidden = YES;
    }else{
        cell.titleText1.hidden = YES;
        cell.leftImage.hidden = YES;
        cell.titleText2_sub.hidden = NO;
        cell.centerImage.hidden = YES;
        cell.centerView.hidden = YES;
        
        cell.icon.hidden = NO;
        cell.thumbImage.hidden = NO;
        cell.titleText2.hidden = NO;
        cell.countryName.hidden = NO;
        cell.contentText.hidden = NO;
        cell.leftView.hidden = NO;
        cell.audioButton.hidden = NO;
        cell.cellSelectedBtn.hidden = NO;
        
        NSString *imageName = [NSString stringWithFormat:@"%@.png", [audioDetailDic objectForKey:@"icon_small"]];
        cell.icon.image = [UIImage imageNamed:imageName];
        NSString *thumbImageName = [NSString stringWithFormat:@"%@.jpg", [audioDetailDic objectForKey:@"foto_spiegazione_1"]];
        cell.thumbImage.image = [UIImage imageNamed:thumbImageName];
        cell.titleText2.text = [audioDetailDic objectForKey:@"place_name_kr"];
        cell.titleText2_sub.text = [audioDetailDic objectForKey:@"place_name_en"];
        NSString *countryCity = [NSString stringWithFormat:@"[%@]%@", [audioDetailDic objectForKey:@"nazionale"], [audioDetailDic objectForKey:@"city_name"]];
        cell.countryName.text = countryCity;
        cell.contentText.text = [audioDetailDic objectForKey:@"described"];
        
        cell.leftView.hidden = NO;
        
        cell.cellSelectedBtn.tag = indexPath.row;
        [cell.cellSelectedBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.audioButton.tag = indexPath.row;
        [cell.audioButton addTarget:self action:@selector(audioAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 테이블 항목 터치에 대한 이벤트는 방지. 테이블 셀 위의 버튼 이벤트도 대치하기 위함.
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
}

- (void)selectAction:(UIButton*)sender{
    NSDictionary *dic = [audioDetailListArr objectAtIndex:sender.tag];
    
    AudioGuideMapVC *audioGuideMapVC = [[AudioGuideMapVC alloc] initWithNibName:@"AudioGuideMapVC" bundle:nil];
    audioGuideMapVC.mapDic = dic;
    audioGuideMapVC.mapCount = @"1";
    [self.navigationController pushViewController:audioGuideMapVC animated:YES];
    
}

- (void)audioAction:(UIButton*)sender{
    NSDictionary *dic = [audioDetailListArr objectAtIndex:sender.tag];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", DOCUMENT_DIRECTORY, [dic objectForKey:@"mp3_file"]];
    NSInteger playStopNum = 0;
    if(mplayer){
        [mplayer stop];
        mplayer = nil;
        playStopNum = 1;
    }else{
        playStopNum = 0;
    }
    
    if(playStopNum == 0){
        if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            mplayer = [[MPMoviePlayerController alloc] initWithContentURL:[NSURL fileURLWithPath:filePath]];
            [mplayer setControlStyle:MPMovieControlStyleNone];
            [mplayer.view setFrame:CGRectMake(0, 0, 0, 0)];
            [mplayer.view setBackgroundColor:[UIColor clearColor]];
            [self.view addSubview:mplayer.view];
            [mplayer play];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"오디오파일을 다운받고 실행해주세요."
                                                           delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
            [alert show];
        }
    }
}

#pragma mark -
#pragma mark AlertView Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1236){
        if(buttonIndex == 1){
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults synchronize];
            //포인트 있는지 확인
            NSLog(@"포인트 : %@" , pointStr);
            NSLog(@"my 포인트 : %@" , [defaults stringForKey:KEY_LEVEL]);
            NSString *val  = [defaults stringForKey:KEY_LEVEL];
            if ([pointStr intValue] > [val intValue]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"포인트가 부족합니다."
                                                               delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
                [alert show];
                return;
            }
            NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, AUDIO_POINT_URL];
            NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
            
            NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            NSString * params = [NSString stringWithFormat:@"self_id=%@&name=%@&point=-%@", [defaults stringForKey:KEY_INDEX], cityNameStr, pointStr];
            [urlRequest setHTTPMethod:@"POST"];
            [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
            
            NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                //NSLog(@"Response:%@ %@\n", response, error);
                NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                if (statusCode == 200) {
                    detailPopupView.hidden = NO;
                    //audioDownCancelButton.hidden = NO;
                    multiProgress.hidden = NO;
                    [activityView startAnimating];
                    
                    //[self.view bringSubviewToFront:detailPopupView];
                    [self.view bringSubviewToFront:multiProgress];
                    [self.view bringSubviewToFront:audioDownCancelButton];
                    
                    [self performSelector:@selector(audioDownInit) withObject:nil afterDelay:0.5];
                    
                    NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
                    [defaults setObject:resultValue forKey:KEY_LEVEL];
                    
                }else{
                    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"포인트가 부족합니다." preferredStyle:UIAlertControllerStyleAlert];
                    
                    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                         {}];
                    [alert addAction:ok];
                    [self presentViewController:alert animated:YES completion:nil];
                }
            }];
            [dataTask resume];
        }
    }
}

@end
