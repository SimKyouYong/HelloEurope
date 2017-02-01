//
//  HelloTalkListVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 7..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "HelloTalkListVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "HelloTalkListWriteVC.h"
#import "HelloTalkDetailVC.h"
#import "HelloTalkSearchVC.h"

@implementation HelloTalkListVC

@synthesize countryStr;
@synthesize talkScrollView;
@synthesize talkPageControl;
@synthesize popupView;
@synthesize topButton1;
@synthesize topButton2;
@synthesize topButton3;
@synthesize topButton4;
@synthesize topButton5;
@synthesize topButton6;
@synthesize topButton7;
@synthesize titleImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BACK_NUMBER = 0;
    
    if([countryStr isEqualToString:@"이탈리아"]){
        titleImage.image = [UIImage imageNamed:ITALIA_IMAGE];
    }else if([countryStr isEqualToString:@"프랑스"]){
        titleImage.image = [UIImage imageNamed:FRANCE_IMAGE];
    }else if([countryStr isEqualToString:@"오스트리아"]){
        titleImage.image = [UIImage imageNamed:AUSTRIA_IMAGE];
    }else if([countryStr isEqualToString:@"스페인"]){
        titleImage.image = [UIImage imageNamed:SPAIN_IMAGE];
    }else if([countryStr isEqualToString:@"독일"]){
        titleImage.image = [UIImage imageNamed:GERMANY_IMAGE];
    }else if([countryStr isEqualToString:@"스위스"]){
        titleImage.image = [UIImage imageNamed:SWISS_IMAGE];
    }else if([countryStr isEqualToString:@"런던"]){
        titleImage.image = [UIImage imageNamed:ENGIL_IMAGE];
    }else if([countryStr isEqualToString:@"체코&오스트리아"]){
        titleImage.image = [UIImage imageNamed:CHECKO_IMAGE];
    }else if([countryStr isEqualToString:@"크로아티아"]){
        titleImage.image = [UIImage imageNamed:CROATIA_IMAGE];
    }else if([countryStr isEqualToString:@"그외도시"]){
        titleImage.image = [UIImage imageNamed:OTHER_IMAGE];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 40, HEIGHT_FRAME/2 - 40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(24, 22, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    [self.view addSubview:loadingView];
    loadingView.hidden = YES;
    
    [self initScrollViewAndPageControl:BACK_NUMBER pageNumber:7];
}

- (void)loadList:(NSInteger)index{
    popupView.hidden = NO;
    loadingView.hidden = NO;
    [activityView startAnimating];
    
    if(index == 0){
        topName = @"여행스토리";
    }else if(index == 1){
        topName = @"질문";
    }else if(index == 2){
        topName = @"동행";
    }else if(index == 3){
        topName = @"맛집";
    }else if(index == 4){
        topName = @"교통";
    }else if(index == 5){
       topName = @"투어리뷰";
    }else if(index == 6){
        topName = @"숙소리뷰";
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKLIST_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"tag=%@&country=%@&self_id=%@", topName, countryStr, [defaults stringForKey:KEY_INDEX]];
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
}

#pragma mark -
#pragma mark ScrollView

- (void)initScrollViewAndPageControl:(NSInteger)num pageNumber:(NSInteger)number{
    // 스크롤뷰와 페이지 컨트롤에 관련된 변수들을 초기화합니다.
    talkPageControl.currentPage = 0;
    
    CGRect bounds = talkScrollView.bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    
    // 정해진 부분으로 스크롤뷰를 스크롤합니다.
    [talkScrollView scrollRectToVisible:bounds animated:NO];
    
    // 컨트롤러들을 저장할 배열을 초기화합니다.
    controllers = [[NSMutableArray alloc]init];
    
    // 최초에 값을 넣어줄때는 배열에 Null을 넣어줍니다.
    for(int idx = 0 ; idx < number ; idx++){
        [controllers addObject:[NSNull null]];
    }
    
    // 스크롤 뷰의 컨텐츠 사이즈를 미리 만들어둡니다.
    CGSize contentSize = CGSizeMake(talkScrollView.frame.size.width * 7, HEIGHT_FRAME - 100);
    talkListView1 = [[TalkListView1 alloc] initWithFrame:CGRectMake(0, 0, talkScrollView.frame.size.width, HEIGHT_FRAME - 100)];
    talkListView1.delegate = self;
    [talkScrollView addSubview:talkListView1];
    
    talkListView2 = [[TalkListView2 alloc] initWithFrame:CGRectMake(WIDTH_FRAME * 1, 0, talkScrollView.frame.size.width, HEIGHT_FRAME - 100)];
    talkListView2.delegate = self;
    [talkScrollView addSubview:talkListView2];
    
    talkListView3 = [[TalkListView3 alloc] initWithFrame:CGRectMake(WIDTH_FRAME * 2, 0, talkScrollView.frame.size.width, HEIGHT_FRAME - 100)];
    talkListView3.delegate = self;
    [talkScrollView addSubview:talkListView3];
    
    talkListView4 = [[TalkListView4 alloc] initWithFrame:CGRectMake(WIDTH_FRAME * 3, 0, talkScrollView.frame.size.width, HEIGHT_FRAME - 100)];
    talkListView4.delegate = self;
    [talkScrollView addSubview:talkListView4];
    
    talkListView5 = [[TalkListView5 alloc] initWithFrame:CGRectMake(WIDTH_FRAME * 4, 0, talkScrollView.frame.size.width, HEIGHT_FRAME - 100)];
    talkListView5.delegate = self;
    [talkScrollView addSubview:talkListView5];
    
    talkListView6 = [[TalkListView6 alloc] initWithFrame:CGRectMake(WIDTH_FRAME * 5, 0, talkScrollView.frame.size.width, HEIGHT_FRAME - 100)];
    talkListView6.delegate = self;
    [talkScrollView addSubview:talkListView6];
    
    talkListView7 = [[TalkListView7 alloc] initWithFrame:CGRectMake(WIDTH_FRAME * 6, 0, talkScrollView.frame.size.width, HEIGHT_FRAME - 100)];
    talkListView7.delegate = self;
    [talkScrollView addSubview:talkListView7];
    
    // 스크롤 뷰의 컨텐츠 사이즈를 설정합니다.
    [talkScrollView setContentSize:contentSize];
    // 스크롤 뷰의 Delegate를 설정합니다. ScrollView Delegate 함수를 사용하기 위함입니다.
    [talkScrollView setDelegate:self];
    // 스크롤 뷰의 페이징 기능을 ON합니다.
    [talkScrollView setPagingEnabled:YES];
    // 스크롤 뷰의 Bounce를 Disabled합니다 첫 페이지와 마지막 페이지에서 애니메이션이 발생하지않습니다.
    [talkScrollView setBounces:NO];
    [talkScrollView setScrollsToTop:NO];
    [talkScrollView setScrollEnabled:YES];
    
    // 스크롤 바들을 보이지 않습니다.
    talkScrollView.showsHorizontalScrollIndicator = NO;
    talkScrollView.showsVerticalScrollIndicator = NO;
    
    // 현재 페이지 컨트롤의 페이지 숫자와 현재 페이지를 설정합니다.
    [talkPageControl setNumberOfPages:number];
    [talkPageControl setCurrentPage:0];
    
    [self setTopImage:BACK_NUMBER];
    [talkScrollView setContentOffset:CGPointMake(talkScrollView.frame.size.width * BACK_NUMBER, 0) animated:TRUE];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // ScrollView의 드래그가 멈춘경우
    CGFloat pageHeight = CGRectGetHeight(talkScrollView.frame);
    // 현재 페이지를 구합니다. floor는 소수점 자리를 버리는 함수입니다
    NSUInteger page = floor((talkScrollView.contentOffset.x - pageHeight / 7) / pageHeight) + 1;
    // 현재 페이지를 계산된 페이지로 설정해줍니다.
    talkPageControl.currentPage = page;
    
    topNum = talkPageControl.currentPage;
    [self loadList:talkPageControl.currentPage];
    [self setTopImage:talkPageControl.currentPage];
}

#pragma mark -
#pragma mark Button Action

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)topButton1:(id)sender {
    [self setTopImage:0];
    [talkScrollView setContentOffset:CGPointMake(0, 0) animated:TRUE];
}

- (IBAction)topButton2:(id)sender {
    [self setTopImage:1];
    [talkScrollView setContentOffset:CGPointMake(talkScrollView.frame.size.width * 1, 0) animated:TRUE];
}

- (IBAction)topButton3:(id)sender {
    [self setTopImage:2];
    [talkScrollView setContentOffset:CGPointMake(talkScrollView.frame.size.width * 2, 0) animated:TRUE];
}

- (IBAction)topButton4:(id)sender {
    [self setTopImage:3];
    [talkScrollView setContentOffset:CGPointMake(talkScrollView.frame.size.width  * 3, 0) animated:TRUE];
}

- (IBAction)topButton5:(id)sender {
    [self setTopImage:4];
    [talkScrollView setContentOffset:CGPointMake(talkScrollView.frame.size.width * 4, 0) animated:TRUE];
}

- (IBAction)topButton6:(id)sender {
    [self setTopImage:5];
    [talkScrollView setContentOffset:CGPointMake(talkScrollView.frame.size.width  * 5, 0) animated:TRUE];
}

- (IBAction)topButton7:(id)sender {
    [self setTopImage:6];
    [talkScrollView setContentOffset:CGPointMake(talkScrollView.frame.size.width * 6, 0) animated:TRUE];
}

- (IBAction)writeButton:(id)sender {
    BACK_NUMBER = topNum;
    HelloTalkListWriteVC *helloTalkListWriteVC = [[HelloTalkListWriteVC alloc] initWithNibName:@"HelloTalkListWriteVC" bundle:nil];
    helloTalkListWriteVC.topNumber = topNum;
    helloTalkListWriteVC.countryStr = countryStr;
    [self.navigationController pushViewController:helloTalkListWriteVC animated:YES];
}

// 정렬(최신글, 좋아요)
- (IBAction)sortButton:(id)sender {
    UIActionSheet *menu = [[UIActionSheet alloc]
                           initWithTitle: @"선택하세요" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"최신글", @"좋아요", @"취소", nil];
    [menu showInView:self.view];
}

// 검색
- (IBAction)searchButton:(id)sender {
    HelloTalkSearchVC *helloTalkSearchVC = [[HelloTalkSearchVC alloc] initWithNibName:@"HelloTalkSearchVC" bundle:nil];
    helloTalkSearchVC.searchCountryStr = countryStr;
    helloTalkSearchVC.searchTopNumber = topNum;
    [self.navigationController pushViewController:helloTalkSearchVC animated:YES];
}

- (void)setTopImage:(NSInteger)index{
    topNum = index;
    
    [self loadList:index];
    
    [topButton1 setImage:[UIImage imageNamed:@"talk_btn_01_off"] forState:UIControlStateNormal];
    [topButton2 setImage:[UIImage imageNamed:@"talk_btn_02_off"] forState:UIControlStateNormal];
    [topButton3 setImage:[UIImage imageNamed:@"talk_btn_03_off"] forState:UIControlStateNormal];
    [topButton4 setImage:[UIImage imageNamed:@"talk_btn_04_off"] forState:UIControlStateNormal];
    [topButton5 setImage:[UIImage imageNamed:@"talk_btn_05_off"] forState:UIControlStateNormal];
    [topButton6 setImage:[UIImage imageNamed:@"talk_btn_06_off"] forState:UIControlStateNormal];
    [topButton7 setImage:[UIImage imageNamed:@"talk_btn_07_off"] forState:UIControlStateNormal];
    
    if(index == 0){
        [topButton1 setImage:[UIImage imageNamed:@"talk_btn_01_on"] forState:UIControlStateNormal];
    }else if(index == 1){
        [topButton2 setImage:[UIImage imageNamed:@"talk_btn_02_on"] forState:UIControlStateNormal];
    }else if(index == 2){
        [topButton3 setImage:[UIImage imageNamed:@"talk_btn_03_on"] forState:UIControlStateNormal];
    }else if(index == 3){
        [topButton4 setImage:[UIImage imageNamed:@"talk_btn_04_on"] forState:UIControlStateNormal];
    }else if(index == 4){
        [topButton5 setImage:[UIImage imageNamed:@"talk_btn_05_on"] forState:UIControlStateNormal];
    }else if(index == 5){
        [topButton6 setImage:[UIImage imageNamed:@"talk_btn_06_on"] forState:UIControlStateNormal];
    }else if(index == 6){
        [topButton7 setImage:[UIImage imageNamed:@"talk_btn_07_on"] forState:UIControlStateNormal];
    }
}

#pragma mark -
#pragma mark NSXMLParserDelegate method

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    // Initialize the neighbours data array.
    xmlArrData = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    BACK_NUMBER = topNum;
    
    if(topNum == 0){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView1" object:xmlArrData userInfo:nil];
    }else if(topNum == 1){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView2" object:xmlArrData userInfo:nil];
    }else if(topNum == 2){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView3" object:xmlArrData userInfo:nil];
    }else if(topNum == 3){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView4" object:xmlArrData userInfo:nil];
    }else if(topNum == 4){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView5" object:xmlArrData userInfo:nil];
    }else if(topNum == 5){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView6" object:xmlArrData userInfo:nil];
    }else if(topNum == 6){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView7" object:xmlArrData userInfo:nil];
    }
    
    popupView.hidden = YES;
    loadingView.hidden = YES;
    [activityView stopAnimating];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"word"]) {
        elementType = etItem;
    }
    
    [foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (elementType != etItem)
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
    if (elementType == etItem) {
        [foundValue appendString:string];
    }
}

#pragma mark -
#pragma mark Delegate Method

- (void)selectDic1:(NSMutableDictionary *)dic{
    HelloTalkDetailVC *helloTalkDetailVC = [[HelloTalkDetailVC alloc] initWithNibName:@"HelloTalkDetailVC" bundle:nil];
    helloTalkDetailVC.detailDic = dic;
    helloTalkDetailVC.topNumber = topNum;
    helloTalkDetailVC.countryStr = countryStr;
    [self.navigationController pushViewController:helloTalkDetailVC animated:YES];
}

- (void)tableReload1:(NSInteger)index{
    [self loadList:0];
}

- (void)selectDic2:(NSMutableDictionary *)dic{
    HelloTalkDetailVC *helloTalkDetailVC = [[HelloTalkDetailVC alloc] initWithNibName:@"HelloTalkDetailVC" bundle:nil];
    helloTalkDetailVC.detailDic = dic;
    helloTalkDetailVC.topNumber = topNum;
    helloTalkDetailVC.countryStr = countryStr;
    [self.navigationController pushViewController:helloTalkDetailVC animated:YES];
}

- (void)tableReload2:(NSInteger)index{
    [self loadList:1];
}

- (void)selectDic3:(NSMutableDictionary *)dic{
    HelloTalkDetailVC *helloTalkDetailVC = [[HelloTalkDetailVC alloc] initWithNibName:@"HelloTalkDetailVC" bundle:nil];
    helloTalkDetailVC.detailDic = dic;
    helloTalkDetailVC.topNumber = topNum;
    helloTalkDetailVC.countryStr = countryStr;
    [self.navigationController pushViewController:helloTalkDetailVC animated:YES];
}

- (void)tableReload3:(NSInteger)index{
    [self loadList:2];
}

- (void)selectDic4:(NSMutableDictionary *)dic{
    HelloTalkDetailVC *helloTalkDetailVC = [[HelloTalkDetailVC alloc] initWithNibName:@"HelloTalkDetailVC" bundle:nil];
    helloTalkDetailVC.detailDic = dic;
    helloTalkDetailVC.topNumber = topNum;
    helloTalkDetailVC.countryStr = countryStr;
    [self.navigationController pushViewController:helloTalkDetailVC animated:YES];
}

- (void)tableReload4:(NSInteger)index{
    [self loadList:3];
}

- (void)selectDic5:(NSMutableDictionary *)dic{
    HelloTalkDetailVC *helloTalkDetailVC = [[HelloTalkDetailVC alloc] initWithNibName:@"HelloTalkDetailVC" bundle:nil];
    helloTalkDetailVC.detailDic = dic;
    helloTalkDetailVC.topNumber = topNum;
    helloTalkDetailVC.countryStr = countryStr;
    [self.navigationController pushViewController:helloTalkDetailVC animated:YES];
}

- (void)tableReload5:(NSInteger)index{
    [self loadList:4];
}

- (void)selectDic6:(NSMutableDictionary *)dic{
    HelloTalkDetailVC *helloTalkDetailVC = [[HelloTalkDetailVC alloc] initWithNibName:@"HelloTalkDetailVC" bundle:nil];
    helloTalkDetailVC.detailDic = dic;
    helloTalkDetailVC.topNumber = topNum;
    helloTalkDetailVC.countryStr = countryStr;
    [self.navigationController pushViewController:helloTalkDetailVC animated:YES];
}

- (void)tableReload6:(NSInteger)index{
    [self loadList:5];
}

- (void)selectDic7:(NSMutableDictionary *)dic{
    HelloTalkDetailVC *helloTalkDetailVC = [[HelloTalkDetailVC alloc] initWithNibName:@"HelloTalkDetailVC" bundle:nil];
    helloTalkDetailVC.detailDic = dic;
    helloTalkDetailVC.topNumber = topNum;
    helloTalkDetailVC.countryStr = countryStr;
    [self.navigationController pushViewController:helloTalkDetailVC animated:YES];
}

- (void)tableReload7:(NSInteger)index{
    [self loadList:6];
}

#pragma mark -
#pragma mark UIActionSheet

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        if(topNum == 0){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView1" object:xmlArrData userInfo:nil];
        }else if(topNum == 1){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView2" object:xmlArrData userInfo:nil];
        }else if(topNum == 2){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView3" object:xmlArrData userInfo:nil];
        }else if(topNum == 3){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView4" object:xmlArrData userInfo:nil];
        }else if(topNum == 4){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView5" object:xmlArrData userInfo:nil];
        }else if(topNum == 5){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView6" object:xmlArrData userInfo:nil];
        }else if(topNum == 6){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView7" object:xmlArrData userInfo:nil];
        }
    }else if(buttonIndex == 1){
        if(topNum == 0){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView1SortChoo" object:xmlArrData userInfo:nil];
        }else if(topNum == 1){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView2SortChoo" object:xmlArrData userInfo:nil];
        }else if(topNum == 2){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView3SortChoo" object:xmlArrData userInfo:nil];
        }else if(topNum == 3){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView4SortChoo" object:xmlArrData userInfo:nil];
        }else if(topNum == 4){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView5SortChoo" object:xmlArrData userInfo:nil];
        }else if(topNum == 5){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView6SortChoo" object:xmlArrData userInfo:nil];
        }else if(topNum == 6){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"talkListView7SortChoo" object:xmlArrData userInfo:nil];
        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end