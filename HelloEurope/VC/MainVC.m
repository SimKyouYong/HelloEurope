//
//  MainVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 16..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MainVC.h"
#import "DrawerNavigation.h"
#import "IntroView.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "LoginVC.h"
#import "MemberAgreeVC.h"
#import "YSLContainerViewController.h"
#import "HelloTalkVC.h"
#import "AudioGuideVC.h"
#import "EuropePassVC.h"
#import "EuropeFoodCouponVC.h"

@interface MainVC () <IntroViewDelegate, YSLContainerViewControllerDelegate, helloTalkDelegate, audioDelegate, europePassDelegate, europeFoodDelegate>
@property IntroView *introView;
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation MainVC

@synthesize sortButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popupViewY:) name:@"popupViewY" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(popupViewN:) name:@"popupViewN" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainButton:) name:@"mainSortButtonNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainButtonHidden:) name:@"mainSortButtonHiddenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(adNoti:) name:@"adNotification" object:nil];
    
    HelloTalkVC *helloTalkVC = [[HelloTalkVC alloc] initWithNibName:@"HelloTalkVC" bundle:nil];
    helloTalkVC.delegate = self;
    helloTalkVC.title = @"main_top_menu_01_on";
    
    AudioGuideVC *audioGuideVC = [[AudioGuideVC alloc] initWithNibName:@"AudioGuideVC" bundle:nil];
    audioGuideVC.delegate = self;
    audioGuideVC.title = @"main_top_menu_02_off";

    EuropePassVC *europePassVC = [[EuropePassVC alloc] initWithNibName:@"EuropePassVC" bundle:nil];
    europePassVC.delegate = self;
    europePassVC.title = @"main_top_menu_03_off";

    EuropeFoodCouponVC *europeFoodCouponVC = [[EuropeFoodCouponVC alloc] initWithNibName:@"EuropeFoodCouponVC" bundle:nil];
    europeFoodCouponVC.delegate = self;
    europeFoodCouponVC.title = @"main_top_menu_04_off";

    // ContainerView
    float statusHeight = 50;//[[UIApplication sharedApplication] statusBarFrame].size.height;
    float navigationHeight = 0;//self.navigationController.navigationBar.frame.size.height;
    
    YSLContainerViewController *containerVC = [[YSLContainerViewController alloc]initWithControllers:@[helloTalkVC,audioGuideVC,europePassVC,europeFoodCouponVC]
                                                                                        topBarHeight:statusHeight + navigationHeight
                                                                                parentViewController:self];
    containerVC.delegate = self;
    [self.view addSubview:containerVC.view];
    [self.view sendSubviewToBack:containerVC.view];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    popupView = [[PopupView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
    [self.view bringSubviewToFront:popupView];
    [self.view addSubview:popupView];
    popupView.hidden = YES;
    
    todayStr = [self getToday];
    
    bottomAdView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_FRAME, WIDTH_FRAME, 70)];
    bottomAdView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomAdView];
    bottomAdView.hidden = YES;
    
    bottomBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, 70)];
    [bottomAdView addSubview:bottomBgView];
    
    bottomButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, 70)];
    bottomButton.backgroundColor = [UIColor clearColor];
    [bottomButton addTarget:self action:@selector(adSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    [bottomAdView addSubview:bottomButton];
    
    BOTTOM_AD_CHECK = @"0";
    
    if([defaults stringForKey:TODAY_CHECK].length == 0 || ![[defaults stringForKey:TODAY_CHECK] isEqualToString:todayStr]){
        self.introView = [[IntroView alloc] initWithFrame:CGRectMake(0, 0, WIDTH_FRAME, HEIGHT_FRAME)];
        self.introView.delegate = self;
        self.introView.backgroundColor = [UIColor blackColor];
        if(LOGIN_CHECK != 1){
            [self.view addSubview:self.introView];
            
            // 인트로 화면 오늘 하루 볼껀지 체크
            bottomTodayCheck = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT_FRAME - 50, WIDTH_FRAME, 50)];
            bottomTodayCheck.backgroundColor = [UIColor colorWithRed:(211/255.0) green:(211/255.0) blue:(211/255.0) alpha:1];
            [self.view addSubview:bottomTodayCheck];
            
            checkButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
            [checkButton setBackgroundImage:[UIImage imageNamed:@"intro_chk_off"] forState:UIControlStateNormal];
            [checkButton addTarget:self action:@selector(checkAction:) forControlEvents:UIControlEventTouchUpInside];
            [bottomTodayCheck addSubview:checkButton];
            
            UILabel *titleText = [[UILabel alloc] initWithFrame:CGRectMake(46, 0, 150, 50)];
            [titleText setBackgroundColor:[UIColor clearColor]];
            titleText.textColor = [UIColor blackColor];//[UIColor colorWithRed:(85/255.0) green:(194/255.0) blue:(193/255.0) alpha:1];
            titleText.textAlignment = NSTextAlignmentLeft;
            titleText.text = @"오늘 하루 그만 보기";
            titleText.font = [UIFont fontWithName:@"Helvetica Bold" size:15.0];
            [bottomTodayCheck addSubview:titleText];
            
            UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 50, 0, 50, 50)];
            [closeButton setTitle:@"닫기" forState:UIControlStateNormal];
            [closeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            closeButton.titleLabel.font = [UIFont fontWithName:@"Helvetica Bold" size:15.0];
            [closeButton addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
            [bottomTodayCheck addSubview:closeButton];
        }else{
            [self adURLRequest];
        }
    }else{
        if(LOGIN_CHECK != 1){
            if([[defaults stringForKey:TODAY_CHECK] isEqualToString:todayStr]){
                self.introView.hidden = YES;
                [self loginButtonPressed];
            }
        }else{
            [self adURLRequest];
        }
    }
}

#pragma mark -
#pragma mark YSLContainerViewControllerDelegate

- (void)containerViewItemIndex:(NSInteger)index currentController:(UIViewController *)controller{
    NSLog(@"current Index : %ld",(long)index);
    NSLog(@"current controller : %@",controller);
    [controller viewWillAppear:YES];
    sortButton.hidden = YES;
    
    if(index == 2){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"europePassNotification" object:nil userInfo:nil];
        sortButton.hidden = NO;
        SORT_TOP_NUMBER = @"2";
    }else if(index == 3){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"europeFoodNotification" object:nil userInfo:nil];
        sortButton.hidden = NO;
        SORT_TOP_NUMBER = @"3";
    }
    
    [self adUpCommon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuAction:(id)sender {
    [self.rootNav drawerToggle];
}

#pragma mark -
#pragma mark Intro Delegate

- (void)noLoginButtonPressed{
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
}

- (void)loginButtonPressed{
    bottomTodayCheck.hidden = YES;
    
    LoginVC *_loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginVC"];
    [self.rootNav pushViewController:_loginVC animated:NO];
    
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.introView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.introView removeFromSuperview];
    }];
}

- (void)memberJoinButtonPressed{
    bottomTodayCheck.hidden = YES;
    
    MemberAgreeVC *_memberAgreeVC = [self.storyboard instantiateViewControllerWithIdentifier:@"memberAgreeVC"];
    [self.rootNav pushViewController:_memberAgreeVC animated:YES];
    
    //SKY 회원가입 동의 화면에서 취소 누르면 로긴도 안하고 메인화면으로 이동하는 문제 생김
//    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.introView.alpha = 0;
//    } completion:^(BOOL finished) {
//        //[self.introView removeFromSuperview];
//    }];
}

- (void)popupViewY:(NSNotification *)noti{
    popupView.hidden = NO;
}

- (void)popupViewN:(NSNotification *)noti{
    popupView.hidden = YES;
}

- (void)mainButton:(NSNotification *)noti{
    sortButton.hidden = NO;
}

- (void)mainButtonHidden:(NSNotification *)noti{
    sortButton.hidden = YES;
}

#pragma mark -
#pragma mark Intro Today Check

- (void)checkAction:(UIButton*)sender{
    UIButton *button = (UIButton *) sender;
    button.selected = !button.selected;
    
    if(button.selected == 1){
        [checkButton setBackgroundImage:[UIImage imageNamed:@"intro_chk_on"] forState:UIControlStateNormal];
    }else{
        [checkButton setBackgroundImage:[UIImage imageNamed:@"intro_chk_off"] forState:UIControlStateNormal];
    }
}

- (void)closeAction{
    if(checkButton.selected == 1){
        [defaults setObject:todayStr forKey:TODAY_CHECK];
    }
    
    [self loginButtonPressed];
}

- (NSString *)_getDateWithDateFormat:(NSString *)format
{
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    
    return [dateFormatter stringFromDate:date];
}

- (NSString*)getToday{
    return [self _getDateWithDateFormat:@"yyyy.MM.dd"];
}

// 유럽패스, 쿠폰 정렬(나라)
- (IBAction)sortButton:(id)sender {
    UIActionSheet *menu = [[UIActionSheet alloc]
                           initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"이탈리아", @"프랑스", @"스페인", @"오스트리아", @"영국", @"독일", @"스위스", @"체코", @"헝가리", @"크로아티아", @"슬로베니아", @"취소", nil];
    [menu showInView:self.view];
}

#pragma mark -
#pragma mark UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:@"%ld", buttonIndex] forKey:@"buttonIndex"];
    
    if([SORT_TOP_NUMBER isEqualToString:@"2"]){
        
    }else if([SORT_TOP_NUMBER isEqualToString:@"3"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"europeFoodSortNotification" object:nil userInfo:userInfo];
    }
}

#pragma mark -
#pragma mark Bottom AD delegate

- (void)adURLRequest{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, AD_POPUP_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"POST"];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
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
}

- (void)adNoti:(NSNotification *)noti{
    [self adUpCommon];
}

- (void)adUpCommon{
    BOTTOM_AD_CHECK = @"1";
    
    bottomAdView.hidden = NO;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    bottomAdView.frame = CGRectMake(0, HEIGHT_FRAME - 70, WIDTH_FRAME, 70);
    [UIView commitAnimations];
}

- (void)adDownCommon{
    BOTTOM_AD_CHECK = @"0";
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.5];
    bottomAdView.frame = CGRectMake(0, HEIGHT_FRAME, WIDTH_FRAME, 70);
    [UIView commitAnimations];
}

- (void)helloTalkAdHidden{
    [self adDownCommon];
}

- (void)audioAdHidden{
    [self adDownCommon];
}

- (void)europePassAdHidden{
    [self adDownCommon];
}

- (void)europeFoodAdHidden{
    [self adDownCommon];
}

- (void)adSelectAction:(UIButton*)sender{
    NSDictionary *dic = [xmlArrData objectAtIndex:0];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[dic objectForKey:@"URL"]]];
}

#pragma mark -
#pragma mark NSXMLParserDelegate method

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    // Initialize the neighbours data array.
    xmlArrData = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSDictionary *dic = [xmlArrData objectAtIndex:0];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/AD_IMG/%@", [dic objectForKey:@"IMG"]]]];
    bottomBgView.image = [UIImage imageWithData:imageData];
    [self adUpCommon];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"word"]) {
        elementType = eADItem;
    }
    
    [foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (elementType != eADItem)
        return;
    
    if ([elementName isEqualToString:@"TYPE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"IMG"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"URL"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"word"]) {
        [xmlArrData addObject:[NSDictionary dictionaryWithDictionary:xmlDic]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (elementType == eADItem) {
        [foundValue appendString:string];
    }
}

@end
