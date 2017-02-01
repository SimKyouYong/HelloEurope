//
//  QuestionVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 17..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "QuestionVC.h"
#import "DrawerNavigation.h"
#import "GlobalHeader.h"
#import "QuestionCell.h"

#define QUESTION_VIEW_tag 0x100
#define QUESTION_tag   QUESTION_VIEW_tag + 1

@interface QuestionVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation QuestionVC

@synthesize questionTable;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    selectedIndex = -1;
    
    questionArr = [[NSMutableArray alloc] init];
    answerArr = [[NSMutableArray alloc] init];
    
    [questionArr addObject:@"Q.적립된 포인트는 어디에 사용하나요??"];
    [questionArr addObject:@"Q.포인트가 없어서 결제를 하고싶습니다. 쿠폰들도 현금&카드&핸드폰 결제가 가능한가요?"];
    [questionArr addObject:@"Q.쿠폰 사용은 어떻게 하는건가요??"];
    [questionArr addObject:@"Q.쿠폰 가격이 상품의 최종금액인가요?현장에서 추가 지불이 없나요?"];
    [questionArr addObject:@"Q.계정 등급을 올리고싶어요. 어떤 조건이 있나요?"];
    [questionArr addObject:@"Q.인터넷이 안되도 사용가능한가요??"];
    [questionArr addObject:@"Q.유럽에서도 결제가 가능한가요?"];
    [questionArr addObject:@"Q.환불이 가능한가요??"];
    [questionArr addObject:@"Q.유럽여행이 끝났는데"];
    [questionArr addObject:@"Q.쿠폰 결제를 했는데, 어디에서 볼 수 있나요??"];
    
    [answerArr addObject:@"A.헬로우톡 활동을 통해, 적립된 포인트는 유럽할인쿠폰&맛집쿠폰&오디오가이드 등\n헬로우유럽에서 판매하고 있는 상품들을 구매할 수 있습니다."];
    [answerArr addObject:@"A.네 가능합니다. 모든 상품은 포인트사용과 함께 결제 시스템도 운영되고 있습니다."];
    [answerArr addObject:@"A.할인쿠폰을 구매하시면, 마이페이지에 해당 결제쿠폰 내용과, 예약번호가 생성됩니다.해당 페이지를 사진을 저장하신 뒤, 레스토랑 혹은 입장권 구매처에서 예약내용을 제시하시면금액에 맞게 할인하여 결제할 수 있습니다."];
    [answerArr addObject:@"A.아닙니다. 쿠폰의 가격은 할인 되는 금액을 표기한것입니다.따라서, 현장에서 결제를 하실 때 쿠폰에 나와있는 금액을 할인받을 수 있는 쿠폰입니다."];
    [answerArr addObject:@"A.유럽초심자부터, 유럽박사까지 총 5개의 등급으로 분류되어 있으며 등업조건은 아래와 같습니다.\n유럽초심자 – 처음 가입한 회원  \n유럽준비자 – 출석3회, 글작성1회, 덧글작성5회\n유럽여행객 – 출석10회, 글작성3회, 덧글작성10회\n유럽거주자 – 출석30회, 글작성10회, 덧글작성30회, 컨텐츠 좋아요 50개이상\n유럽박사 – 유럽거주자 등급회원중 관리자가 선별하여 직접 등업\n\n각 등급마다의 혜택이 주어지며, 유럽박사로 등록되면 사용자의 컨텐츠가 유료로 등록되어, \n헬로우유럽 포인트 판매가 가능합니다."];
    [answerArr addObject:@"A.헬로우유럽 초기 어플 실행 및 쿠폰다운, 헬로우톡 기능은 인터넷이 가능해야합니다.\n단, 오디오 가이드는 인터넷이 되는곳에서 미리 다운받으시면 인터넷이 되지않아도 실행가능하며\n할인쿠폰도 미리 다운로드 받으신 뒤 마이페이지에서 발급 된 쿠폰번호를 캡쳐하여 사용하시면 큰 불편함없이 사용가능합니다."];
    [answerArr addObject:@"A.네.인터넷이 사용가능한 공간에서는, 국내, 유럽 어디에서나 결제 및 어플리케이션 사용가능합니다."];
    [answerArr addObject:@"A.헬로우유럽에서 판매하는 모든 상품은 정가 가격이 아닌, 할인이 되어 있는 상품입니다.\n따라서 모든 상품은 환불이 불가하오니, 구매 시 신중하게 결제부탁드립니다."];
    [answerArr addObject:@"A.헬로우유럽 포인트가 남으셨다면, 지인분들에게 선물하기가 가능합니다.\n혹은, 유럽박사 타이틀을 획득하시면 포인트 환전(현금으로지급)이 가능합니다."];
    [answerArr addObject:@"A.모든 결제내역은 마이페이지란에 저장되어 있습니다."];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.rootNav popViewControllerAnimated:NO];
}

#pragma mark -
#pragma mark UITableViewDatasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [questionArr count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectedIndex == [indexPath row]) {
        
        NSString* content = [answerArr objectAtIndex:indexPath.row];
        CGSize constraint = CGSizeMake(WIDTH_FRAME - 40, 20000.0f);
        CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:15.0f]
                          constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        float height = 30 + size.height + 30;
        
        return height;
    }
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    QuestionCell *cell = (QuestionCell *)[tableView dequeueReusableCellWithIdentifier:@"QuestionCell"];
    
    if (cell == nil){
        cell = [[QuestionCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"QuestionCell"];
    }
    
    [cell.titleText setText:[questionArr objectAtIndex:indexPath.row]];
    [cell.titleText setTextColor:[UIColor colorWithRed:(85/255.0) green:(194/255.0) blue:(193/255.0) alpha:1] ];
    
    UIView* expandView = [cell viewWithTag:QUESTION_VIEW_tag];
    UILabel* inputDate = (UILabel*)[cell viewWithTag:QUESTION_tag];
    [expandView removeFromSuperview];
    [inputDate removeFromSuperview];

    if(selectedIndex == indexPath.row)
    {
        NSString* content = [answerArr objectAtIndex:indexPath.row];
        CGSize constraint = CGSizeMake(WIDTH_FRAME - 40, 20000.0f);
        CGSize size = [content sizeWithFont:[UIFont systemFontOfSize:15.0f]
                          constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
        
        float height = 30 + size.height + 30;
        
        CGRect rt = CGRectMake(10, 40, WIDTH_FRAME - 40, height);
        UIView* expandView = [[UIView alloc] initWithFrame:rt];
        expandView.tag = QUESTION_VIEW_tag;
        [expandView setBackgroundColor:[UIColor clearColor]];
        [cell addSubview:expandView];
        
        UILabel* contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WIDTH_FRAME - 40, size.height)];
        [contentLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [contentLabel setTextColor:[UIColor grayColor]];
        [contentLabel setBackgroundColor:[UIColor clearColor]];
        contentLabel.lineBreakMode = UILineBreakModeWordWrap;
        contentLabel.numberOfLines = 0;
        [contentLabel setText:content];
        [expandView addSubview:contentLabel];
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedIndex == indexPath.row)
    {
        selectedIndex = -1;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
        return;
    }
    
    if(selectedIndex >= 0)
    {
        NSIndexPath *previousPath = [NSIndexPath indexPathForRow:selectedIndex inSection:0];
        selectedIndex = indexPath.row;
        [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:previousPath] withRowAnimation:UITableViewRowAnimationNone];
    }

    selectedIndex = indexPath.row;
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

@end
