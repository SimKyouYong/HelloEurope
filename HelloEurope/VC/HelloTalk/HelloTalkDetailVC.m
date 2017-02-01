//
//  HelloTalkDetailVC.m
//  HelloEurope
//
//  Created by Joseph on 2016. 5. 1..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "HelloTalkDetailVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "HelloTalkDetailCell.h"
#import "HelloTalkListWriteVC.h"
#import "CommonUtil.h"
#import "UIView+Toast.h"

@interface HelloTalkDetailVC () <HelloTalkEditDelegate>

@end

@implementation HelloTalkDetailVC

@synthesize detailScrollView;
@synthesize comentText;
@synthesize detailDic;
@synthesize topNumber;
@synthesize countryStr;
@synthesize popupView;
@synthesize titleImage;
@synthesize titlMenuImage;
@synthesize titleBg;
@synthesize photoView;
@synthesize photoImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"Detail : %@", detailDic);
    
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
    }else if([countryStr isEqualToString:@"체코&오스트리아"] || [countryStr isEqualToString:@"체코"]){
        titleImage.image = [UIImage imageNamed:CHECKO_IMAGE];
    }else if([countryStr isEqualToString:@"크로아티아"]){
        titleImage.image = [UIImage imageNamed:CROATIA_IMAGE];
    }else if([countryStr isEqualToString:@"그외도시"]){
        titleImage.image = [UIImage imageNamed:OTHER_IMAGE];
    }
    
    if([titleBg isEqualToString:@"1"]){
        titlMenuImage.image = [UIImage imageNamed:@"mypage01_skyline"];
    }
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 40, HEIGHT_FRAME/2 - 40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(24, 22, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    [self.view  bringSubviewToFront:loadingView];
    [self.view addSubview:loadingView];
    
    popupView.hidden = NO;
    [activityView startAnimating];
    
    [self performSelector:@selector(initLoad) withObject:nil afterDelay:0.3];
    [self performSelector:@selector(scrollViewLoad) withObject:nil afterDelay:0.5];
}

// 수정 후 리스트 갱신
- (void)editSend:(NSMutableDictionary *)editDic{
    for(int i = 0; i < 10; i++){
        thumbImage[i].image = nil;
    }
    
    detailDic = editDic;
    editDetailDic = editDic;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)initLoad{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKCOMENT_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"key_index=%@", [detailDic objectForKey:@"Key_Index"]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode == 200) {
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

- (void)scrollViewLoad{
    // 스크롤 바들을 보이지 않습니다.
    detailScrollView.showsHorizontalScrollIndicator = NO;
    detailScrollView.showsVerticalScrollIndicator = NO;
    [detailScrollView setPagingEnabled:NO];
    
    iconImage = [[UIImageView alloc] initWithFrame:CGRectMake(18, 20, 27, 27)];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if([[detailDic objectForKey:@"Self_nickname"] isEqualToString:[defaults stringForKey:KEY_NAME]]){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/MY_IMG/%@", [defaults stringForKey:KEY_IMAGE]]]];
        iconImage.clipsToBounds = YES;
        iconImage.layer.cornerRadius = 13.0;
        iconImage.layer.masksToBounds = YES;
        iconImage.image = [UIImage imageWithData:imageData];
    }else{
        [iconImage setImage:[UIImage imageNamed:@"talk_detail_icon"]];
    }
    [detailScrollView addSubview:iconImage];
    
    nameText = [[UILabel alloc] initWithFrame:CGRectMake(70, 22, 100, 10)];
    [nameText setBackgroundColor:[UIColor clearColor]];
    nameText.textColor = [UIColor blackColor];
    nameText.textAlignment = NSTextAlignmentLeft;
    nameText.text = [detailDic objectForKey:@"Self_nickname"];
    nameText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    [detailScrollView addSubview:nameText];
    
    timeText = [[UILabel alloc] initWithFrame:CGRectMake(70, 34, 100, 10)];
    [timeText setBackgroundColor:[UIColor clearColor]];
    timeText.textColor = [UIColor blackColor];
    timeText.textAlignment = NSTextAlignmentLeft;
    timeText.text = [detailDic objectForKey:@"Date"];
    timeText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    [detailScrollView addSubview:timeText];
    
    tagText = [[UILabel alloc] initWithFrame:CGRectMake(5, 60, 52, 16)];
    [tagText setBackgroundColor:[UIColor clearColor]];
    tagText.textColor = [UIColor colorWithRed:110.0f/255.0f green:227.0f/255.0f blue:247.0f/255.0f alpha:1.0];
    tagText.textAlignment = NSTextAlignmentCenter;
    tagText.text = [detailDic objectForKey:@"Tag"];
    tagText.font = [UIFont fontWithName:@"Helvetica Bold" size:12.0];
    [detailScrollView addSubview:tagText];
    
    titleText = [[UILabel alloc] initWithFrame:CGRectMake(70, 60, WIDTH_FRAME - 90, 16)];
    [titleText setBackgroundColor:[UIColor clearColor]];
    titleText.textColor = [UIColor blackColor];
    titleText.textAlignment = NSTextAlignmentLeft;
    titleText.text = [NSString stringWithFormat:@"%@ %@", [detailDic objectForKey:@"City"], [detailDic objectForKey:@"Title"]];
    titleText.font = [UIFont fontWithName:@"Helvetica Bold" size:12.0];
    NSString *title = [NSString stringWithFormat:@"[%@] %@", [detailDic objectForKey:@"City"], [detailDic objectForKey:@"Title"]];
    NSMutableAttributedString *searchStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange sRange;
    
    NSArray *searchArr = [title componentsSeparatedByString:@"]"];
    NSString *searchChangedStr = [searchArr objectAtIndex:0];
    searchChangedStr = [NSString stringWithFormat:@"%@]", searchChangedStr];
    sRange = [title rangeOfString:searchChangedStr];
    [searchStr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:sRange];
    [titleText setAttributedText:searchStr];
    [detailScrollView addSubview:titleText];
    
    editButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 40, 15, 20, 5)];
    [editButton setImage:[UIImage imageNamed:@"talk_detail_edit_off"] forState:UIControlStateNormal];
    [editButton setImage:[UIImage imageNamed:@"talk_detail_edit_on"] forState:UIControlStateHighlighted];
    [editButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [detailScrollView addSubview:editButton];
    
    UIButton *editEmptyButton = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 60, 0, 50, 40)];
    [editEmptyButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [editEmptyButton setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
    [editEmptyButton addTarget:self action:@selector(editAction:) forControlEvents:UIControlEventTouchUpInside];
    [detailScrollView addSubview:editEmptyButton];
    
    emptyNum = 0;
    for(int i = 0; i < 10; i++){
        if(i == 0){
            if([[detailDic objectForKey:@"Image_url"] isEqualToString:@""]){
                emptyNum = i;
                break;
            }
        }
        if(i == 1){
            if([[detailDic objectForKey:@"Image_urlone"] isEqualToString:@""]){
                emptyNum = i;
                break;
            }
        }
        if(i == 2){
            if([[detailDic objectForKey:@"Image_urltwo"] isEqualToString:@""]){
                emptyNum = i;
                break;
            }
        }
        if(i > 2){
            NSString *urlImage = [NSString stringWithFormat:@"Image_url%ld", (long)i + 1];
            if([[detailDic objectForKey:urlImage] isEqualToString:@""]){
                emptyNum = i;
                break;
            }
        }
        emptyNum = i + 1;
    }
    
    topImageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 90, WIDTH_FRAME - 32, 200)];
    topImageScrollView.backgroundColor = [UIColor clearColor];
    [detailScrollView addSubview:topImageScrollView];
    
    imageScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(10, 300, WIDTH_FRAME - 32, 80)];
    imageScrollView.backgroundColor = [UIColor clearColor];
    [detailScrollView addSubview:imageScrollView];
    
    if(emptyNum != 0){
        [self initTopScrollViewAndPageControl:0 pageNumber:emptyNum];
        [self initScrollViewAndPageControl:0 pageNumber:emptyNum];
    }
    
    contentText = [[UILabel alloc] initWithFrame:CGRectMake(10, 390, WIDTH_FRAME - 32, 20)];
    [contentText setBackgroundColor:[UIColor clearColor]];
    contentText.textColor = [UIColor blackColor];
    contentText.textAlignment = NSTextAlignmentLeft;
    contentText.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [contentText setLineBreakMode:NSLineBreakByClipping];
    [contentText setNumberOfLines:0];
    //계산할 문자열이 차지할 공간에 제한을 둘 넓이와 높이를 정한다.
    //만약 가로나 세로의 길이가 저 수치를 넘어가면 그 이상으로 Label의 사이즈를 크게 만들지 않는다.
    CGSize constraintSize = CGSizeMake(WIDTH_FRAME - 32, 1000);
    //새로운 Label의 사이즈를 계산한다.
    //NSString 메소드를 이용하여 계산을 하며 길이 계산을 제공하는 아래 메소드를 포함 총 5개이다.
    //아래에 필요한 인자는 출력하고자 하는 문자열, 폰트크기, 제한사이즈, 줄바꿈 정책이다.
    CGSize newSize = [[detailDic objectForKey:@"Body"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByClipping];
    //위의 계산으로 얻은 사이즈를 이용해서 실제 Label에 적용할 높이를 정한다.
    //Max함수를 이용해서 새로히 얻은 높이와 본래 Label의 높이를 비교하여 높은 값을 가져온다.
    labelHeight = MAX(newSize.height, 20);
    //위에 결과로 얻은 새로운 높이를 Label에 적용한다.
    [contentText setFrame:CGRectMake(contentText.frame.origin.x, contentText.frame.origin.y, contentText.frame.size.width, labelHeight)];
    contentText.text = [detailDic objectForKey:@"Body"];
    [detailScrollView addSubview:contentText];
    
    if(topNumber == 0 || topNumber == 1 || topNumber == 4){
        textHeight = 0;
    }else if(topNumber == 2){
        textHeight = 60;
        UILabel *dayTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 410, 60, 20)];
        dayTimeLabel.textColor = [UIColor purpleColor];
        dayTimeLabel.textAlignment = NSTextAlignmentLeft;
        dayTimeLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [dayTimeLabel setNumberOfLines:0];
        [dayTimeLabel setText:@"날짜/시간 : "];
        [detailScrollView addSubview:dayTimeLabel];
        UILabel *meetPlaceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 430, 60, 20)];
        meetPlaceLabel.textColor = [UIColor purpleColor];
        meetPlaceLabel.textAlignment = NSTextAlignmentLeft;
        meetPlaceLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [meetPlaceLabel setNumberOfLines:0];
        [meetPlaceLabel setText:@"미팅 장소 : "];
        [detailScrollView addSubview:meetPlaceLabel];
        UILabel *memo = [[UILabel alloc] initWithFrame:CGRectMake(10, 450, 60, 20)];
        memo.textColor = [UIColor purpleColor];
        memo.textAlignment = NSTextAlignmentLeft;
        memo.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [memo setNumberOfLines:0];
        [memo setText:@"메   모 : "];
        [detailScrollView addSubview:memo];
        UILabel *dayTimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 410, WIDTH_FRAME - 70 - 40, 20)];
        dayTimeLabel2.textColor = [UIColor grayColor];
        dayTimeLabel2.textAlignment = NSTextAlignmentLeft;
        dayTimeLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [dayTimeLabel2 setNumberOfLines:0];
        [dayTimeLabel2 setText:[NSString stringWithFormat:@"%@ %@", [detailDic objectForKey:@"Meet_day"], [detailDic objectForKey:@"Meet_time"]]];
        [detailScrollView addSubview:dayTimeLabel2];
        UILabel *meetPlaceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 430, WIDTH_FRAME - 70 - 40, 20)];
        meetPlaceLabel2.textColor = [UIColor grayColor];
        meetPlaceLabel2.textAlignment = NSTextAlignmentLeft;
        meetPlaceLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [meetPlaceLabel2 setNumberOfLines:0];
        [meetPlaceLabel2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Meet_place"]]];
        [detailScrollView addSubview:meetPlaceLabel2];
        UILabel *memo2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 450, WIDTH_FRAME - 70 - 40, 20)];
        memo2.textColor = [UIColor grayColor];
        memo2.textAlignment = NSTextAlignmentLeft;
        memo2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [memo2 setNumberOfLines:0];
        [memo2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Meet_memo"]]];
        [detailScrollView addSubview:memo2];
    }else if(topNumber == 3){
        textHeight = 80;
        UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 410, 60, 20)];
        addressLabel.textColor = [UIColor purpleColor];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        addressLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [addressLabel setNumberOfLines:0];
        [addressLabel setText:@"주  소 : "];
        [detailScrollView addSubview:addressLabel];
        UILabel *saleTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 430, 60, 20)];
        saleTimeLabel.textColor = [UIColor purpleColor];
        saleTimeLabel.textAlignment = NSTextAlignmentLeft;
        saleTimeLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [saleTimeLabel setNumberOfLines:0];
        [saleTimeLabel setText:@"영업 시간 : "];
        [detailScrollView addSubview:saleTimeLabel];
        UILabel *menuLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 450, 60, 20)];
        menuLabel.textColor = [UIColor purpleColor];
        menuLabel.textAlignment = NSTextAlignmentLeft;
        menuLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [menuLabel setNumberOfLines:0];
        [menuLabel setText:@"추천 메뉴 : "];
        [detailScrollView addSubview:menuLabel];
        UILabel *priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 470, 60, 20)];
        priceLabel.textColor = [UIColor purpleColor];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        priceLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [priceLabel setNumberOfLines:0];
        [priceLabel setText:@"가  격 : "];
        [detailScrollView addSubview:priceLabel];
        UILabel *addressLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 410, WIDTH_FRAME - 70 - 40, 20)];
        addressLabel2.textColor = [UIColor grayColor];
        addressLabel2.textAlignment = NSTextAlignmentLeft;
        addressLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [addressLabel2 setNumberOfLines:0];
        [addressLabel2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Address"]]];
        [detailScrollView addSubview:addressLabel2];
        UILabel *saleTimeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 430, WIDTH_FRAME - 70 - 40, 20)];
        saleTimeLabel2.textColor = [UIColor grayColor];
        saleTimeLabel2.textAlignment = NSTextAlignmentLeft;
        saleTimeLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [saleTimeLabel2 setNumberOfLines:0];
        [saleTimeLabel2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Sale_st"]]];
        [detailScrollView addSubview:saleTimeLabel2];
        UILabel *menuLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 450, WIDTH_FRAME - 70 - 40, 20)];
        menuLabel2.textColor = [UIColor grayColor];
        menuLabel2.textAlignment = NSTextAlignmentLeft;
        menuLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [menuLabel2 setNumberOfLines:0];
        [menuLabel2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Menu"]]];
        [detailScrollView addSubview:menuLabel2];
        UILabel *priceLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 470, WIDTH_FRAME - 70 - 40, 20)];
        priceLabel2.textColor = [UIColor grayColor];
        priceLabel2.textAlignment = NSTextAlignmentLeft;
        priceLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [priceLabel2 setNumberOfLines:0];
        [priceLabel2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Price"]]];
        [detailScrollView addSubview:priceLabel2];
    }else if(topNumber == 5){
        textHeight = 60;
        UILabel *tourCompnayLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 410, 60, 20)];
        tourCompnayLabel.textColor = [UIColor purpleColor];
        tourCompnayLabel.textAlignment = NSTextAlignmentLeft;
        tourCompnayLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [tourCompnayLabel setNumberOfLines:0];
        [tourCompnayLabel setText:@"투어 회사 : "];
        [detailScrollView addSubview:tourCompnayLabel];
        UILabel *tourTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 430, 60, 20)];
        tourTypeLabel.textColor = [UIColor purpleColor];
        tourTypeLabel.textAlignment = NSTextAlignmentLeft;
        tourTypeLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [tourTypeLabel setNumberOfLines:0];
        [tourTypeLabel setText:@"투어 종류 : "];
        [detailScrollView addSubview:tourTypeLabel];
        UILabel *tourPrice = [[UILabel alloc] initWithFrame:CGRectMake(10, 450, 60, 20)];
        tourPrice.textColor = [UIColor purpleColor];
        tourPrice.textAlignment = NSTextAlignmentLeft;
        tourPrice.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [tourPrice setNumberOfLines:0];
        [tourPrice setText:@"투어 가격 : "];
        [detailScrollView addSubview:tourPrice];
        UILabel *tourCompnayLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 410, WIDTH_FRAME - 70 - 40, 20)];
        tourCompnayLabel2.textColor = [UIColor grayColor];
        tourCompnayLabel2.textAlignment = NSTextAlignmentLeft;
        tourCompnayLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [tourCompnayLabel2 setNumberOfLines:0];
        [tourCompnayLabel2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Tour_compy"]]];
        [detailScrollView addSubview:tourCompnayLabel2];
        UILabel *tourTypeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 430, WIDTH_FRAME - 70 - 40, 20)];
        tourTypeLabel2.textColor = [UIColor grayColor];
        tourTypeLabel2.textAlignment = NSTextAlignmentLeft;
        tourTypeLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [tourTypeLabel2 setNumberOfLines:0];
        [tourTypeLabel2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Tour_type"]]];
        [detailScrollView addSubview:tourTypeLabel2];
        UILabel *tourPrice2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 450, WIDTH_FRAME - 70 - 40, 20)];
        tourPrice2.textColor = [UIColor grayColor];
        tourPrice2.textAlignment = NSTextAlignmentLeft;
        tourPrice2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [tourPrice2 setNumberOfLines:0];
        [tourPrice2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Price"]]];
        [detailScrollView addSubview:tourPrice2];
    }else if(topNumber == 6){
        textHeight = 60;
        UILabel *roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 410, 60, 20)];
        roomTypeLabel.textColor = [UIColor purpleColor];
        roomTypeLabel.textAlignment = NSTextAlignmentLeft;
        roomTypeLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [roomTypeLabel setNumberOfLines:0];
        [roomTypeLabel setText:@"숙소 종류 : "];
        [detailScrollView addSubview:roomTypeLabel];
        UILabel *roomAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 430, 60, 20)];
        roomAddressLabel.textColor = [UIColor purpleColor];
        roomAddressLabel.textAlignment = NSTextAlignmentLeft;
        roomAddressLabel.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [roomAddressLabel setNumberOfLines:0];
        [roomAddressLabel setText:@"숙소 주소 : "];
        [detailScrollView addSubview:roomAddressLabel];
        UILabel *menu = [[UILabel alloc] initWithFrame:CGRectMake(10, 450, 60, 20)];
        menu.textColor = [UIColor purpleColor];
        menu.textAlignment = NSTextAlignmentLeft;
        menu.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [menu setNumberOfLines:0];
        [menu setText:@"추천 메뉴 : "];
        [detailScrollView addSubview:menu];
        UILabel *roomTypeLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 410, WIDTH_FRAME - 70 - 40, 20)];
        roomTypeLabel2.textColor = [UIColor grayColor];
        roomTypeLabel2.textAlignment = NSTextAlignmentLeft;
        roomTypeLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [roomTypeLabel2 setNumberOfLines:0];
        [roomTypeLabel2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Room_type"]]];
        [detailScrollView addSubview:roomTypeLabel2];
        UILabel *roomAddressLabel2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 430, WIDTH_FRAME - 70 - 40, 20)];
        roomAddressLabel2.textColor = [UIColor grayColor];
        roomAddressLabel2.textAlignment = NSTextAlignmentLeft;
        roomAddressLabel2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [roomAddressLabel2 setNumberOfLines:0];
        [roomAddressLabel2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Address"]]];
        [detailScrollView addSubview:roomAddressLabel2];
        UILabel *menu2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 450, WIDTH_FRAME - 70 - 40, 20)];
        menu2.textColor = [UIColor grayColor];
        menu2.textAlignment = NSTextAlignmentLeft;
        menu2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
        [menu2 setNumberOfLines:0];
        [menu2 setText:[NSString stringWithFormat:@"%@", [detailDic objectForKey:@"Menu"]]];
        [detailScrollView addSubview:menu2];
    }
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(10, 390 + labelHeight + textHeight + 10, WIDTH_FRAME - 32, 1)];
    lineView1.backgroundColor = [UIColor grayColor];
    [detailScrollView addSubview:lineView1];
    
    comentImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 390 + labelHeight + textHeight + 14, 15, 12)];
    comentImage.image = [UIImage imageNamed:@"talk_list_cell_icon9_off"];
    [detailScrollView addSubview:comentImage];
    
    comentCountText = [[UILabel alloc] initWithFrame:CGRectMake(30, 390 + labelHeight + textHeight + 14, 28, 12)];
    [comentCountText setBackgroundColor:[UIColor clearColor]];
    comentCountText.textColor = [UIColor blackColor];
    comentCountText.textAlignment = NSTextAlignmentLeft;
    comentCountText.text = [detailDic objectForKey:@"Comment_ea"];
    comentCountText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    [detailScrollView addSubview:comentCountText];
    
    likeImage = [[UIImageView alloc] initWithFrame:CGRectMake(60, 390 + labelHeight + textHeight + 14, 15, 12)];
    likeImage.image = [UIImage imageNamed:@"talk_list_cell_icon8_off"];
    if([[detailDic objectForKey:@"Good"] isEqualToString:@"false"]){
        likeImage.image = [UIImage imageNamed:@"talk_list_cell_icon8_on"];
    }
    [detailScrollView addSubview:likeImage];
    
    likeCount = [[UILabel alloc] initWithFrame:CGRectMake(80, 390 + labelHeight + textHeight + 14, 28, 12)];
    [likeCount setBackgroundColor:[UIColor clearColor]];
    likeCount.textColor = [UIColor blackColor];
    likeCount.textAlignment = NSTextAlignmentLeft;
    likeCount.text = [detailDic objectForKey:@"choo"];
    likeCount.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    [detailScrollView addSubview:likeCount];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(10, 390 + labelHeight + textHeight + 14 + 16, WIDTH_FRAME - 32, 1)];
    lineView2.backgroundColor = [UIColor grayColor];
    [detailScrollView addSubview:lineView2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Button Action

- (void)imageDelete{
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
    NSArray *filelist = [fileManager contentsOfDirectoryAtPath:documentPath error:NULL];
    for(int i = 0; i < [filelist count]; i++){
        NSString *fileName = [filelist objectAtIndex:i];
        NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@", DOCUMENT_DIRECTORY, PHOTO_FOLDER, fileName];
        [fileManager removeItemAtPath:filePath error:nil];
    }
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    
    [self imageDelete];
}

- (IBAction)photoButton:(id)sender {
    UIImagePickerController *photoController = [[UIImagePickerController alloc] init];
    photoController.delegate = self;
    photoController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    photoController.allowsEditing = NO;
    [self presentViewController:photoController animated:YES completion:nil];
}

// 댓글 전송
- (IBAction)sendButton:(id)sender {
    NSFileManager * fileManager = [NSFileManager defaultManager];
    NSString *documentPath = [NSString stringWithFormat:@"%@/%@/", DOCUMENT_DIRECTORY, PHOTO_FOLDER];
    NSArray *filelist = [fileManager contentsOfDirectoryAtPath:documentPath error:NULL];
    if(comentText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"글을 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        if([filelist count] != 0){
            NSString *filePath = [NSString stringWithFormat:@"%@/%@/%@", DOCUMENT_DIRECTORY, PHOTO_FOLDER, comentFileName];
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
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploaded_file\"; filename=\"%@\"\r\n", comentFileName] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[NSData dataWithData:imageData]];
            [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [request setHTTPBody:body];
            
            NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
            NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
            
            NSRange strRange;
            strRange = [returnString rangeOfString:@"success"];
            if(strRange.location != NSNotFound) {
                [self comentUpload];
            }else{
                comentFileName = @"";
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"전송 실패하였습니다." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }else{
            comentFileName = @"";
            [self comentUpload];
        }
        
        [comentText resignFirstResponder];
    }
}

- (void)comentUpload{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKCOMENT_WRITE_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"body=%@&key_index=%@&self_id=%@&self_nickname=%@&img1=%@", comentText.text, [detailDic objectForKey:@"Key_Index"], [defaults stringForKey:KEY_INDEX], [defaults stringForKey:KEY_NAME], comentFileName];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@ %@\n", response, error, data);
        if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
            NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
            if (statusCode == 200) {
                [self imageDelete];
                comentImageView.image = nil;
                
                comentText.text = @"";
                xmlArrData = [[NSMutableArray alloc] init];
                [comentTableView reloadData];
                [self initLoad];
            }
        }
    }];
    [dataTask resume];
}

- (void)connection:(NSURLConnection *)connection didSendBodyData:(NSInteger)bytesWritten totalBytesWritten:(NSInteger)totalBytesWritten totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite
{
    NSLog(@"%.2f Percent complete", (CGFloat)totalBytesWritten / (CGFloat)totalBytesExpectedToWrite * 100.0f);
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [self comentUpload];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"fail");
}

- (void)editAction:(UIButton*)sender{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];

    if([[defaults stringForKey:KEY_INDEX] isEqualToString:[detailDic objectForKey:@"Self_id"]]){
        UIActionSheet *menu = [[UIActionSheet alloc]
                               initWithTitle: @"선택하세요" delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:@"수정", @"삭제", @"취소", nil];
        [menu showInView:self.view];
    }else{
        [self.navigationController.view makeToast:@"자신의 글이 아닙니다."];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [self editButton];
    }else if(buttonIndex == 1){
        [self delButton];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)editButton {
    nameText.text = @"";
    timeText.text = @"";
    tagText.text = @"";
    titleText.text = @"";
    contentText.text = @"";
    
    BACK_NUMBER = topNumber;
    HelloTalkListWriteVC *helloTalkListWriteVC = [[HelloTalkListWriteVC alloc] initWithNibName:@"HelloTalkListWriteVC" bundle:nil];
    helloTalkListWriteVC.delegate = self;
    helloTalkListWriteVC.topNumber = topNumber;
    helloTalkListWriteVC.countryStr = countryStr;
    helloTalkListWriteVC.editStr = @"edit";
    helloTalkListWriteVC.editDic = detailDic;
    [self.navigationController pushViewController:helloTalkListWriteVC animated:YES];
}

- (void)delButton{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKDEL_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"key_index=%@", [detailDic objectForKey:@"Key_Index"]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        if(error == nil)
        {
            NSString *resultValue = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
            if([resultValue isEqualToString:@"true"]){
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"글삭제가 실패하였습니다." preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
                [alert addAction:ok];
                [self presentViewController:alert animated:YES completion:nil];
            }
        }
    }];
    [dataTask resume];
}

#pragma mark -
#pragma mark Top Image ScrollView

- (void)initTopScrollViewAndPageControl:(NSInteger)num pageNumber:(NSInteger)number{
    topImagePageCount = number;
    
    // 스크롤뷰와 페이지 컨트롤에 관련된 변수들을 초기화합니다.
    topImagePageControl.currentPage = 0;
    
    CGRect bounds = topImageScrollView.bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    
    // 정해진 부분으로 스크롤뷰를 스크롤합니다.
    [topImageScrollView scrollRectToVisible:bounds animated:NO];
    
    // 컨트롤러들을 저장할 배열을 초기화합니다.
    topControllers = [[NSMutableArray alloc]init];
    
    // 최초에 값을 넣어줄때는 배열에 Null을 넣어줍니다.
    for(int idx = 0 ; idx < number ; idx++){
        [topControllers addObject:[NSNull null]];
    }
    
    // 스크롤 뷰의 컨텐츠 사이즈를 미리 만들어둡니다.
    CGSize contentSize = CGSizeMake((WIDTH_FRAME - 32) * number, 200);
    
    UIImageView *topThumbImage[number];
    UIImage *image[number];
    
    for(int i = 0; i < number; i++){
        NSString *imageName = [self imageStr:i];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", imageName]]];
        image[i] = [[UIImage alloc] initWithData:imageData];
        
        topThumbImage[i] = [[UIImageView alloc] initWithFrame:CGRectMake((0+i) * (WIDTH_FRAME - 32), 0, WIDTH_FRAME - 32, 200)];
        topThumbImage[i].exclusiveTouch = YES;
        topThumbImage[i].multipleTouchEnabled = NO;
        topThumbImage[i].hidden = NO;
        topThumbImage[i].tag = i+1;
        topThumbImage[i].userInteractionEnabled = YES;
        topThumbImage[i].image = image[i];
        [topImageScrollView addSubview:topThumbImage[i]];
    }
    
    // 스크롤 뷰의 컨텐츠 사이즈를 설정합니다.
    [topImageScrollView setContentSize:contentSize];
    // 스크롤 뷰의 Delegate를 설정합니다. ScrollView Delegate 함수를 사용하기 위함입니다.
    [topImageScrollView setDelegate:self];
    // 스크롤 뷰의 페이징 기능을 ON합니다.
    [topImageScrollView setPagingEnabled:YES];
    // 스크롤 뷰의 Bounce를 Disabled합니다 첫 페이지와 마지막 페이지에서 애니메이션이 발생하지않습니다.
    [topImageScrollView setBounces:NO];
    [topImageScrollView setScrollsToTop:NO];
    [topImageScrollView setScrollEnabled:YES];
    
    // 스크롤 바들을 보이지 않습니다.
    topImageScrollView.showsHorizontalScrollIndicator = NO;
    topImageScrollView.showsVerticalScrollIndicator = NO;
    
    // 현재 페이지 컨트롤의 페이지 숫자와 현재 페이지를 설정합니다.
    [topImagePageControl setNumberOfPages:number];
    [topImagePageControl setCurrentPage:0];
}

#pragma mark -
#pragma mark Image ScrollView

- (void)initScrollViewAndPageControl:(NSInteger)num pageNumber:(NSInteger)number{
    imagePageCount = number;
    
    // 스크롤뷰와 페이지 컨트롤에 관련된 변수들을 초기화합니다.
    imagePageControl.currentPage = 0;
    
    CGRect bounds = imageScrollView.bounds;
    bounds.origin.x = 0;
    bounds.origin.y = 0;
    
    // 정해진 부분으로 스크롤뷰를 스크롤합니다.
    [imageScrollView scrollRectToVisible:bounds animated:NO];
    
    // 컨트롤러들을 저장할 배열을 초기화합니다.
    controllers = [[NSMutableArray alloc]init];
    
    // 최초에 값을 넣어줄때는 배열에 Null을 넣어줍니다.
    for(int idx = 0 ; idx < number ; idx++){
        [controllers addObject:[NSNull null]];
    }
    
    // 스크롤 뷰의 컨텐츠 사이즈를 미리 만들어둡니다.
    CGSize contentSize = CGSizeMake(110 * number, 80);
 
    //UIImageView *thumbImage[number];
    UIImage *image[number];
    
    for(int i = 0; i < number; i++){
        NSString *imageName = [self imageStr:i];
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", imageName]]];
        image[i] = [[UIImage alloc] initWithData:imageData];
        
        thumbImage[i] = [[UIImageView alloc] initWithFrame:CGRectMake(0+i*110, 0, 100, 80)];
        thumbImage[i].exclusiveTouch = YES;
        thumbImage[i].multipleTouchEnabled = NO;
        thumbImage[i].hidden = NO;
        thumbImage[i].tag = i+1;
        thumbImage[i].userInteractionEnabled = YES;
        thumbImage[i].image = image[i];
        [imageScrollView addSubview:thumbImage[i]];
        
        UITapGestureRecognizer *imageTab = [[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(selectPress:)];
        imageTab.numberOfTapsRequired = 1;
        imageTab.view.tag = i+1;
        [thumbImage[i] addGestureRecognizer:imageTab];
    }
    
    // 스크롤 뷰의 컨텐츠 사이즈를 설정합니다.
    [imageScrollView setContentSize:contentSize];
    // 스크롤 뷰의 Delegate를 설정합니다. ScrollView Delegate 함수를 사용하기 위함입니다.
    [imageScrollView setDelegate:self];
    // 스크롤 뷰의 페이징 기능을 ON합니다.
    [imageScrollView setPagingEnabled:YES];
    // 스크롤 뷰의 Bounce를 Disabled합니다 첫 페이지와 마지막 페이지에서 애니메이션이 발생하지않습니다.
    [imageScrollView setBounces:NO];
    [imageScrollView setScrollsToTop:NO];
    [imageScrollView setScrollEnabled:YES];
    
    // 스크롤 바들을 보이지 않습니다.
    imageScrollView.showsHorizontalScrollIndicator = NO;
    imageScrollView.showsVerticalScrollIndicator = NO;
    
    // 현재 페이지 컨트롤의 페이지 숫자와 현재 페이지를 설정합니다.
    [imagePageControl setNumberOfPages:number];
    [imagePageControl setCurrentPage:0];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if(scrollView == imageScrollView){
        // ScrollView의 드래그가 멈춘경우
        CGFloat pageHeight = CGRectGetHeight(imageScrollView.frame);
        // 현재 페이지를 구합니다. floor는 소수점 자리를 버리는 함수입니다
        NSUInteger page = floor((imageScrollView.contentOffset.x - pageHeight / imagePageCount) / pageHeight) + 1;
        // 현재 페이지를 계산된 페이지로 설정해줍니다.
        imagePageControl.currentPage = page;
    }else if(scrollView == topImageScrollView){
        // ScrollView의 드래그가 멈춘경우
        CGFloat pageHeight = CGRectGetHeight(topImageScrollView.frame);
        // 현재 페이지를 구합니다. floor는 소수점 자리를 버리는 함수입니다
        NSUInteger page = floor((topImageScrollView.contentOffset.x - pageHeight / topImagePageCount) / pageHeight) + 1;
        // 현재 페이지를 계산된 페이지로 설정해줍니다.
        topImagePageControl.currentPage = page;
    }
}

- (NSString*)imageStr:(NSInteger)index{
    NSString *imageName = @"";
    if(index == 0){
        imageName = [detailDic objectForKey:@"Image_url"];
    }else if(index == 1){
        imageName = [detailDic objectForKey:@"Image_urlone"];
    }else if(index == 2){
        imageName = [detailDic objectForKey:@"Image_urltwo"];
    }else if(index == 3){
        imageName = [detailDic objectForKey:@"Image_url4"];
    }else if(index == 4){
        imageName = [detailDic objectForKey:@"Image_url5"];
    }else if(index == 5){
        imageName = [detailDic objectForKey:@"Image_url6"];
    }else if(index == 6){
        imageName = [detailDic objectForKey:@"Image_url7"];
    }else if(index == 7){
        imageName = [detailDic objectForKey:@"Image_url8"];
    }else if(index == 8){
        imageName = [detailDic objectForKey:@"Image_url9"];
    }else if(index == 9){
        imageName = [detailDic objectForKey:@"Image_url10"];
    }
    
    return imageName;
}

- (void)selectPress:(UIGestureRecognizer *)gestureRecognizer{
    NSInteger index = gestureRecognizer.view.tag;
    
    [topImageScrollView setContentOffset:CGPointMake((WIDTH_FRAME - 32) * (index - 1), 0) animated:TRUE];
}

#pragma mark -
#pragma mark NSXMLParserDelegate method

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    xmlArrData = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    //NSLog(@"%@", xmlArrData);
    [comentTableView reloadData];
    
    NSInteger imageCount = 0;
    NSInteger tableViewHeightNum = 0;
    for(int i = 0; i < [xmlArrData count]; i++){
        NSDictionary *dic = [xmlArrData objectAtIndex:i];
        NSString *text = [dic objectForKey:@"Body"];
        CGSize constraint = CGSizeMake(WIDTH_FRAME - 20, 20000.0f);
        CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        NSInteger photoHeight = 0;
        
        if(![[dic objectForKey:@"Image_url"] isEqualToString:@""]){
            imageCount++;
            photoHeight = 80;
        }else{
            photoHeight = 20;
        }
        tableViewHeightNum = tableViewHeightNum + size.height + photoHeight;
    }
    
    comentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 390 + labelHeight + textHeight + 14 + 26 + 4, WIDTH_FRAME - 32, tableViewHeightNum) style:UITableViewStylePlain];
    comentTableView.delegate = self;
    comentTableView.dataSource = self;
    comentTableView.scrollEnabled = NO;
    comentTableView.backgroundColor = [UIColor clearColor];
    comentTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    comentTableView.showsVerticalScrollIndicator = NO;
    [detailScrollView addSubview:comentTableView];
    
    CGSize contentSize = CGSizeMake(WIDTH_FRAME - 12, comentTableView.frame.origin.y + tableViewHeightNum);
    [detailScrollView setContentSize:contentSize];
    
    [comentTableView reloadData];
    
    popupView.hidden = YES;
    loadingView.hidden = YES;
    [activityView stopAnimating];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"word"]) {
        elementType = eItem;
    }
    
    [foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (elementType != eItem)
        return;
    
    if ([elementName isEqualToString:@"Key_Index"]){
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
    }else if ([elementName isEqualToString:@"word"]) {
        [xmlArrData addObject:[NSDictionary dictionaryWithDictionary:xmlDic]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (elementType == eItem) {
        [foundValue appendString:string];
    }
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [xmlArrData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *detailCellDic = [xmlArrData objectAtIndex:indexPath.row];
    NSString *text = [detailCellDic objectForKey:@"Body"];
    CGSize constraint = CGSizeMake(WIDTH_FRAME - 20, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    NSInteger photoHeight = 0;
    
    if([[detailCellDic objectForKey:@"Image_url"] isEqualToString:@""]){
        
    }else{
        photoHeight = 60;
    }
    return size.height + photoHeight + 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HelloTalkDetailCell *cell = (HelloTalkDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"HelloTalkDetailCell"];
    
    if (cell == nil){
        cell = [[HelloTalkDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"HelloTalkDetailCell"];
    }
    
    [cell setBackgroundView:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // 셀 터치 시 파란색 배경 변경 효과 방지
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *detailCellDic = [xmlArrData objectAtIndex:indexPath.row];
    
    NSString *text = [detailCellDic objectForKey:@"Body"];
    CGSize constraint = CGSizeMake(WIDTH_FRAME - 20, 20000.0f);
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
  
    [cell.contentText setText:text];
    [cell.contentText setFrame:CGRectMake(50, 0, WIDTH_FRAME - 100, size.height*2)];
    
    cell.nameText.frame = CGRectMake(4, 10, 50, 13);
    cell.nameText.text = [detailCellDic objectForKey:@"Comment_nickname"];
    
    if(![[detailCellDic objectForKey:@"Image_url"] isEqualToString:@""]){
        cell.lineView.frame = CGRectMake(0, size.height + 20 + 50 + 2, WIDTH_FRAME, 0.5);
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [detailCellDic objectForKey:@"Image_url"]]]];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        cell.photoImage.image = image;
        cell.photoImage.hidden = NO;
        [cell.photoImage setFrame:CGRectMake(50, size.height + 20, 50, 50)];
        
        cell.maskPhotoImage.hidden = NO;
        cell.maskPhotoImage.tag = indexPath.row;
        [cell.maskPhotoImage setFrame:CGRectMake(50, size.height + 20, 50, 50)];
        [cell.maskPhotoImage addTarget:self action:@selector(maskPhoto:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        cell.lineView.frame = CGRectMake(0, size.height + 20, WIDTH_FRAME, 0.5);
        cell.photoImage.hidden = YES;
        cell.maskPhotoImage.hidden = YES;
    }

    UILongPressGestureRecognizer* longClickEvent = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longClickCell:)];
    [comentTableView addGestureRecognizer:longClickEvent];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 테이블 항목 터치에 대한 이벤트는 방지. 테이블 셀 위의 버튼 이벤트도 대치하기 위함.
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
}

// 댓글 이미지 상세화면
- (void)maskPhoto:(UIControl*)sender{
    photoView.hidden = NO;
    
    NSDictionary *dic = [xmlArrData objectAtIndex:sender.tag];
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [dic objectForKey:@"Image_url"]]]];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    photoImage.image = image;
}

// 댓글 이미지 상세화면 닫기
- (IBAction)photoViewClose:(id)sender {
    photoView.hidden = YES;
}

// 셀 롱터치시 댓글 삭제여부(본인 글만)
- (void)longClickCell:(UILongPressGestureRecognizer*)gesture {
    if (gesture.state == UIGestureRecognizerStateEnded ) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults synchronize];
        
        CGPoint currentTouchPosition = [gesture locationInView:[gesture view]];
        NSIndexPath *indexPath = [comentTableView indexPathForRowAtPoint:currentTouchPosition];
        NSDictionary *dic = [xmlArrData objectAtIndex:indexPath.row];
        
        if([[defaults stringForKey:KEY_NAME] isEqualToString:[dic objectForKey:@"Comment_nickname"]]){
            NSInteger nIndex = indexPath.row;
            
            NSDictionary *delDic = [xmlArrData objectAtIndex:nIndex];
            
            UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"삭제하시겠습니까?" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                     {}];
            UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                 {
                                     NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKCOMENT_DEL_URL];
                                     NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
                                     NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
                                     
                                     NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
                                     NSString * params = [NSString stringWithFormat:@"Main_Key=%@&Key_Index=%@", [delDic objectForKey:@"Comment_id"], [delDic objectForKey:@"Key_Index"]];
                                     [urlRequest setHTTPMethod:@"POST"];
                                     [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
                                     
                                     NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                         //NSLog(@"Response:%@ %@\n", response, error);
                                         NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                                         if (statusCode == 200) {
                                             NSString *resultValue = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                             if([resultValue isEqualToString:@"true"]){
                                                 [comentTableView reloadData];
                                                 [self initLoad];
                                                 
                                             }else{
                                                 UIAlertController * alert2 = [UIAlertController alertControllerWithTitle:@"알림" message:@"댓글 삭제가 실패하였습니다." preferredStyle:UIAlertControllerStyleAlert];
                                                 
                                                 UIAlertAction* ok2 = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                                       {}];
                                                 [alert2 addAction:ok2];
                                                 [self presentViewController:alert2 animated:YES completion:nil];
                                             }
                                         }
                                     }];
                                     [dataTask resume];
                                 }];
            [alert addAction:cancel];
            [alert addAction:ok];
            [self presentViewController:alert animated:YES completion:nil];
        }else{
            [self.navigationController.view makeToast:@"자신의 댓글이 아닙니다."];
        }
    }
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
    
    comentData = UIImageJPEGRepresentation(tempImage, 0.8);
    comentFileName = [NSString stringWithFormat:@"temp_%ld.jpg", (long)[CommonUtil getTodayTimeStamp]];
    comentFilePath = [NSString stringWithFormat:@"%@/%@/%@", DOCUMENT_DIRECTORY, PHOTO_FOLDER, comentFileName];
    
    [comentData writeToFile:comentFilePath atomically:YES];
    comentImageView = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 100, HEIGHT_FRAME - 54, 50, 50)];
    comentImageView.image = tempImage;
    [self.view addSubview:comentImageView];
    [self.view bringSubviewToFront:comentImageView];
}

#pragma mark -
#pragma mark TextField

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    NSInteger textY = 0;
    if(textField == comentText){
        if(WIDTH_FRAME == 414){
            textY = -224;
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

@end
