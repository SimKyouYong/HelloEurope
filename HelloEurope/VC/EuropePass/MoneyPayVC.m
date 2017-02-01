//
//  MoneyPayVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 8. 21..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "MoneyPayVC.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "MoneyPayDetailVC.h"

@interface MoneyPayVC ()

@end

@implementation MoneyPayVC

@synthesize moneyDic;
@synthesize passCouponStr;
@synthesize nameText;
@synthesize phoneText;
@synthesize emailText;
@synthesize dateText;
@synthesize pickerView;
@synthesize pickerBarView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    pickerView.hidden = YES;
    pickerView.backgroundColor = [UIColor whiteColor];
    
    NSLog(@"%@", moneyDic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickerDone:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy년 MM월 dd일"];
    NSString *formatedDate = [dateFormatter stringFromDate:pickerView.date];
    dateText.text = formatedDate;
    
    [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseIn animations:^{
        pickerView.hidden = YES;
        pickerBarView.hidden = YES;
    }completion:^(BOOL finished){}];
}

- (IBAction)picker:(id)sender {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSString *formatedDate = @"";
    
    [dateFormatter setDateFormat:@"yyyy년 MM월 dd일"];
    formatedDate = [dateFormatter stringFromDate:pickerView.date];
}

- (IBAction)dateButton:(id)sender {
    [nameText resignFirstResponder];
    [phoneText resignFirstResponder];
    [emailText resignFirstResponder];
    
    NSTimeInterval timeStamp = [[NSDate date] timeIntervalSince1970];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeStamp];
    NSDateFormatter *dateFormatterToday = [[NSDateFormatter alloc] init];
    [dateFormatterToday setDateFormat:@"yyyy년 MM월 dd일"];
    
    NSString *formatedDate = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy년 MM월 dd일"];
    NSDate *dayStr = [dateFormatter dateFromString:[dateFormatterToday stringFromDate:date]];
    
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc] init];
    [dateFormatter2 setDateFormat:@"yyyy년 MM월 dd일"];
    [pickerView setDate:dayStr];
    formatedDate = [dateFormatter2 stringFromDate:dayStr];
    
    [UIView animateWithDuration:0.5 delay:0.1 options: UIViewAnimationOptionCurveEaseIn animations:^{
        pickerView.hidden = NO;
        pickerBarView.hidden = NO;
    }completion:^(BOOL finished){}];
    
    pickerView.hidden = NO;
    pickerBarView.hidden = NO;
}

- (IBAction)payButton:(id)sender {
    if(nameText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"이름을 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    if(phoneText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"연락처를 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    if(emailText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"이메일을 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    if(dateText.text.length == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"예약날짜를 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    BOOL numberBool = [self isDigit:phoneText.text];
    if(numberBool == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"숫자만 입력가능합니다." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    BOOL eMailBool = [self checkEmail:emailText.text];
    if(eMailBool == 0){
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"이메일형식을 바르게 입력해주세요." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                             {}];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"20포인트가 차감됩니다." preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {
                             NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                             [defaults synchronize];
                             
                             NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, PAY_URL];
                             NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
                             NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
                             
                             NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
                             NSString * params = [NSString stringWithFormat:@"path_id=%@&a_name=%@&self_id=%@&tag=%@&point=-20&user_id=%@&user_phone=%@&user_email=%@&user_date=%@", [moneyDic objectForKey:@"KEY_INDEX"], [moneyDic objectForKey:@"PATH_NAME"], [defaults stringForKey:KEY_INDEX], passCouponStr, nameText.text, phoneText.text, emailText.text, dateText.text];
                             [urlRequest setHTTPMethod:@"POST"];
                             [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
                             
                             NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                 NSLog(@"Response:%@ %@\n", response, error);
                                 NSInteger statusCode = [(NSHTTPURLResponse *)response statusCode];
                                 if (statusCode == 200) {
                                     xmlParser = [[NSXMLParser alloc] initWithData:data];
                                     xmlParser.delegate = self;
                                     xmlArrData = [[NSMutableArray alloc] init];
                                     xmlDic = [[NSMutableDictionary alloc] init];
                                     foundValue = [[NSMutableString alloc] init];
                                     [xmlParser parse];
                                     
                                 }else{
                                     UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"알림" message:@"다시 시도해주세요." preferredStyle:UIAlertControllerStyleAlert];
                                     
                                     UIAlertAction* ok = [UIAlertAction actionWithTitle:@"확인" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                                          {}];
                                     [alert addAction:ok];
                                     [self presentViewController:alert animated:YES completion:nil];
                                 }
                             }];
                             [dataTask resume];
                         }];
    UIAlertAction* cancel = [UIAlertAction actionWithTitle:@"취소" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                         {}];
    [alert addAction:cancel];
    [alert addAction:ok];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark NSXMLParserDelegate method

- (void)parserDidStartDocument:(NSXMLParser *)parser{
    xmlArrData = [[NSMutableArray alloc] init];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSDictionary *dic = [xmlArrData objectAtIndex:0];
    
    MoneyPayDetailVC *moneyPayDetailVC = [[MoneyPayDetailVC alloc] initWithNibName:@"MoneyPayDetailVC" bundle:nil];
    moneyPayDetailVC.moneyDetailDic = dic;
    [self.navigationController pushViewController:moneyPayDetailVC animated:YES];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"%@", [parseError localizedDescription]);
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
    
    if ([elementName isEqualToString:@"point"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"user_id"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"user_phone"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"user_email"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"user_date"]){
        [xmlDic setObject:[NSString stringWithString:foundValue] forKey:elementName];
    }else if ([elementName isEqualToString:@"key"]){
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    pickerView.hidden = YES;
    pickerBarView.hidden = YES;
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)isDigit:(NSString*)numberString
{
    NSCharacterSet *nonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSRange nond = [numberString rangeOfCharacterFromSet:nonDigits];
    if (NSNotFound == nond.location) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)checkEmail:(NSString *)email {
    const char *tmp = [email cStringUsingEncoding:NSUTF8StringEncoding];
    if (email.length != strlen(tmp)) {
        return NO;
    }

    NSString *check = @"([0-9a-zA-Z_-]+)@([0-9a-zA-Z_-]+)(\\.[0-9a-zA-Z_-]+){1,2}";
    NSRange match = [email rangeOfString:check options:NSRegularExpressionSearch];
    if (NSNotFound == match.location) {
        return NO;
    }
    
    return YES;
}

@end
