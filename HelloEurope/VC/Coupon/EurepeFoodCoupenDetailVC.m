//
//  EurepeFoodCoupenDetailVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 29..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "EurepeFoodCoupenDetailVC.h"
#import "GlobalHeader.h"
#import "UIView+Toast.h"
#import "MoneyPayVC.h"

@interface EurepeFoodCoupenDetailVC ()

@end

@implementation EurepeFoodCoupenDetailVC

@synthesize detailDic;
@synthesize europeFoodDetailScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *imageData1 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/Food_IMG/%@", [detailDic objectForKey:@"IMG1"]]]];
    UIImage *image1 = [[UIImage alloc] initWithData:imageData1];
    NSData *imageData2 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/Food_IMG/%@", [detailDic objectForKey:@"IMG2"]]]];
    UIImage *image2 = [[UIImage alloc] initWithData:imageData2];
    NSData *imageData3 = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://coaineu.cafe24.com/Hellow/Food_IMG/%@", [detailDic objectForKey:@"IMG3"]]]];
    UIImage *image3 = [[UIImage alloc] initWithData:imageData3];
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 80)];
    imageView1.image = image1;
    //imageView1.contentMode = UIViewContentModeScaleAspectFit;
    [europeFoodDetailScrollView addSubview:imageView1];
    
    UIImageView *imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_FRAME/2 - 50, 0, 100, 80)];
    imageView2.image = image2;
    //imageView2.contentMode = UIViewContentModeScaleAspectFit;
    [europeFoodDetailScrollView addSubview:imageView2];
    
    UIImageView *imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 12 - 100, 0, 100, 80)];
    imageView3.image = image3;
    //imageView3.contentMode = UIViewContentModeScaleAspectFit;
    [europeFoodDetailScrollView addSubview:imageView3];
    
    UIImageView *scontoImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 62, 52)];
    scontoImage.image = [UIImage imageNamed:@"food_coupon_sconto1"];
    [europeFoodDetailScrollView addSubview:scontoImage];
    
    UILabel *scontoText = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 50, 30)];
    scontoText.textColor = [UIColor whiteColor];
    scontoText.textAlignment = NSTextAlignmentLeft;
    scontoText.font = [UIFont fontWithName:@"Helvetica" size:16.0];
    NSString *scontoTextStr = [NSString stringWithFormat:@"%@", [detailDic objectForKey:@"SALE"]];
    [scontoText setText:scontoTextStr];
    [europeFoodDetailScrollView addSubview:scontoText];
    
    UILabel *foodName = [[UILabel alloc] initWithFrame:CGRectMake(10, 90, 150, 15)];
    foodName.textColor = [UIColor grayColor];
    foodName.textAlignment = NSTextAlignmentLeft;
    foodName.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    [foodName setNumberOfLines:0];
    NSString *timeStr = [NSString stringWithFormat:@"유효기간 : %@", [detailDic objectForKey:@"LONGTIME"]];
    [foodName setText:timeStr];
    //[europeFoodDetailScrollView addSubview:foodName];
    
    UILabel *cityName = [[UILabel alloc] initWithFrame:CGRectMake(10, 95, 150, 16)];
    cityName.textColor = [UIColor blueColor];
    cityName.textAlignment = NSTextAlignmentLeft;
    cityName.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    [cityName setNumberOfLines:0];
    NSString *cityStr = [NSString stringWithFormat:@"[%@] %@", [detailDic objectForKey:@"CITY"], [detailDic objectForKey:@"R_NAME"]];
    [cityName setText:cityStr];
    [europeFoodDetailScrollView addSubview:cityName];
    
    UIImageView *couponImage = [[UIImageView alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 120, 90, 103, 28)];
    couponImage.image = [UIImage imageNamed:@"coupon"];
    [europeFoodDetailScrollView addSubview:couponImage];
    
    UILabel *couponText = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH_FRAME - 114, 90, 80, 28)];
    couponText.textColor = [UIColor redColor];
    couponText.textAlignment = NSTextAlignmentCenter;
    couponText.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    NSString *couponStr = [NSString stringWithFormat:@"%@ 할인 쿠폰", [detailDic objectForKey:@"SALE"]];
    [couponText setText:couponStr];
    [europeFoodDetailScrollView addSubview:couponText];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 128, WIDTH_FRAME - 12, 0.5)];
    lineView.backgroundColor = [UIColor grayColor];
    [europeFoodDetailScrollView addSubview:lineView];
    
    UILabel *resName = [[UILabel alloc] initWithFrame:CGRectMake(10, 136, 150, 15)];
    resName.textColor = [UIColor redColor];
    resName.textAlignment = NSTextAlignmentLeft;
    resName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [resName setNumberOfLines:0];
    [resName setText:@"레스토랑 설명"];
    [europeFoodDetailScrollView addSubview:resName];
    
    UILabel *resContentName = [[UILabel alloc] initWithFrame:CGRectMake(20, 150, WIDTH_FRAME - 12 - 20, 20)];
    resContentName.textColor = [UIColor grayColor];
    resContentName.textAlignment = NSTextAlignmentLeft;
    resContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [resContentName setLineBreakMode:NSLineBreakByClipping];
    [resContentName setNumberOfLines:0];
    CGSize constraintSize = CGSizeMake(WIDTH_FRAME - 12 - 40, 1000);
    CGSize newSize = [[detailDic objectForKey:@"FEATURE"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByClipping];
    CGFloat labelHeight = MAX(newSize.height, 20);
    resContentName.text = [detailDic objectForKey:@"FEATURE"];
    resContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:resContentName.font, NSFontAttributeName, resContentName.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size = [resContentName.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 12 - 40, labelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
    [resContentName setFrame:CGRectMake(resContentName.frame.origin.x, resContentName.frame.origin.y, resContentName.frame.size.width, text_size.size.height + 20)];
    [europeFoodDetailScrollView addSubview:resContentName];
    
    UILabel *menuName = [[UILabel alloc] initWithFrame:CGRectMake(10, 154 + resContentName.frame.size.height, 150, 15)];
    menuName.textColor = [UIColor redColor];
    menuName.textAlignment = NSTextAlignmentLeft;
    menuName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [menuName setNumberOfLines:0];
    [menuName setText:@"추천 메뉴"];
    [europeFoodDetailScrollView addSubview:menuName];
    
    UILabel *menuContentName = [[UILabel alloc] initWithFrame:CGRectMake(20, menuName.frame.origin.y + 10, WIDTH_FRAME - 12 - 20, 20)];
    menuContentName.textColor = [UIColor grayColor];
    menuContentName.textAlignment = NSTextAlignmentLeft;
    menuContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [menuContentName setLineBreakMode:NSLineBreakByClipping];
    [menuContentName setNumberOfLines:0];
    CGSize constraintSize2 = CGSizeMake(WIDTH_FRAME - 12 - 40, 1000);
    CGSize newSize2 = [[detailDic objectForKey:@"MENU"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize2 lineBreakMode:NSLineBreakByClipping];
    CGFloat labelHeight2 = MAX(newSize2.height, 20);
    menuContentName.text = [detailDic objectForKey:@"MENU"];
    menuContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary2 = [NSDictionary dictionaryWithObjectsAndKeys:menuContentName.font, NSFontAttributeName, menuContentName.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size2 = [menuContentName.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 12 - 40, labelHeight2) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary2 context:nil];
    [menuContentName setFrame:CGRectMake(menuContentName.frame.origin.x, menuContentName.frame.origin.y, menuContentName.frame.size.width, text_size2.size.height + 20)];
    [europeFoodDetailScrollView addSubview:menuContentName];
    
    UILabel *addressName = [[UILabel alloc] initWithFrame:CGRectMake(10, menuContentName.frame.origin.y + menuContentName.frame.size.height, 150, 15)];
    addressName.textColor = [UIColor redColor];
    addressName.textAlignment = NSTextAlignmentLeft;
    addressName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [addressName setNumberOfLines:0];
    [addressName setText:@"주소"];
    [europeFoodDetailScrollView addSubview:addressName];
    
    UILabel *addressContentName = [[UILabel alloc] initWithFrame:CGRectMake(20, addressName.frame.origin.y + 10, WIDTH_FRAME - 12 - 20, 20)];
    addressContentName.textColor = [UIColor grayColor];
    addressContentName.textAlignment = NSTextAlignmentLeft;
    addressContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [addressContentName setLineBreakMode:NSLineBreakByClipping];
    [addressContentName setNumberOfLines:0];
    CGSize constraintSize3 = CGSizeMake(WIDTH_FRAME - 12 - 40, 1000);
    CGSize newSize3 = [[detailDic objectForKey:@"ADDRESS"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize3 lineBreakMode:NSLineBreakByClipping];
    CGFloat labelHeight3 = MAX(newSize3.height, 20);
    addressContentName.text = [detailDic objectForKey:@"ADDRESS"];
    addressContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary3 = [NSDictionary dictionaryWithObjectsAndKeys:addressContentName.font, NSFontAttributeName, addressContentName.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size3 = [addressContentName.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 12 - 40, labelHeight3) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary3 context:nil];
    [addressContentName setFrame:CGRectMake(addressContentName.frame.origin.x, addressContentName.frame.origin.y, addressContentName.frame.size.width, text_size3.size.height + 20)];
    [europeFoodDetailScrollView addSubview:addressContentName];
    
    UILabel *boonName = [[UILabel alloc] initWithFrame:CGRectMake(10, addressContentName.frame.origin.y + addressContentName.frame.size.height, 150, 15)];
    boonName.textColor = [UIColor redColor];
    boonName.textAlignment = NSTextAlignmentLeft;
    boonName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [boonName setNumberOfLines:0];
    [boonName setText:@"혜택"];
    [europeFoodDetailScrollView addSubview:boonName];
    
    UILabel *boonContentName = [[UILabel alloc] initWithFrame:CGRectMake(20, boonName.frame.origin.y + 10, WIDTH_FRAME - 12 - 20, 20)];
    boonContentName.textColor = [UIColor grayColor];
    boonContentName.textAlignment = NSTextAlignmentLeft;
    boonContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [boonContentName setLineBreakMode:NSLineBreakByClipping];
    [boonContentName setNumberOfLines:0];
    CGSize constraintSize4 = CGSizeMake(WIDTH_FRAME - 12 - 40, 1000);
    CGSize newSize4 = [[detailDic objectForKey:@"BOON"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize4 lineBreakMode:NSLineBreakByClipping];
    CGFloat labelHeight4 = MAX(newSize4.height, 20);
    boonContentName.text = [detailDic objectForKey:@"BOON"];
    boonContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary4 = [NSDictionary dictionaryWithObjectsAndKeys:boonContentName.font, NSFontAttributeName, boonContentName.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size4 = [boonContentName.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 12 - 40, labelHeight4) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary4 context:nil];
    if([[detailDic objectForKey:@"BOON"] isEqualToString:@""]){
        [boonContentName setFrame:CGRectMake(boonContentName.frame.origin.x, boonContentName.frame.origin.y, WIDTH_FRAME - 12 - 40, 40)];
    }else{
        [boonContentName setFrame:CGRectMake(boonContentName.frame.origin.x, boonContentName.frame.origin.y, boonContentName.frame.size.width, text_size4.size.height + 20)];
    }
    [europeFoodDetailScrollView addSubview:boonContentName];
    
    UILabel *priceName = [[UILabel alloc] initWithFrame:CGRectMake(10, boonContentName.frame.origin.y + boonContentName.frame.size.height, 150, 15)];
    priceName.textColor = [UIColor redColor];
    priceName.textAlignment = NSTextAlignmentLeft;
    priceName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [priceName setNumberOfLines:0];
    [priceName setText:@"가격대"];
    [europeFoodDetailScrollView addSubview:priceName];
    
    UILabel *priceContentName = [[UILabel alloc] initWithFrame:CGRectMake(20, priceName.frame.origin.y + 10, WIDTH_FRAME - 12 - 20, 20)];
    priceContentName.textColor = [UIColor grayColor];
    priceContentName.textAlignment = NSTextAlignmentLeft;
    priceContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [priceContentName setLineBreakMode:NSLineBreakByClipping];
    [priceContentName setNumberOfLines:0];
    CGSize constraintSize5 = CGSizeMake(WIDTH_FRAME - 12 - 40, 1000);
    CGSize newSize5 = [[detailDic objectForKey:@"PRICE"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize5 lineBreakMode:NSLineBreakByClipping];
    CGFloat labelHeight5 = MAX(newSize5.height, 20);
    priceContentName.text = [detailDic objectForKey:@"PRICE"];
    priceContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary5 = [NSDictionary dictionaryWithObjectsAndKeys:boonContentName.font, NSFontAttributeName, boonContentName.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size5 = [boonContentName.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 12 - 40, labelHeight5) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary5 context:nil];
    if([[detailDic objectForKey:@"PRICE"] isEqualToString:@""]){
        [priceContentName setFrame:CGRectMake(priceContentName.frame.origin.x, priceContentName.frame.origin.y, WIDTH_FRAME - 12 - 40, 40)];
    }else{
        [priceContentName setFrame:CGRectMake(priceContentName.frame.origin.x, priceContentName.frame.origin.y, priceContentName.frame.size.width, text_size5.size.height + 20)];
    }
    [europeFoodDetailScrollView addSubview:priceContentName];
    
    UILabel *phoneName = [[UILabel alloc] initWithFrame:CGRectMake(10, priceContentName.frame.origin.y + priceContentName.frame.size.height, 150, 15)];
    phoneName.textColor = [UIColor redColor];
    phoneName.textAlignment = NSTextAlignmentLeft;
    phoneName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [phoneName setNumberOfLines:0];
    [phoneName setText:@"전화번호"];
    [europeFoodDetailScrollView addSubview:phoneName];
    
    UILabel *phoneContentName = [[UILabel alloc] initWithFrame:CGRectMake(20, phoneName.frame.origin.y + 20, WIDTH_FRAME - 12 - 20, 20)];
    phoneContentName.textColor = [UIColor grayColor];
    phoneContentName.textAlignment = NSTextAlignmentLeft;
    phoneContentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [phoneContentName setNumberOfLines:0];
    [phoneContentName setText:[detailDic objectForKey:@"PHONE"]];
    [europeFoodDetailScrollView addSubview:phoneContentName];
    
    CGSize contentSize = CGSizeMake(WIDTH_FRAME - 12, phoneContentName.frame.origin.y + phoneContentName.frame.size.height + 20);
    [europeFoodDetailScrollView setContentSize:contentSize];
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
    NSString * params = [NSString stringWithFormat:@"tag_id=%@&self_id=%@&tag=맛집쿠폰", [detailDic objectForKey:@"KEY_INDEX"], [defaults stringForKey:KEY_INDEX]];
    
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
    moneyPayVC.passCouponStr = @"맛집";
    [self.navigationController pushViewController:moneyPayVC animated:YES];
}

@end
