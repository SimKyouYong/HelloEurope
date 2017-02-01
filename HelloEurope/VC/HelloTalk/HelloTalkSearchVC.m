//
//  HelloTalkSearchVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 10. 12..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "HelloTalkSearchVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "HelloTalkDetailVC.h"
#import "TalkListCommonCell.h"

@interface HelloTalkSearchVC ()

@end

@implementation HelloTalkSearchVC

@synthesize searchTable;
@synthesize searchCountryStr;
@synthesize searchTopNumber;
@synthesize searchButton;
@synthesize searchText;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

    loadingView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 40, HEIGHT_FRAME/2 - 40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(24, 22, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    [self.view addSubview:loadingView];
    loadingView.hidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Button Method

- (IBAction)searchButton:(id)sender {
    if(searchText.text.length == 0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"검색어를 입력해주세요."
                                                       delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
        [alert show];
        return;
    }
    
    loadingView.hidden = NO;
    [activityView startAnimating];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKSEARCH_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [urlRequest setHTTPMethod:@"POST"];
    NSString * params = [NSString stringWithFormat:@"country=%@&self_id=%@&search_edit=%@", searchCountryStr, [defaults stringForKey:KEY_INDEX], searchText.text];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
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
            
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"잠시 후 다시 시도해주세요."
                                                           delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
            [alert show];
        }
        loadingView.hidden = YES;
        [activityView stopAnimating];
    }];
    [dataTask resume];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark NSXMLParserDelegate method

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    // Initialize the neighbours data array.
    xmlArrData = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{  
    if([xmlArrData count] != 0){
        searchTable.hidden = NO;
        [searchTable reloadData];
        [searchText resignFirstResponder];
    }
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"word"]) {
        elementType = eSearchItem;
    }
    
    [foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (elementType != eSearchItem)
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
    }else if ([elementName isEqualToString:@"Meet_etc1"]){
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
    }else if ([elementName isEqualToString:@"My_img"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"word"]) {
        [xmlArrData addObject:[NSDictionary dictionaryWithDictionary:xmlDic]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (elementType == eSearchItem) {
        [foundValue appendString:string];
    }
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [xmlArrData count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TalkListCommonCell *cell = (TalkListCommonCell *)[tableView dequeueReusableCellWithIdentifier:@"TalkListCommonCell"];
    
    if (cell == nil){
        cell = [[TalkListCommonCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TalkListCommonCell"];
    }
    
    [cell setBackgroundView:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // 셀 터치 시 파란색 배경 변경 효과 방지
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *talkListDic = [xmlArrData objectAtIndex:indexPath.row];
    //NSLog(@"talkListDic : %@", talkListDic);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    if([[talkListDic objectForKey:@"Self_nickname"] isEqualToString:[defaults stringForKey:KEY_NAME]]){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/MY_IMG/%@", [defaults stringForKey:KEY_IMAGE]]]];
        cell.iconImage.clipsToBounds = YES;
        cell.iconImage.layer.cornerRadius = 13.0;
        cell.iconImage.layer.masksToBounds = YES;
        cell.iconImage.image = [UIImage imageWithData:imageData];
    }else{
        cell.iconImage.image = [UIImage imageNamed:@"talk_list_cell_icon1"];
    }
    
    cell.nameText.text = [talkListDic objectForKey:@"Self_nickname"];
    cell.timeText.text = [talkListDic objectForKey:@"Date"];
    
    cell.idText.text = [talkListDic objectForKey:@"Tag"];
    NSString *title = [NSString stringWithFormat:@"[%@] %@", [talkListDic objectForKey:@"City"], [talkListDic objectForKey:@"Title"]];
    
    NSMutableAttributedString *searchStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange sRange;
    
    NSArray *searchArr = [title componentsSeparatedByString:@"]"];
    NSString *searchChangedStr = [searchArr objectAtIndex:0];
    searchChangedStr = [NSString stringWithFormat:@"%@]", searchChangedStr];
    sRange = [title rangeOfString:searchChangedStr];
    [searchStr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:sRange];
    [cell.titleText setAttributedText:searchStr];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        __block NSData *imageData1;
        __block NSData *imageData2;
        __block NSData *imageData3;
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [talkListDic objectForKey:@"Image_url"]]]];
            imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [talkListDic objectForKey:@"Image_urlone"]]]];
            imageData3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [talkListDic objectForKey:@"Image_urltwo"]]]];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage *image1 = [[UIImage alloc] initWithData:imageData1];
                UIImage *image2 = [[UIImage alloc] initWithData:imageData2];
                UIImage *image3 = [[UIImage alloc] initWithData:imageData3];
                
                if(image1 != nil){
                    cell.thumnailImage1.image = image1;
                    //cell.thumnailImage1.contentMode = UIViewContentModeScaleAspectFit;
                }
                if(image2 != nil){
                    cell.thumnailImage2.image = image2;
                    //cell.thumnailImage2.contentMode = UIViewContentModeScaleAspectFit;
                }
                if(image3 != nil){
                    cell.thumnailImage3.image = image3;
                    //cell.thumnailImage3.contentMode = UIViewContentModeScaleAspectFit;
                }
                
            });
        });
    });
    
    cell.bottomText1.text = [talkListDic objectForKey:@"Comment_ea"];
    cell.bottomText2.text = [talkListDic objectForKey:@"choo"];
    if([[talkListDic objectForKey:@"Good"] isEqualToString:@"false"]){
        cell.bottomImage2.image = [UIImage imageNamed:@"talk_list_cell_icon8_on"];
    }else{
        cell.bottomImage2.image = [UIImage imageNamed:@"talk_list_cell_icon8_off"];
    }
    
    cell.cellSelectedBtn.tag = indexPath.row;
    [cell.cellSelectedBtn addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 테이블 항목 터치에 대한 이벤트는 방지. 테이블 셀 위의 버튼 이벤트도 대치하기 위함.
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    return;
}

- (void)selectAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    NSMutableDictionary *dic = [xmlArrData objectAtIndex:nIndex];
    
    HelloTalkDetailVC *helloTalkDetailVC = [[HelloTalkDetailVC alloc] initWithNibName:@"HelloTalkDetailVC" bundle:nil];
    helloTalkDetailVC.detailDic = dic;
    helloTalkDetailVC.topNumber = searchTopNumber;
    helloTalkDetailVC.countryStr = searchCountryStr;
    [self.navigationController pushViewController:helloTalkDetailVC animated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

@end
