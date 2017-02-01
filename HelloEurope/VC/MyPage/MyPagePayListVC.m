//
//  MyPagePayListVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 20..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MyPagePayListVC.h"
#import "DrawerNavigation.h"
#import "GlobalHeader.h"
#import "MyPagePayListCell.h"
#import "MoneyPayDetailVC.h"

@interface MyPagePayListVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation MyPagePayListVC

@synthesize payTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    payArr = [[NSMutableArray alloc] init];
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 40, HEIGHT_FRAME/2 - 40, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(24, 22, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    [self.view addSubview:loadingView];
    [activityView startAnimating];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, MY_PAYLIST_URL];
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
    return [payArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyPagePayListCell *cell = (MyPagePayListCell *)[tableView dequeueReusableCellWithIdentifier:@"MyPagePayListCell"];
    
    if (cell == nil){
        cell = [[MyPagePayListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"MyPagePayListCell"];
    }
    
    NSDictionary *dic = [payArr objectAtIndex:indexPath.row];
   
    NSString *imageURL = @"";
    if([[dic objectForKey:@"TAG"] isEqualToString:@"맛집"]) {
        imageURL = @"http://coaineu.cafe24.com/Hellow/Food_IMG/";
    }else{
        imageURL = @"http://coaineu.cafe24.com/Hellow/EuropePath_IMG/";
    }
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", imageURL, [dic objectForKey:@"IMG"]]]];
    
    UIImageView *bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(4, 4, 100, 92)];
    bgImageView.image = [UIImage imageWithData:imageData];
    [cell addSubview:bgImageView];
    
    cell.titleLabel.text = [dic objectForKey:@"NAME"];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 99.5, WIDTH_FRAME, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [cell addSubview:lineView];
    
    cell.cellSelectButton.tag = indexPath.row;
    [cell.cellSelectButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)selectAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    NSDictionary *dic = [payArr objectAtIndex:nIndex];
    
    MoneyPayDetailVC *moneyPayDetailVC = [[MoneyPayDetailVC alloc] initWithNibName:@"MoneyPayDetailVC" bundle:nil];
    moneyPayDetailVC.moneyDetailDic = dic;
    moneyPayDetailVC.moneyDetailCheck = @"1";
    [self.navigationController pushViewController:moneyPayDetailVC animated:YES];
}

#pragma mark -
#pragma mark NSXMLParserDelegate method

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [payTableView reloadData];
    
    loadingView.hidden = YES;
    [activityView stopAnimating];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"word"]) {
        elementType = ePayItem;
    }
    
    [foundValue setString:@""];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if (elementType != ePayItem)
        return;
    if ([elementName isEqualToString:@"KEY_INDEX"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"SELF_ID"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"NAME"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"POINT"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"DATE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"PATH_ID"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"USER_NAME"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"USER_PHONE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"USER_EMAIL"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"USER_DATE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"USER_KEY"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"TAG"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"IMG"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"word"]) {
        [payArr addObject:[NSDictionary dictionaryWithDictionary:xmlDic]];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if (elementType == ePayItem) {
        [foundValue appendString:string];
    }
}

@end
