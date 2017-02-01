//
//  Drawer.m
//  CCKFNavDrawer
//
//  Created by calvin on 2/2/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import "DrawerView.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"

@implementation DrawerView

@synthesize profileImage;
@synthesize popupView;
@synthesize delegate;
@synthesize idText;
@synthesize nameText;
@synthesize comentText;
@synthesize postText;
@synthesize bookmarkText;
@synthesize pointText;
@synthesize menuScrollView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/MY_IMG/%@", [defaults stringForKey:KEY_IMAGE]]]];
    profileImage.clipsToBounds = YES;
    profileImage.layer.cornerRadius = 22.0;
    profileImage.layer.masksToBounds = YES;
    profileImage.image = [UIImage imageWithData:imageData];
    if([defaults stringForKey:KEY_IMAGE].length == 0){
        profileImage.image = [UIImage imageNamed:@"menu_icon.png"];
    }
    
    pointView = [[UIView alloc] initWithFrame:CGRectMake(40, 50, WIDTH_FRAME - 80, 370)];
    pointView.backgroundColor = [UIColor whiteColor];
    [self addSubview:pointView];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, WIDTH_FRAME - 80, 40)];
    title.textColor = [UIColor blueColor];
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont fontWithName:@"Helvetica" size:20.0];
    [title setText:@"선택하세요."];
    [pointView addSubview:title];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 49, WIDTH_FRAME - 80, 1)];
    lineView.backgroundColor = [UIColor blueColor];
    [pointView addSubview:lineView];
    
    UILabel *pay1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 50, 200, 40)];
    pay1.textColor = [UIColor blackColor];
    pay1.textAlignment = NSTextAlignmentLeft;
    pay1.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [pay1 setText:@"1.09$(10 Point)"];
    [pointView addSubview:pay1];
    
    UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 90, WIDTH_FRAME - 80, 0.5)];
    lineView1.backgroundColor = [UIColor grayColor];
    [pointView addSubview:lineView1];
    
    payBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 55, 30, 30)];
    [payBtn1 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [payBtn1 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [pointView addSubview:payBtn1];
    
    payEmptyBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, WIDTH_FRAME - 80, 40)];
    [payEmptyBtn1 setImage:[UIImage imageNamed:@"clean_nor"] forState:UIControlStateNormal];
    [payEmptyBtn1 setImage:[UIImage imageNamed:@"clean_sel"] forState:UIControlStateNormal];
    [payEmptyBtn1 addTarget:self action:@selector(payEmptyBtn1Action:) forControlEvents:UIControlEventTouchUpInside];
    [pointView addSubview:payEmptyBtn1];
    
    UILabel *pay2 = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 200, 40)];
    pay2.textColor = [UIColor blackColor];
    pay2.textAlignment = NSTextAlignmentLeft;
    pay2.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [pay2 setText:@"2.19$(30 Point)"];
    [pointView addSubview:pay2];
    
    UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(0, 130, WIDTH_FRAME - 80, 0.5)];
    lineView2.backgroundColor = [UIColor grayColor];
    [pointView addSubview:lineView2];
    
    payBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 95, 30, 30)];
    [payBtn2 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [payBtn2 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [pointView addSubview:payBtn2];
    
    payEmptyBtn2 = [[UIButton alloc] initWithFrame:CGRectMake(0, 90, WIDTH_FRAME - 80, 40)];
    [payEmptyBtn2 setImage:[UIImage imageNamed:@"clean_nor"] forState:UIControlStateNormal];
    [payEmptyBtn2 setImage:[UIImage imageNamed:@"clean_sel"] forState:UIControlStateNormal];
    [payEmptyBtn2 addTarget:self action:@selector(payEmptyBtn2Action:) forControlEvents:UIControlEventTouchUpInside];
    [pointView addSubview:payEmptyBtn2];
    
    UILabel *pay3 = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 200, 40)];
    pay3.textColor = [UIColor blackColor];
    pay3.textAlignment = NSTextAlignmentLeft;
    pay3.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [pay3 setText:@"4.39$(50 Point)"];
    [pointView addSubview:pay3];
    
    UIView *lineView3 = [[UIView alloc] initWithFrame:CGRectMake(0, 170, WIDTH_FRAME - 80, 0.5)];
    lineView3.backgroundColor = [UIColor grayColor];
    [pointView addSubview:lineView3];
    
    payBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 135, 30, 30)];
    [payBtn3 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [payBtn3 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [pointView addSubview:payBtn3];
    
    payEmptyBtn3 = [[UIButton alloc] initWithFrame:CGRectMake(0, 130, WIDTH_FRAME - 80, 40)];
    [payEmptyBtn3 setImage:[UIImage imageNamed:@"clean_nor"] forState:UIControlStateNormal];
    [payEmptyBtn3 setImage:[UIImage imageNamed:@"clean_sel"] forState:UIControlStateNormal];
    [payEmptyBtn3 addTarget:self action:@selector(payEmptyBtn3Action:) forControlEvents:UIControlEventTouchUpInside];
    [pointView addSubview:payEmptyBtn3];
    
    UILabel *pay4 = [[UILabel alloc] initWithFrame:CGRectMake(10, 170, 200, 40)];
    pay4.textColor = [UIColor blackColor];
    pay4.textAlignment = NSTextAlignmentLeft;
    pay4.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [pay4 setText:@"6.59$(70 Point)"];
    [pointView addSubview:pay4];
    
    UIView *lineView4 = [[UIView alloc] initWithFrame:CGRectMake(0, 210, WIDTH_FRAME - 80, 0.5)];
    lineView4.backgroundColor = [UIColor grayColor];
    [pointView addSubview:lineView4];
    
    payBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 175, 30, 30)];
    [payBtn4 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [payBtn4 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [pointView addSubview:payBtn4];
    
    payEmptyBtn4 = [[UIButton alloc] initWithFrame:CGRectMake(0, 170, WIDTH_FRAME - 80, 40)];
    [payEmptyBtn4 setImage:[UIImage imageNamed:@"clean_nor"] forState:UIControlStateNormal];
    [payEmptyBtn4 setImage:[UIImage imageNamed:@"clean_sel"] forState:UIControlStateNormal];
    [payEmptyBtn4 addTarget:self action:@selector(payEmptyBtn4Action:) forControlEvents:UIControlEventTouchUpInside];
    [pointView addSubview:payEmptyBtn4];
    
    UILabel *pay5 = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 200, 40)];
    pay5.textColor = [UIColor blackColor];
    pay5.textAlignment = NSTextAlignmentLeft;
    pay5.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [pay5 setText:@"7.69$(100+50 Point)"];
    [pointView addSubview:pay5];
    
    UIView *lineView5 = [[UIView alloc] initWithFrame:CGRectMake(0, 250, WIDTH_FRAME - 80, 0.5)];
    lineView5.backgroundColor = [UIColor grayColor];
    [pointView addSubview:lineView5];
    
    payBtn5 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 215, 30, 30)];
    [payBtn5 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [payBtn5 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [pointView addSubview:payBtn5];
    
    payEmptyBtn5 = [[UIButton alloc] initWithFrame:CGRectMake(0, 210, WIDTH_FRAME - 80, 40)];
    [payEmptyBtn5 setImage:[UIImage imageNamed:@"clean_nor"] forState:UIControlStateNormal];
    [payEmptyBtn5 setImage:[UIImage imageNamed:@"clean_sel"] forState:UIControlStateNormal];
    [payEmptyBtn5 addTarget:self action:@selector(payEmptyBtn5Action:) forControlEvents:UIControlEventTouchUpInside];
    [pointView addSubview:payEmptyBtn5];
    
    UILabel *pay6 = [[UILabel alloc] initWithFrame:CGRectMake(10, 250, 200, 40)];
    pay6.textColor = [UIColor blackColor];
    pay6.textAlignment = NSTextAlignmentLeft;
    pay6.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [pay6 setText:@"25.29$(300+100 Point)"];
    [pointView addSubview:pay6];
    
    UIView *lineView6 = [[UIView alloc] initWithFrame:CGRectMake(0, 290, WIDTH_FRAME - 80, 0.5)];
    lineView6.backgroundColor = [UIColor grayColor];
    [pointView addSubview:lineView6];
    
    payBtn6 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 255, 30, 30)];
    [payBtn6 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [payBtn6 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [pointView addSubview:payBtn6];
    
    payEmptyBtn6 = [[UIButton alloc] initWithFrame:CGRectMake(0, 250, WIDTH_FRAME - 80, 40)];
    [payEmptyBtn6 setImage:[UIImage imageNamed:@"clean_nor"] forState:UIControlStateNormal];
    [payEmptyBtn6 setImage:[UIImage imageNamed:@"clean_sel"] forState:UIControlStateNormal];
    [payEmptyBtn6 addTarget:self action:@selector(payEmptyBtn6Action:) forControlEvents:UIControlEventTouchUpInside];
    [pointView addSubview:payEmptyBtn6];
    
    UILabel *pay7 = [[UILabel alloc] initWithFrame:CGRectMake(10, 290, 200, 40)];
    pay7.textColor = [UIColor blackColor];
    pay7.textAlignment = NSTextAlignmentLeft;
    pay7.font = [UIFont fontWithName:@"Helvetica" size:18.0];
    [pay7 setText:@"43.99$(500+300 Point)"];
    [pointView addSubview:pay7];
    
    UIView *lineView7 = [[UIView alloc] initWithFrame:CGRectMake(0, 330, WIDTH_FRAME - 80, 0.5)];
    lineView7.backgroundColor = [UIColor grayColor];
    [pointView addSubview:lineView7];
    
    payBtn7 = [[UIButton alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 295, 30, 30)];
    [payBtn7 setImage:[UIImage imageNamed:@"unchecked.png"] forState:UIControlStateNormal];
    [payBtn7 setImage:[UIImage imageNamed:@"checked.png"] forState:UIControlStateSelected];
    [pointView addSubview:payBtn7];
    
    payEmptyBtn7 = [[UIButton alloc] initWithFrame:CGRectMake(0, 290, WIDTH_FRAME - 80, 40)];
    [payEmptyBtn7 setImage:[UIImage imageNamed:@"clean_nor"] forState:UIControlStateNormal];
    [payEmptyBtn7 setImage:[UIImage imageNamed:@"clean_sel"] forState:UIControlStateNormal];
    [payEmptyBtn7 addTarget:self action:@selector(payEmptyBtn7Action:) forControlEvents:UIControlEventTouchUpInside];
    [pointView addSubview:payEmptyBtn7];
    
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 330, (WIDTH_FRAME - 80)/2, 40)];
    [cancelBtn setTitle:@"취소" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [pointView addSubview:cancelBtn];
    
    UIView *lineView8 = [[UIView alloc] initWithFrame:CGRectMake((WIDTH_FRAME - 80)/2, 330, 1, 40)];
    lineView8.backgroundColor = [UIColor grayColor];
    [pointView addSubview:lineView8];
    
    UIButton *submitBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH_FRAME - 80)/2, 330, (WIDTH_FRAME - 80)/2, 40)];
    [submitBtn setTitle:@"선택" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [submitBtn addTarget:self action:@selector(submitAction:) forControlEvents:UIControlEventTouchUpInside];
    [pointView addSubview:submitBtn];
    
    pointView.hidden = YES;
    
    loadingView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - 40 + self.frame.origin.x, self.frame.size.height/2 - 40 + self.frame.origin.y, 80, 80)];
    loadingView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    loadingView.clipsToBounds = YES;
    loadingView.layer.cornerRadius = 10.0;
    
    activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityView.frame = CGRectMake(24, 22, activityView.bounds.size.width, activityView.bounds.size.height);
    [loadingView addSubview:activityView];
    [self addSubview:loadingView];
    loadingView.hidden = YES;
}

- (void)reloadText{
    if(LOGIN_CHECK == 1){
        idText.text = @"유럽초심자";
        nameText.text = [defaults stringForKey:KEY_NAME];
        postText.text = [defaults stringForKey:KEY_MY_EA];
        bookmarkText.text = [defaults stringForKey:KEY_CHOO];
        pointText.text = [defaults stringForKey:KEY_LEVEL];
        
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/MY_IMG/%@", [defaults stringForKey:KEY_IMAGE]]]];
        profileImage.image = [UIImage imageWithData:imageData];
        if([defaults stringForKey:KEY_IMAGE].length == 0){
            profileImage.image = [UIImage imageNamed:@"menu_icon.png"];
        }
    }
    
    if(WIDTH_FRAME == 320){
        if(HEIGHT_FRAME == 480){
            [menuScrollView setContentSize:CGSizeMake(230, 860)];
        }else{
            [menuScrollView setContentSize:CGSizeMake(230, 760)];
        }
    }else{
        [menuScrollView setContentSize:CGSizeMake(230, 670)];
    }
    if(WIDTH_FRAME == 414){
        menuScrollView.scrollEnabled = NO;
    }
}

- (IBAction)myPageButton:(id)sender {
    [delegate DrawerSelection:0];
}

- (IBAction)pointButton:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"알림" message:@"준비중입니다."
                                                   delegate:self cancelButtonTitle:nil otherButtonTitles:@"확인" ,nil];
    [alert show];
    /*
    UIActionSheet *menu = [[UIActionSheet alloc]
                           initWithTitle: @"가격을 선택하세요" delegate:self cancelButtonTitle:@"취소" destructiveButtonTitle:nil otherButtonTitles:@"0.99$(10 Point)", @"2.99$(30 Point)", @"4.99$(50 Point)", @"6.99$(70 Point)", @"8.99$(100+50 Point", @"26.99$(300+100 Point)", @"43.99$(500+300 Point)",  nil];
    [menu showInView:self];
     */
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        pointValue = @"10";
        pointName = @"포인트 결제 1000원";
        inappBundelId = @"helloweurope.point10";
    }else if(buttonIndex == 1){
        pointValue = @"30";
        pointName = @"포인트 결제 3000원";
        inappBundelId = @"helloweurope.point30";
    }else if(buttonIndex == 2){
        pointValue = @"50";
        pointName = @"포인트 결제 5000원";
        inappBundelId = @"helloweurope.point50";
    }else if(buttonIndex == 3){
        pointValue = @"70";
        pointName = @"포인트 결제 7000원";
        inappBundelId = @"helloweurope.point70";
    }else if(buttonIndex == 4){
        pointValue = @"150";
        pointName = @"포인트 결제 10000원";
        inappBundelId = @"helloweurope.point150";
    }else if(buttonIndex == 5){
        pointValue = @"400";
        pointName = @"포인트 결제 30000원";
        inappBundelId = @"helloweurope.point400";
    }else if(buttonIndex == 6){
        pointValue = @"800";
        pointName = @"포인트 결제 50000원";
        inappBundelId = @"helloweurope.point800";
    }else{
        loadingView.hidden = YES;
        [activityView stopAnimating];
        return;
    }
    
    [self inappLoad];
}

- (IBAction)noticeButton:(id)sender {
    [delegate DrawerSelection:3];
}

- (IBAction)introduceButton:(id)sender {
    [delegate DrawerSelection:4];
}

- (IBAction)questionButton:(id)sender {
    [delegate DrawerSelection:5];
}

- (IBAction)oneoneButton:(id)sender {
    [delegate DrawerSelection:6];
}

- (IBAction)adQButton:(id)sender {
    [delegate DrawerSelection:7];
}

- (IBAction)logoutButton:(id)sender {
    [delegate DrawerSelection:8];
}

- (IBAction)settingButton:(id)sender {
    [delegate DrawerSelection:9];
}

- (IBAction)bottomButton1:(id)sender {
    [delegate DrawerSelection:10];
}

- (IBAction)bottomButton2:(id)sender {
    [delegate DrawerSelection:11];
}

#pragma mark -
#pragma mark Button Action

- (void)buttonSelect:(NSInteger)index{
    payBtn1.selected = 0;
    payBtn2.selected = 0;
    payBtn3.selected = 0;
    payBtn4.selected = 0;
    payBtn5.selected = 0;
    payBtn6.selected = 0;
    payBtn7.selected = 0;
    
    if(index == 0){
        payBtn1.selected = 1;
    }else if(index == 1){
        payBtn2.selected = 1;
    }else if(index == 2){
        payBtn3.selected = 1;
    }else if(index == 3){
        payBtn4.selected = 1;
    }else if(index == 4){
        payBtn5.selected = 1;
    }else if(index == 5){
        payBtn6.selected = 1;
    }else if(index == 6){
        payBtn7.selected = 1;
    }
}

- (void)payEmptyBtn1Action:(UIButton*)sender{
    [self buttonSelect:0];
}

- (void)payEmptyBtn2Action:(UIButton*)sender{
    [self buttonSelect:1];
}

- (void)payEmptyBtn3Action:(UIButton*)sender{
    [self buttonSelect:2];
}

- (void)payEmptyBtn4Action:(UIButton*)sender{
    [self buttonSelect:3];
}

- (void)payEmptyBtn5Action:(UIButton*)sender{
    [self buttonSelect:4];
}

- (void)payEmptyBtn6Action:(UIButton*)sender{
    [self buttonSelect:5];
}

- (void)payEmptyBtn7Action:(UIButton*)sender{
    [self buttonSelect:6];
}

- (void)cancelAction:(UIButton*)sender{
    POINT_CHECK = 0;
    pointView.hidden = YES;
    popupView.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popupViewN" object:nil userInfo:nil];
}

- (void)submitAction:(UIButton*)sender{
    POINT_CHECK = 0;
    pointView.hidden = YES;
    popupView.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popupViewN" object:nil userInfo:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 8888){
        [self pointResult];
    }
}
#pragma mark -
#pragma mark Inapp

- (void)popupY{
    POINT_CHECK = 0;
    popupView.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popupViewN" object:nil userInfo:nil];
}

- (void)popupN{
    POINT_CHECK = 0;
    popupView.hidden = YES;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popupViewN" object:nil userInfo:nil];
}

- (void)pointResult{
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, INAPP_POINT_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"point=%@&self_id=%@&name=%@", pointValue, [defaults stringForKey:KEY_INDEX], pointName];
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
        if (statusCode == 200) {
            NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            pointText.text = resultValue;
        }
    }];
    [dataTask resume];
    
    [self popupN];
}

- (void)inappLoad{
    //Observer를 등록한다.
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    
    if ([SKPaymentQueue canMakePayments]) {
        [self popupY];
        
        //스토어가 사용 가능하다면
        NSLog(@"Start Shop!");
        
        //item에 대한 정보를 애플스토어에 요청
        NSSet *productIdentifiers = [NSSet setWithObjects:inappBundelId, nil];
        SKProductsRequest *productRequest= [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
        productRequest.delegate = self;
        [productRequest start];
        
        loadingView.hidden = NO;
        [activityView startAnimating];
    }else{
        NSLog(@"Failed Shop!");
    }
}

- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
    NSLog(@"products count = %ld", [response.products count]);
    NSLog(@"SKProductRequest got response");
    for (SKProduct *product in response.products) {
        NSLog(@"Title : %@", product.localizedTitle);
        NSLog(@"Description : %@", product.localizedDescription);
        NSLog(@"Price : %@", product.price);
        
        [self paymentRequest:[response.products objectAtIndex:0]];
    }
    
    for (int i=0; i<[response.invalidProductIdentifiers count]; i++) {
        NSString *invalidString = [response.invalidProductIdentifiers objectAtIndex:i];
        NSLog(@"Invalid Identifiers : %@", invalidString);
    }
}

- (void)purchasedTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"구매성공");
    loadingView.hidden = YES;
    [activityView stopAnimating];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"결제가 완료 되었습니다." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil];
    alertView.tag = 8888;
    [alertView show];
}

- (void)failedTransaction:(SKPaymentTransaction *)transaction{
    NSLog(@"구매실패");
    loadingView.hidden = YES;
    [activityView stopAnimating];
    
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"결제에 실패하였습니다. 다시 시도해 주세요." delegate:self cancelButtonTitle:@"확인" otherButtonTitles:nil];
    [alertView show];
    
    [self popupN];
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions{
    for(SKPaymentTransaction *transaction in transactions){
        
        switch(transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:        // 구매완료
                [self purchasedTransaction:transaction];
                break;
                
            case SKPaymentTransactionStateFailed:           // 구매실패
                [self failedTransaction:transaction];
                break;
                
            default:
                break;
        }
    }
}

- (void)paymentRequest:(SKProduct *) product
{
    SKMutablePayment *payment = [SKMutablePayment paymentWithProduct:product];
    payment.quantity = 1;
    
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"restore error");
    
    loadingView.hidden = YES;
    [activityView stopAnimating];
    
    [self popupN];
}

@end
