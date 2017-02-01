//
//  EuropeFoodCouponVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "EuropeFoodCouponVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "EuropeFoodCouponCell.h"
#import "EurepeFoodCoupenDetailVC.h"

@interface EuropeFoodCouponVC ()

@end

@implementation EuropeFoodCouponVC

@synthesize buttonView;
@synthesize europeFoodTableView;
@synthesize delegate;

- (void)europeFood:(NSNotification *)noti
{
    SORT_TOP_NUMBER = @"3";
    
    tagStr = @"레스토랑/코스요리";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mainSortButtonNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"adNotification" object:nil userInfo:nil];
    
    [self performSelector:@selector(initLoad) withObject:nil afterDelay:0.5f];
}

- (void)europeFoodSort:(NSNotification *)noti{
    NSDictionary *userInfo = noti.userInfo;
    
    NSString *countryStr = @"";
    
    if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"0"]){
        countryStr = @"이탈리아";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"1"]){
        countryStr = @"프랑스";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"2"]){
        countryStr = @"스페인";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"3"]){
        countryStr = @"오스트리아";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"4"]){
        countryStr = @"영국";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"5"]){
        countryStr = @"독일";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"6"]){
        countryStr = @"스위스";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"7"]){
        countryStr = @"체코";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"8"]){
        countryStr = @"헝가리";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"9"]){
        countryStr = @"크로아티아";
    }else if([[userInfo objectForKey:@"buttonIndex"] isEqualToString:@"10"]){
        countryStr = @"슬로베니아";
    }
    
    tableListArr = [[NSMutableArray alloc] init];
    
    for(int i = 0; i < [xmlArrData count]; i++){
        NSDictionary *dic = [xmlArrData objectAtIndex:i];
        NSRange countryRange = [[dic objectForKey:@"COUNTRY"] rangeOfString:countryStr options:NSCaseInsensitiveSearch];
        if(countryRange.location != NSNotFound){
            [tableListArr addObject:[xmlArrData objectAtIndex:i]];
        }
    }
    
    [europeFoodTableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:@"europeFoodSortNotification" name:nil object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(europeFood:) name:@"europeFoodNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(europeFoodSort:) name:@"europeFoodSortNotification" object:nil];
    
    topButton1 = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_FRAME/2)/2 - 39, 6, 78, 75)];
    [topButton1 setImage:[UIImage imageNamed:@"coupon_main_btn01_on"] forState:UIControlStateNormal];
    [topButton1 setImage:[UIImage imageNamed:@"coupon_main_btn01_off"] forState:UIControlStateHighlighted];
    [topButton1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topButton1 addTarget:self action:@selector(topButton1Action:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:topButton1];
    
    topButton2 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 39, 6, 78, 75)];
    [topButton2 setImage:[UIImage imageNamed:@"coupon_main_btn02_on"] forState:UIControlStateNormal];
    [topButton2 setImage:[UIImage imageNamed:@"coupon_main_btn02_off"] forState:UIControlStateHighlighted];
    [topButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topButton2 addTarget:self action:@selector(topButton2Action:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:topButton2];
    
    topButton3 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 + (WIDTH_FRAME/2)/2 - 39, 6, 78, 75)];
    [topButton3 setImage:[UIImage imageNamed:@"coupon_main_btn03_on"] forState:UIControlStateNormal];
    [topButton3 setImage:[UIImage imageNamed:@"coupon_main_btn03_off"] forState:UIControlStateHighlighted];
    [topButton3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [topButton3 addTarget:self action:@selector(topButton3Action:) forControlEvents:UIControlEventTouchUpInside];
    [buttonView addSubview:topButton3];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    tagStr = @"레스토랑/코스요리";
    [self initLoad];
}

- (void)initLoad{
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 40, HEIGHT_FRAME/2 - 40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(24, 22, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    [self.view addSubview:loadingView];
    
    loadingView.hidden = NO;
    [activityView startAnimating];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, EUROPEFOOD_COUPON_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"tag=%@", tagStr];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)topButton1Action:(UIButton*)sernder{
    tagStr = @"레스토랑/코스요리";
    [self initLoad];
}

- (void)topButton2Action:(UIButton*)sernder{
    tagStr = @"커피/음료/디저트";
    [self initLoad];
}

- (void)topButton3Action:(UIButton*)sernder{
    tagStr = @"피자/버거/치킨";
    [self initLoad];
}

#pragma mark -
#pragma mark NSXMLParserDelegate method

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    xmlArrData = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    loadingView.hidden = YES;
    [activityView stopAnimating];
    
    tableListArr = [[NSMutableArray alloc] init];
    tableListArr = xmlArrData;
    
    [europeFoodTableView reloadData];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    loadingView.hidden = YES;
    [activityView stopAnimating];
    
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"word"]) {
        elementType = foodItem;
    }
    
    [foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (elementType != foodItem)
        return;

    if ([elementName isEqualToString:@"KEY_INDEX"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"TYPE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"COUNTRY"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"CITY"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"R_NAME"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"H_NAME"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"ADDRESS"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"PHONE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"TIME"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"FEATURE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"MENU"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"PRICE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"LONGTIME"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"SALE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"BOON"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"LATITUDE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"HARDNESS"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"IMG1"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"IMG2"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"IMG3"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"word"]) {
        [xmlArrData addObject:[NSDictionary dictionaryWithDictionary:xmlDic]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (elementType == foodItem) {
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
    return [tableListArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    EuropeFoodCouponCell *cell = (EuropeFoodCouponCell *)[tableView dequeueReusableCellWithIdentifier:@"EuropeFoodCouponCell"];
    
    if (cell == nil){
        cell = [[EuropeFoodCouponCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"EuropeFoodCouponCell"];
    }
    
    [cell setBackgroundView:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // 셀 터치 시 파란색 배경 변경 효과 방지
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *foodDic = [tableListArr objectAtIndex:indexPath.row];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/Food_IMG/%@", [foodDic objectForKey:@"IMG1"]]]];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    cell.photoImage.image = image;
    
    NSString *titleText = [NSString stringWithFormat:@"[%@] %@", [foodDic objectForKey:@"CITY"], [foodDic objectForKey:@"R_NAME"]];
    cell.nameText.text = titleText;
    cell.contentText.text = [foodDic objectForKey:@"MENU"];
    cell.timeText.text = [NSString stringWithFormat:@"유효기간 : %@", [foodDic objectForKey:@"TIME"]];
    cell.scontoText.text = [foodDic objectForKey:@"SALE"];
    
    cell.cellSelectedBtn.tag = indexPath.row;
    [cell.cellSelectedBtn addTarget:self action:@selector(audioCellAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 테이블 항목 터치에 대한 이벤트는 방지. 테이블 셀 위의 버튼 이벤트도 대치하기 위함.
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
}

- (void)audioCellAction:(UIButton*)sender{
    NSDictionary *foodDic = [tableListArr objectAtIndex:sender.tag];
    
    EurepeFoodCoupenDetailVC *eurepeFoodCoupenDetailVC = [[EurepeFoodCoupenDetailVC alloc] initWithNibName:@"EurepeFoodCoupenDetailVC" bundle:nil];
    eurepeFoodCoupenDetailVC.detailDic = foodDic;
    [self.navigationController pushViewController:eurepeFoodCoupenDetailVC animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if([BOTTOM_AD_CHECK isEqualToString:@"1"]){
        [delegate europeFoodAdHidden];
    }
}

@end
