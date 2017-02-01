//
//  TalkListView6.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "TalkListView6.h"
#import "TalkListCommonCell.h"
#import "GlobalHeader.h"

@implementation TalkListView6

@synthesize delegate;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *bgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"main_bg"]];
        bgImage.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [self addSubview:bgImage];
        
        talkListTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        talkListTableView.delegate = self;
        talkListTableView.dataSource = self;
        talkListTableView.backgroundColor = [UIColor clearColor];
        talkListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        talkListTableView.showsVerticalScrollIndicator = NO;
        [self addSubview:talkListTableView];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(talkListView6:) name:@"talkListView6" object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(talkListView6SortChoo:) name:@"talkListView6SortChoo" object:nil];
    }
    return self;
}

#pragma mark -
#pragma mark Notification

- (void)talkListView6:(NSNotification *)noti{
    tableArr = [[NSMutableArray alloc] init];
    tableArr = (NSMutableArray*)noti.object;
    [talkListTableView reloadData];
}

- (void)talkListView6SortChoo:(NSNotification *)noti{
    tableArr = [[NSMutableArray alloc] init];
    tableArr = (NSMutableArray*)noti.object;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"choo" ascending:NO];
    tableArr = [tableArr sortedArrayUsingDescriptors:@[sortDescriptor]];
    [talkListTableView reloadData];
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
    return [tableArr count];
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
    
    NSDictionary *talkListDic = [tableArr objectAtIndex:indexPath.row];
    
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
    
    cell.likeBtn.tag = indexPath.row;
    [cell.likeBtn addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.reportBtn.tag = indexPath.row;
    [cell.reportBtn addTarget:self action:@selector(reportAction:) forControlEvents:UIControlEventTouchUpInside];
    
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
    NSMutableDictionary *dic = [tableArr objectAtIndex:nIndex];
    [delegate selectDic6:dic];
}

- (void)likeAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    NSDictionary *dic = [tableArr objectAtIndex:nIndex];
    
    NSString *tagStr = nil;
    if([[dic objectForKey:@"Good"] isEqualToString:@"false"]){
        tagStr = @"0";
    }else{
        tagStr = @"1";
    }
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, TALKLIKE_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"key_index=%@&self_id=%@&tag=%@", [dic objectForKey:@"Key_Index"], [defaults stringForKey:KEY_INDEX], tagStr];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        if (data != nil) {
            [self.delegate tableReload6:0];
        }
    }];
    [dataTask resume];
}

- (void)reportAction:(UIButton*)sender{
    NSInteger nIndex = sender.tag;
    NSDictionary *dic = [tableArr objectAtIndex:nIndex];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, DANGER_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString *params = [NSString stringWithFormat:@"key_index=%@", [dic objectForKey:@"Key_Index"]];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"신고하기가 등록되었습니다."
                                                           delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
            [alert show];
        }else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"잠시 후 다시 시도해주세요."
                                                           delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
            [alert show];
        }
    }];
    [dataTask resume];
}

@end
