//
//  AudioGuideVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "AudioGuideVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "AppDelegate.h"
#import "AudioGuideCell.h"
#import "AudioGuideDetailVC.h"

@interface AudioGuideVC ()

@end

@implementation AudioGuideVC

@synthesize audioMainScrollView;
@synthesize audioMainTableView;
@synthesize delegate;

- (void)audio:(NSNotification *)noti
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mainSortButtonHiddenNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"adNotification" object:nil userInfo:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    for(int i = 0; i < 9; i++){
        scrollButton[i] = [[UIButton alloc] initWithFrame:CGRectMake(10+(i%9)*50, 10, 40, 40)];
        NSString *imageNameOn = [NSString stringWithFormat:@"audio_main_btn0%d_on", i + 1];
        NSString *imageNameOff = [NSString stringWithFormat:@"audio_main_btn0%d_off", i + 1];
        [scrollButton[i] setImage:[UIImage imageNamed:imageNameOn] forState:UIControlStateNormal];
        [scrollButton[i] setImage:[UIImage imageNamed:imageNameOff] forState:UIControlStateHighlighted];
        scrollButton[i].tag = i;
        [scrollButton[i] addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [audioMainScrollView addSubview:scrollButton[i]];
    }
    CGSize contentSize = CGSizeMake(10 + 50*9, 60);
    [audioMainScrollView setContentSize:contentSize];
    
    id AppID = [[UIApplication sharedApplication] delegate];
    audioListArr = [[NSMutableArray alloc] init];
    audioListArr = [AppID selectCountyList:@"main" country1:@"" country2:@""];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(audio:) name:@"audioNotification" object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickAction:(UIButton*)sender{
    NSString *country1Str = @"";
    NSString *country2Str = @"";
    
    if(sender.tag == 0){
        country1Str = @"이탈리아";
        country2Str = @"바티칸 시국";
    }else if(sender.tag == 1){
        country1Str = @"프랑스";
        country2Str = @"";
    }else if(sender.tag == 2){
        country1Str = @"스페인";
        country2Str = @"";
    }else if(sender.tag == 3){
        country1Str = @"오스트리아";
        country2Str = @"";
    }else if(sender.tag == 4){
        country1Str = @"영국";
        country2Str = @"";
    }else if(sender.tag == 5){
        country1Str = @"독일";
        country2Str = @"";
    }else if(sender.tag == 6){
        country1Str = @"스위스";
        country2Str = @"";
    }else if(sender.tag == 7){
        country1Str = @"체코";
        country2Str = @"";
    }else if(sender.tag == 8){
        country1Str = @"헝가리";
        country2Str = @"";
    }
    
    id AppID = [[UIApplication sharedApplication] delegate];
    audioListArr = [[NSMutableArray alloc] init];
    audioListArr = [AppID selectCountyList:@"main" country1:country1Str country2:country2Str];
    
    [audioMainTableView reloadData];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [audioListArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AudioGuideCell *cell = (AudioGuideCell *)[tableView dequeueReusableCellWithIdentifier:@"AudioGuideCell"];
    
    if (cell == nil){
        cell = [[AudioGuideCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"AudioGuideCell"];
    }
    
    [cell setBackgroundView:nil];
    [cell setBackgroundColor:[UIColor clearColor]];
    
    // 셀 터치 시 파란색 배경 변경 효과 방지
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSDictionary *audioDic = [audioListArr objectAtIndex:indexPath.row];
    
    NSString *imageName = [NSString stringWithFormat:@"%@.jpg", [audioDic objectForKey:@"icon_small"]];
    cell.photoImage.image = [UIImage imageNamed:imageName];
    
    NSString *titleText = [NSString stringWithFormat:@"[%@/%@]", [audioDic objectForKey:@"nazionale"], [audioDic objectForKey:@"city_name_e"]];
    cell.nameText.text = titleText;
    cell.contentText.text = [audioDic objectForKey:@"main_title"];
    
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
    NSDictionary *audioDic = [audioListArr objectAtIndex:sender.tag];

    AudioGuideDetailVC *audioGuideDetailVC = [[AudioGuideDetailVC alloc] initWithNibName:@"AudioGuideDetailVC" bundle:nil];
    audioGuideDetailVC.cityNameStr = [audioDic objectForKey:@"city_name"];
    audioGuideDetailVC.countryNameStr = [audioDic objectForKey:@"nazionale"];
    [self.navigationController pushViewController:audioGuideDetailVC animated:YES];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if([BOTTOM_AD_CHECK isEqualToString:@"1"]){
        [delegate audioAdHidden];
    }
}

@end
