//
//  EuropePassVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "EuropePassVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "EuropePassDetailVC.h"
#import "Cell2.h"
#import "AsyncImageView.h"

@interface EuropePassVC ()

@end

@implementation EuropePassVC

@synthesize europeTable;
@synthesize topView;
@synthesize delegate;

- (void)europePass:(NSNotification *)noti
{
    SORT_TOP_NUMBER = @"2";
    
    tagStr = @"미술관 박물관";
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mainSortButtonNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"adNotification" object:nil userInfo:nil];
    
    [self performSelector:@selector(passLoad) withObject:nil afterDelay:0.5f];
}

- (void)passLoad{
    [self initLoad];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(europePass:) name:@"europePassNotification" object:nil];
    
    topBtn1 = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_FRAME - 78*4)/5, 10, 78, 80)];
    [topBtn1 setImage:[UIImage imageNamed:@"pass_top_btn01"] forState:UIControlStateNormal];
    [topBtn1 addTarget:self action:@selector(button1:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topBtn1];
    
    topBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(78 + ((WIDTH_FRAME - 78*4)/5)*2, 10, 78, 80)];
    [topBtn2 setImage:[UIImage imageNamed:@"pass_top_btn02"] forState:UIControlStateNormal];
    [topBtn2 addTarget:self action:@selector(button2:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topBtn2];
    
    topBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(78*2 + ((WIDTH_FRAME - 78*4)/5)*3, 10, 78, 80)];
    [topBtn3 setImage:[UIImage imageNamed:@"pass_top_btn03"] forState:UIControlStateNormal];
    [topBtn3 addTarget:self action:@selector(button3:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topBtn3];
    
    topBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(78*3 + ((WIDTH_FRAME - 78*4)/5)*4, 10, 78, 80)];
    [topBtn4 setImage:[UIImage imageNamed:@"pass_top_btn04"] forState:UIControlStateNormal];
    [topBtn4 addTarget:self action:@selector(button4:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:topBtn4];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    tagStr = @"미술관 박물관";
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
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, EUROPASS_LIST_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"tag=%@", tagStr];
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

#pragma mark -
#pragma mark Button Action

- (void)button1:(UIButton*)sender {
    tagStr = @"미술관 박물관";
    [self initLoad];
}

- (void)button2:(UIButton*)sender {
    tagStr = @"교통 기차티켓";
    [self initLoad];
}

- (void)button3:(UIButton*)sender {
    tagStr = @"레져 스포츠";
    [self initLoad];
}

- (void)button4:(UIButton*)sender {
    tagStr = @"가이드 투어";
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
    
    [europeTable reloadData];
    
    NSLog(@"%@", xmlArrData);
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
    
    loadingView.hidden = YES;
    [activityView stopAnimating];
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
    
    if ([elementName isEqualToString:@"KEY_INDEX"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"PATH_NAME"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"PRICE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"MAIN_TITLE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"COUNTRY"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"SUB_TITLE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"REASON"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"READ"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"PATH_G"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"LEE"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"HAN"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"ETC"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"IMG1"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"IMG2"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"IMG3"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"TAG"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"WON"]){
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
#pragma mark UIGridView

- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
    if([UIScreen mainScreen].bounds.size.width == 414){
        return 201;
    }else if([UIScreen mainScreen].bounds.size.width == 375){
        return 181;
    }else{
        return 154;
    }
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
    return 200;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
    return 2;
}

- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
    return [xmlArrData count];
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    Cell2 *cell = (Cell2 *)[grid dequeueReusableCell];
    
    if (cell == nil) {
        cell = [[Cell2 alloc] init];
    }
    
    if(columnIndex == 0){
        tableRow =  rowIndex * 2;
        tableX = 0;
    }else{
        tableRow =  rowIndex * 2 + 1;
        tableX = 3;
    }
    cell.backgroundColor = [UIColor clearColor];
    
    NSDictionary *dic = [xmlArrData objectAtIndex:tableRow];
    NSLog(@"%@", dic);
    
    AsyncImageView *ImageViewEx = [[AsyncImageView alloc] init];
    if([UIScreen mainScreen].bounds.size.width == 414){
        cell.bgView.frame = CGRectMake(tableX, 0, 200, 194);
        ImageViewEx.frame = CGRectMake(tableX, 0, 200, 103);
        ImageViewEx.backgroundColor = [UIColor clearColor];
        //ImageViewEx.IsThumbNainSave = YES;
        [ImageViewEx SetImageViewParentRect:YES];
        ImageViewEx.IsViewSizeFormimageData = YES;
        [cell addSubview:ImageViewEx];
        cell.title.frame = CGRectMake(6, 104, 140, 50);
        cell.price.frame = CGRectMake(10, 154, 168, 30);
    }else if([UIScreen mainScreen].bounds.size.width == 375){
        cell.bgView.frame = CGRectMake(tableX, 0, 178, 194);
        ImageViewEx.frame = CGRectMake(tableX, 0, 178, 88);
        ImageViewEx.backgroundColor = [UIColor clearColor];
        //ImageViewEx.IsThumbNainSave = YES;
        [ImageViewEx SetImageViewParentRect:YES];
        ImageViewEx.IsViewSizeFormimageData = YES;
        [cell addSubview:ImageViewEx];
        cell.title.frame = CGRectMake(6, 104, 140, 50);
        cell.price.frame = CGRectMake(10, 154, 168, 30);
    }else{
        cell.bgView.frame = CGRectMake(tableX, 0, 152, 194);
        ImageViewEx.frame = CGRectMake(tableX, 0, 152, 80);
        ImageViewEx.backgroundColor = [UIColor clearColor];
        //ImageViewEx.IsThumbNainSave = YES;
        [ImageViewEx SetImageViewParentRect:YES];
        ImageViewEx.IsViewSizeFormimageData = YES;
        [cell addSubview:ImageViewEx];
        cell.title.frame = CGRectMake(6, 104, 140, 50);
        cell.price.frame = CGRectMake(10, 154, 168, 30);
    }
    
    cell.title.numberOfLines = 0;
    cell.title.text = [dic objectForKey:@"PATH_NAME"];
    cell.price.text = [dic objectForKey:@"WON"];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
        __block NSData *imageData1;
        
        dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0),^{
            imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/EuropePath_IMG/%@", [dic objectForKey:@"IMG1"]]]];
        
            dispatch_sync(dispatch_get_main_queue(), ^{
                UIImage *image1 = [[UIImage alloc] initWithData:imageData1];
                
                if(image1 != nil){
                    //cell.thumbnail.image = image1;
                    [ImageViewEx SetImage:image1];
                    //cell.thumbnail.contentMode = UIViewContentModeScaleAspectFit;
                    //cell.thumbnail.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
                    //cell.thumbnail.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleTopMargin;
                }
            });
        });
    });
    
    return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    NSInteger indexRow = 0;
    
    if(colIndex == 0){
        indexRow = rowIndex * 2;
    }else{
        indexRow = rowIndex * 2 + 1;
    }
    
    NSDictionary *passDic = [xmlArrData objectAtIndex:indexRow];
    EuropePassDetailVC *europePassDetailVC = [[EuropePassDetailVC alloc] initWithNibName:@"EuropePassDetailVC" bundle:nil];
    europePassDetailVC.detailDic = passDic;
    [self.navigationController pushViewController:europePassDetailVC animated:YES];
}

- (void)gridViewScrollView{
    if([BOTTOM_AD_CHECK isEqualToString:@"1"]){
        [delegate europePassAdHidden];
    }
}

@end
