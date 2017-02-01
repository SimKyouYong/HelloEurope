//
//  MyPagePointVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPagePointVC.h"
#import "DrawerNavigation.h"
#import "GlobalHeader.h"
#import "MyPagePointCell.h"

@interface MyPagePointVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation MyPagePointVC

@synthesize pointTableView;
@synthesize profileImage;
@synthesize nameText;
@synthesize pointText;

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
    
    nameText.text = [defaults stringForKey:KEY_NAME];
    pointText.text = [NSString stringWithFormat:@"%@ 포인트", [defaults stringForKey:KEY_LEVEL]];
    
    pointArr = [[NSMutableArray alloc] init];
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 40, HEIGHT_FRAME/2 - 40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(24, 22, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    [self.view addSubview:loadingView];
    [activityView startAnimating];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, MY_POINT_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"Self_id=%@", [defaults stringForKey:KEY_INDEX]];
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
    return [pointArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPagePointCell *cell = (MyPagePointCell *)[tableView dequeueReusableCellWithIdentifier:@"MyPagePointCell"];
    
    if (cell == nil){
        cell = [[MyPagePointCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyPagePointCell"];
    }
    
    NSDictionary *dic = [pointArr objectAtIndex:indexPath.row];
   
    NSString *pointStr = [NSString stringWithFormat:@"%@POINT", [dic objectForKey:@"POINT"]];
    NSString *allString = nil;
    NSRange strRange;
    strRange = [[dic objectForKey:@"POINT"] rangeOfString:@"-"];
    if (strRange.location != NSNotFound) {
        allString = [NSString stringWithFormat:@"포스팅 포인트가 %@ 차감 되었습니다.", pointStr];
    }else{
        allString = [NSString stringWithFormat:@"포스팅 포인트가 %@ 지급 되었습니다.", pointStr];
    }
    NSMutableAttributedString *searchStr = [[NSMutableAttributedString alloc] initWithString:allString];
    NSRange sRange = [allString rangeOfString:pointStr];
    [searchStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:sRange];
    [cell.titleLabel setAttributedText:searchStr];
    
    cell.comentLabel.text = [dic objectForKey:@"DATE"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 59.5, WIDTH_FRAME, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [cell addSubview:lineView];
    
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
    [pointTableView reloadData];
    
    loadingView.hidden = YES;
    [activityView stopAnimating];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"word"]) {
        elementType = ePointItem;
    }
    
    [foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (elementType != ePointItem)
        return;
    
    if ([elementName isEqualToString:@"KEY_INDEX"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"SELF_ID"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"TAG"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"POINT"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"DATE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"A_NAME"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"word"]) {
        [pointArr addObject:[NSDictionary dictionaryWithDictionary:xmlDic]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (elementType == ePointItem) {
        [foundValue appendString:string];
    }
}

@end

