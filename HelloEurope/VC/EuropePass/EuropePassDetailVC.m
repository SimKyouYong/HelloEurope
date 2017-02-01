//
//  EuropePassDetailVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 6. 4..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "EuropePassDetailVC.h"
#import "GlobalHeader.h"
#import "UIView+Toast.h"
#import "MoneyPayVC.h"

@interface EuropePassDetailVC ()

@end

@implementation EuropePassDetailVC

@synthesize detailDic;
@synthesize detailScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/EuropePath_IMG/%@", [detailDic objectForKey:@"IMG1"]]]];
    UIImage *image1 = [[UIImage alloc] initWithData:imageData1];
    NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/EuropePath_IMG/%@", [detailDic objectForKey:@"IMG2"]]]];
    UIImage *image2 = [[UIImage alloc] initWithData:imageData2];
    NSData *imageData3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/EuropePath_IMG/%@", [detailDic objectForKey:@"IMG3"]]]];
    UIImage *image3 = [[UIImage alloc] initWithData:imageData3];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    imageView1.image = image1;
    imageView1.contentMode = UIViewContentModeScaleAspectFit;
    [detailScrollView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 50, 0, 100, 80)];
    imageView2.image = image2;
    imageView2.contentMode = UIViewContentModeScaleAspectFit;
    [detailScrollView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 12 - 100, 0, 100, 80)];
    imageView3.image = image3;
    imageView3.contentMode = UIViewContentModeScaleAspectFit;
    [detailScrollView addSubview:imageView3];
    
    UILabel *passName = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 150, 15)];
    passName.textColor = [UIColor grayColor];
    passName.textAlignment = NSTextAlignmentLeft;
    passName.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    [passName setNumberOfLines:0];
    [passName setText:@"유효기간"];
    //[detailScrollView addSubview:passName];
    
    UILabel *passTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, WIDTH_FRAME - 36, 40)];
    passTitle.textColor = [UIColor purpleColor];
    passTitle.textAlignment = NSTextAlignmentLeft;
    passTitle.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    [passTitle setNumberOfLines:0];
    [passTitle setText:[detailDic objectForKey:@"MAIN_TITLE"]];
    [detailScrollView addSubview:passTitle];
    
    UILabel *subTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, WIDTH_FRAME - 12 - 10, 20)];
    subTitle.textColor = [UIColor grayColor];
    subTitle.textAlignment = NSTextAlignmentLeft;
    subTitle.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [subTitle setLineBreakMode:NSLineBreakByClipping];
    [subTitle setNumberOfLines:0];
    CGSize constraintSize = CGSizeMake(WIDTH_FRAME - 12 - 40, 1000);
    CGSize newSize = [[detailDic objectForKey:@"SUB_TITLE"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByClipping];
    CGFloat labelHeight = MAX(newSize.height, 20);
    subTitle.text = [detailDic objectForKey:@"SUB_TITLE"];
    subTitle.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:subTitle.font, NSFontAttributeName, subTitle.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size = [subTitle.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 12 - 10, labelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
    [subTitle setFrame:CGRectMake(subTitle.frame.origin.x, subTitle.frame.origin.y, subTitle.frame.size.width, text_size.size.height + 20)];
    [detailScrollView addSubview:subTitle];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 130 + subTitle.frame.size.height, WIDTH_FRAME - 12, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [detailScrollView addSubview:lineView];
    
    UIImageView *priceName = [[UIImageView alloc] initWithFrame:CGRectMake(10, lineView.frame.origin.y + 10, 61, 15)];
    priceName.image = [UIImage imageNamed:@"coupon_price_info_icon"];
    [detailScrollView addSubview:priceName];
    
    UILabel *priceContentName = [[UILabel alloc] initWithFrame:CGRectMake(10, priceName.frame.origin.y + 15 + 10, WIDTH_FRAME - 12 - 10, 20)];
    priceContentName.textColor = [UIColor grayColor];
    priceContentName.textAlignment = NSTextAlignmentLeft;
    priceContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [priceContentName setNumberOfLines:0];
    [priceContentName setText:[detailDic objectForKey:@"PRICE"]];
    [detailScrollView addSubview:priceContentName];
    
    UIImageView *ticketName = [[UIImageView alloc] initWithFrame:CGRectMake(10, priceContentName.frame.origin.y + 20 + 10, 64, 15)];
    ticketName.image = [UIImage imageNamed:@"coupon_ticket_info_icon"];
    [detailScrollView addSubview:ticketName];
    
    /*
    UILabel *ticketContentName = [[UILabel alloc] initWithFrame:CGRectMake(10, ticketName.frame.origin.y + 15 + 10, WIDTH_FRAME - 12 - 40, 30)];
    ticketContentName.textColor = [UIColor purpleColor];
    ticketContentName.textAlignment = NSTextAlignmentLeft;
    ticketContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [ticketContentName setNumberOfLines:2];
    NSString *ticketStr = [detailDic objectForKey:@"PATH_NAME"];
    NSLog(@"%@", ticketStr);
    [ticketContentName setText:ticketStr];
    [detailScrollView addSubview:ticketContentName];
    */
    
    UILabel *ticketSubContentName = [[UILabel alloc] initWithFrame:CGRectMake(10, ticketName.frame.origin.y + 15 + 10, WIDTH_FRAME - 12 - 40, 20)];
    ticketSubContentName.textColor = [UIColor grayColor];
    ticketSubContentName.textAlignment = NSTextAlignmentLeft;
    ticketSubContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [ticketSubContentName setNumberOfLines:0];
    [ticketSubContentName setText:[detailDic objectForKey:@"REASON"]];
    [detailScrollView addSubview:ticketSubContentName];
    
    UIImageView *dangerName = [[UIImageView alloc] initWithFrame:CGRectMake(10, ticketSubContentName.frame.origin.y + 20 + 10, 60, 10)];
    dangerName.image = [UIImage imageNamed:@"coupon_attenzione"];
    [detailScrollView addSubview:dangerName];
    
    UILabel *dangerContentName = [[UILabel alloc] initWithFrame:CGRectMake(10, dangerName.frame.origin.y + 10 + 10, WIDTH_FRAME - 36, 20)];
    dangerContentName.textColor = [UIColor grayColor];
    dangerContentName.textAlignment = NSTextAlignmentLeft;
    dangerContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [dangerContentName setLineBreakMode:NSLineBreakByClipping];
    [dangerContentName setNumberOfLines:0];
    CGSize constraintSize2 = CGSizeMake(WIDTH_FRAME - 12 - 40, 1000);
    CGSize newSize2 = [[detailDic objectForKey:@"READ"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize2 lineBreakMode:NSLineBreakByClipping];
    CGFloat labelHeight2 = MAX(newSize2.height, 20);
    dangerContentName.text = [detailDic objectForKey:@"READ"];
    dangerContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary2 = [NSDictionary dictionaryWithObjectsAndKeys:dangerContentName.font, NSFontAttributeName, dangerContentName.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size2 = [dangerContentName.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 12 - 10, labelHeight2) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary2 context:nil];
    [dangerContentName setFrame:CGRectMake(dangerContentName.frame.origin.x, dangerContentName.frame.origin.y, dangerContentName.frame.size.width, text_size2.size.height + 20)];
    [detailScrollView addSubview:dangerContentName];
    
    UIImageView *priceChangeName = [[UIImageView alloc] initWithFrame:CGRectMake(10, dangerContentName.frame.origin.y + dangerContentName.frame.size.height + 10, 62, 15)];
    priceChangeName.image = [UIImage imageNamed:@"coupon_rufun_regolare_icon"];
    [detailScrollView addSubview:priceChangeName];
    
    UILabel *priceChangeContentName = [[UILabel alloc] initWithFrame:CGRectMake(10, priceChangeName.frame.origin.y + 15, WIDTH_FRAME - 36, 20)];
    priceChangeContentName.textColor = [UIColor grayColor];
    priceChangeContentName.textAlignment = NSTextAlignmentLeft;
    priceChangeContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [priceChangeContentName setLineBreakMode:NSLineBreakByClipping];
    [priceChangeContentName setNumberOfLines:0];
    CGSize constraintSize3 = CGSizeMake(WIDTH_FRAME - 12 - 10, 1000);
    CGSize newSize3 = [[detailDic objectForKey:@"HAN"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize3 lineBreakMode:NSLineBreakByClipping];
    CGFloat labelHeight3 = MAX(newSize3.height, 20);
    priceChangeContentName.text = [detailDic objectForKey:@"HAN"];
    priceChangeContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary3 = [NSDictionary dictionaryWithObjectsAndKeys:priceChangeContentName.font, NSFontAttributeName, priceChangeContentName.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size3 = [priceChangeContentName.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 12 - 10, labelHeight3) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary3 context:nil];
    [priceChangeContentName setFrame:CGRectMake(priceChangeContentName.frame.origin.x, priceChangeContentName.frame.origin.y, priceChangeContentName.frame.size.width, text_size3.size.height + 20)];
    [detailScrollView addSubview:priceChangeContentName];
    
    UIImageView *passMenualName = [[UIImageView alloc] initWithFrame:CGRectMake(10, priceChangeContentName.frame.origin.y + dangerContentName.frame.size.height, 118, 15)];
    passMenualName.image = [UIImage imageNamed:@"coupon_ricevuta_info_icon"];
    [detailScrollView addSubview:passMenualName];
    
    UILabel *passMenualContentName = [[UILabel alloc] initWithFrame:CGRectMake(10, passMenualName.frame.origin.y + 15 + 10, WIDTH_FRAME - 12 - 10, 20)];
    passMenualContentName.textColor = [UIColor grayColor];
    passMenualContentName.textAlignment = NSTextAlignmentLeft;
    passMenualContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [passMenualContentName setLineBreakMode:NSLineBreakByClipping];
    [passMenualContentName setNumberOfLines:0];
    CGSize constraintSize4 = CGSizeMake(WIDTH_FRAME - 12 - 40, 1000);
    CGSize newSize4 = [[detailDic objectForKey:@"PATH_G"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize4 lineBreakMode:NSLineBreakByClipping];
    CGFloat labelHeight4 = MAX(newSize4.height, 20);
    passMenualContentName.text = [detailDic objectForKey:@"PATH_G"];
    passMenualContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary4 = [NSDictionary dictionaryWithObjectsAndKeys:passMenualContentName.font, NSFontAttributeName, passMenualContentName.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size4 = [priceChangeContentName.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 12 - 10, labelHeight4) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary4 context:nil];
    [passMenualContentName setFrame:CGRectMake(passMenualContentName.frame.origin.x, passMenualContentName.frame.origin.y, passMenualContentName.frame.size.width, text_size4.size.height + 20)];
    [detailScrollView addSubview:passMenualContentName];
    
    CGSize contentSize = CGSizeMake(WIDTH_FRAME - 12, passMenualContentName.frame.origin.y + passMenualContentName.frame.size.height + 20);
    [detailScrollView setContentSize:contentSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)cartButton:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@", COMMON_URL, CART_URL];
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: nil delegateQueue: [NSOperationQueue mainQueue]];
    
    NSMutableURLRequest * urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSString * params = [NSString stringWithFormat:@"tag_id=%@&self_id=%@&tag=유럽패스", [detailDic objectForKey:@"KEY_INDEX"], [defaults stringForKey:KEY_INDEX]];
    
    [urlRequest setHTTPMethod:@"POST"];
    [urlRequest setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSURLSessionDataTask * dataTask =[defaultSession dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        //NSLog(@"Response:%@ %@\n", response, error);
        if(error == nil)
        {
            if (data != nil) {
                NSString *resultValue = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
                if([resultValue isEqualToString:@"true"]){
                  [self.navigationController.view makeToast:@"장바구니에 담아졌습니다."];
                }else{
                  [self.navigationController.view makeToast:resultValue];
                }
            }
        }
    }];
    [dataTask resume];
}

- (IBAction)moneyButton:(id)sender {
    MoneyPayVC *moneyPayVC = [[MoneyPayVC alloc] initWithNibName:@"MoneyPayVC" bundle:nil];
    moneyPayVC.moneyDic = detailDic;
    moneyPayVC.passCouponStr = @"유럽패스";
    [self.navigationController pushViewController:moneyPayVC animated:YES];
}

@end
