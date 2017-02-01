//
//  MyPageBookmarkVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPageBookmarkVC.h"
#import "GlobalHeader.h"
#import "DrawerNavigation.h"
#import "UIView+Toast.h"
#import "HelloTalkDetailVC.h"
#import "MyPageBookmarkCell.h"

@interface MyPageBookmarkVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation MyPageBookmarkVC

@synthesize bookmarkTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    bookmarkArr = [[NSMutableArray alloc] init];
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 40, HEIGHT_FRAME/2 - 40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(24, 22, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    [self.view addSubview:loadingView];
    [activityView startAnimating];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, MY_BOOKMARK_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"self_id=%@", [defaults stringForKey:KEY_INDEX]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        if(error == nil)
        {
            if (data != nil) {
                xmlParser = [[NSXMLParser alloc] initWithData:data];
                xmlParser.delegate = self;
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

#pragma mark -
#pragma mark UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [bookmarkArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 190;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPageBookmarkCell *cell = (MyPageBookmarkCell *)[tableView dequeueReusableCellWithIdentifier:@"MyPageBookmarkCell"];
    
    if (cell == nil){
        cell = [[MyPageBookmarkCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyPageBookmarkCell"];
    }
    
    NSDictionary *dic = [bookmarkArr objectAtIndex:indexPath.row];
    
    //NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/MY_IMG/%@", [defaults stringForKey:KEY_IMAGE]]]];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 10, 40, 40)];
    bgImageView.image = [UIImage imageNamed:@"mypage_thumb_default_icon"];//[UIImage imageWithData:imageData];
    bgImageView.clipsToBounds = YES;
    bgImageView.layer.cornerRadius = 20.0;
    bgImageView.layer.masksToBounds = YES;
    [cell addSubview:bgImageView];
    
    cell.nameLabel.text = [dic objectForKey:@"Self_nickname"];
    cell.dateLabel.text = [dic objectForKey:@"Date"];
    
    cell.idLabel.text = [dic objectForKey:@"Tag"];
    NSString *title = [NSString stringWithFormat:@"[%@] %@", [dic objectForKey:@"City"], [dic objectForKey:@"Title"]];
    
    NSMutableAttributedString *searchStr = [[NSMutableAttributedString alloc] initWithString:title];
    NSRange sRange;
    NSArray *searchArr = [title componentsSeparatedByString:@"]"];
    NSString *searchChangedStr = [searchArr objectAtIndex:0];
    searchChangedStr = [NSString stringWithFormat:@"%@]", searchChangedStr];
    sRange = [title rangeOfString:searchChangedStr];
    [searchStr addAttribute:NSForegroundColorAttributeName value:[UIColor purpleColor] range:sRange];
    [cell.titleLabel setAttributedText:searchStr];
    
    NSInteger thumnailWid = 0;
    if(WIDTH_FRAME == 414){
        thumnailWid = 121;
    }else if(WIDTH_FRAME == 375){
        thumnailWid = 108;
    }else{
        thumnailWid = 90;
    }
    UIImageView *thumnailImage1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, 90, thumnailWid, 70)];
    thumnailImage1.backgroundColor = [UIColor clearColor];
    [cell addSubview:thumnailImage1];
    
    UIImageView *thumnailImage2 = [[UIImageView alloc] initWithFrame:CGRectMake(thumnailImage1.frame.origin.x + thumnailWid + 5, 90, thumnailWid, 70)];
    thumnailImage2.backgroundColor = [UIColor clearColor];
    [cell addSubview:thumnailImage2];
    
    UIImageView *thumnailImage3 = [[UIImageView alloc] initWithFrame:CGRectMake(thumnailImage2.frame.origin.x + thumnailWid + 5, 90, thumnailWid, 70)];
    thumnailImage3.backgroundColor = [UIColor clearColor];
    [cell addSubview:thumnailImage3];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        __block NSData *imageData1;
        __block NSData *imageData2;
        __block NSData *imageData3;
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [dic objectForKey:@"Image_url"]]]];
            imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [dic objectForKey:@"Image_urlone"]]]];
            imageData3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/hellowtalk_img/%@", [dic objectForKey:@"Image_urltwo"]]]];
            
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage *image1 = [[UIImage alloc] initWithData:imageData1];
                UIImage *image2 = [[UIImage alloc] initWithData:imageData2];
                UIImage *image3 = [[UIImage alloc] initWithData:imageData3];
                
                if(image1 != nil){
                    thumnailImage1.image = image1;
                }
                if(image2 != nil){
                    thumnailImage2.image = image2;
                }
                if(image3 != nil){
                    thumnailImage3.image = image3;
                }
                
            });
        });
    });
    
    cell.bottomText1.text = [dic objectForKey:@"Comment_ea"];
    cell.bottomText2.text = [dic objectForKey:@"choo"];
    if([[dic objectForKey:@"Good"] isEqualToString:@"false"]){
        cell.bottomImage2.image = [UIImage imageNamed:@"talk_list_cell_icon8_on"];
    }
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 189.5, WIDTH_FRAME, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [cell addSubview:lineView];
    
    cell.selectButton.tag = indexPath.row;
    [cell.selectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -
#pragma mark NSXMLParserDelegate method

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [bookmarkTableView reloadData];
    
    loadingView.hidden = YES;
    [activityView stopAnimating];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"word"]) {
        elementType = eBookmarkItem;
    }
    
    [foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (elementType != eBookmarkItem)
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
        [bookmarkArr addObject:[NSDictionary dictionaryWithDictionary:xmlDic]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (elementType == eBookmarkItem) {
        [foundValue appendString:string];
    }
}

#pragma mark -
#pragma mark Button Action

- (void)selectAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    NSInteger topNum = 0;
    
    NSDictionary *dic = [bookmarkArr objectAtIndex:nIndex];
    
    if([[dic objectForKey:@"Tag"] isEqualToString:@"여행스토리"]){
        topNum = 0;
    }else if([[dic objectForKey:@"Tag"] isEqualToString:@"질문"]){
        topNum = 1;
    }else if([[dic objectForKey:@"Tag"] isEqualToString:@"동행"]){
        topNum = 2;
    }else if([[dic objectForKey:@"Tag"] isEqualToString:@"맛집"]){
        topNum = 3;
    }else if([[dic objectForKey:@"Tag"] isEqualToString:@"교통"]){
        topNum = 4;
    }else if([[dic objectForKey:@"Tag"] isEqualToString:@"투어리뷰"]){
        topNum = 5;
    }else if([[dic objectForKey:@"Tag"] isEqualToString:@"숙소리뷰"]){
        topNum = 6;
    }
    
    HelloTalkDetailVC *helloTalkDetailVC = [[HelloTalkDetailVC alloc] initWithNibName:@"HelloTalkDetailVC" bundle:nil];
    helloTalkDetailVC.detailDic = dic;
    helloTalkDetailVC.topNumber = topNum;
    helloTalkDetailVC.countryStr = [dic objectForKey:@"Country"];
    helloTalkDetailVC.titleBg = @"1";
    [self.rootNav pushViewController:helloTalkDetailVC animated:YES];
}

@end

