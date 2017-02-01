//
//  AudioGuideFoodVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 19..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "AudioGuideFoodVC.h"
#import "GlobalHeader.h"

@interface AudioGuideFoodVC ()

@end

@implementation AudioGuideFoodVC

@synthesize foodDic;
@synthesize foodMainImageView;
@synthesize foodImageView;
@synthesize foodScrollView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@", foodDic);
    
    swipeNum = 0;
    
    //해상도 가져오기
    CGRect screenRect = [[UIScreen mainScreen] bounds]; //스크린에 대한 모든 정보
    NSInteger screenWidth = screenRect.size.width; //스크린의 넓이
    NSInteger screenHeight = screenRect.size.height; //스크린의 길이

    
    NSString *mainImageName = [NSString stringWithFormat:@"%@.jpg", [foodDic objectForKey:@"col_9"]];
    NSString *chooseImageName1 = [NSString stringWithFormat:@"%@.jpg", [foodDic objectForKey:@"col_9"]];
    NSString *chooseImageName2 = [NSString stringWithFormat:@"%@.jpg", [foodDic objectForKey:@"col_10"]];
    NSString *chooseImageName3 = [NSString stringWithFormat:@"%@.jpg", [foodDic objectForKey:@"col_11"]];
    
    foodMainImageView.image = [UIImage imageNamed:mainImageName];
    
    leftImageView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, (screenWidth-30)/3, ((screenWidth-30)/3) * 0.7)];
    [leftImageView setImage:[UIImage imageNamed:chooseImageName1] forState:UIControlStateNormal];
    [leftImageView setImage:[UIImage imageNamed:chooseImageName1] forState:UIControlStateHighlighted];
    [leftImageView addTarget:self action:@selector(selectFoodChange1Action:) forControlEvents:UIControlEventTouchUpInside];
    [foodImageView addSubview:leftImageView];
    
    centerImageView = [[UIButton alloc] initWithFrame:CGRectMake(((screenWidth-30)/3) + 10, 0, (screenWidth-30)/3, ((screenWidth-30)/3) * 0.7)];
    [centerImageView setImage:[UIImage imageNamed:chooseImageName2] forState:UIControlStateNormal];
    [centerImageView setImage:[UIImage imageNamed:chooseImageName2] forState:UIControlStateHighlighted];
    [centerImageView addTarget:self action:@selector(selectFoodChange2Action:) forControlEvents:UIControlEventTouchUpInside];
    [foodImageView addSubview:centerImageView];
    
    rightImageView = [[UIButton alloc] initWithFrame:CGRectMake((((screenWidth-30)/3)*2) + 17 , 0, (screenWidth-30)/3, ((screenWidth-30)/3) * 0.7)];
    [rightImageView setImage:[UIImage imageNamed:chooseImageName3] forState:UIControlStateNormal];
    [rightImageView setImage:[UIImage imageNamed:chooseImageName3] forState:UIControlStateHighlighted];
    [rightImageView addTarget:self action:@selector(selectFoodChange3Action:) forControlEvents:UIControlEventTouchUpInside];
    [foodImageView addSubview:rightImageView];
    
    UIButton *swipeButton = [[UIButton alloc] initWithFrame:CGRectMake(10, 50, WIDTH_FRAME - 32, 200)];
    [swipeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [self.view addSubview:swipeButton];
    [self.view addSubview:swipeButton];
    [self.view bringSubviewToFront:swipeButton];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(foodHandleSwipe:)];
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(foodHandleSwipe:)];
    [swipeLeft setDirection:UISwipeGestureRecognizerDirectionLeft];
    [swipeRight setDirection:UISwipeGestureRecognizerDirectionRight];
    [swipeButton addGestureRecognizer:swipeLeft];
    [swipeButton addGestureRecognizer:swipeRight];
    
    UILabel *foodName = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
    foodName.textColor = [UIColor purpleColor];
    foodName.textAlignment = NSTextAlignmentLeft;
    foodName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [foodName setNumberOfLines:0];
    [foodName setText:@"음식적 이름 : "];
    [foodScrollView addSubview:foodName];
    
    UILabel *foodName2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 0, WIDTH_FRAME - 76, 20)];
    foodName2.textColor = [UIColor grayColor];
    foodName2.textAlignment = NSTextAlignmentLeft;
    foodName2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [foodName2 setNumberOfLines:1];
    [foodName2 setText:[foodDic objectForKey:@"col_1"]];
    [foodScrollView addSubview:foodName2];
    
    
    
    
    
    
    
    
    UILabel *addressName = [[UILabel alloc] initWithFrame:CGRectMake(0, foodName2.frame.size.height + 20, 70, 20)];
    addressName.textColor = [UIColor purpleColor];
    addressName.textAlignment = NSTextAlignmentLeft;
    addressName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [addressName setNumberOfLines:0];
    [addressName setText:@"주          소 : "];
    [foodScrollView addSubview:addressName];
    
    UILabel *addressName2 = [[UILabel alloc] initWithFrame:CGRectMake(70, foodName2.frame.size.height + 20, WIDTH_FRAME - 100, 30)];
    addressName2.textColor = [UIColor grayColor];
    addressName2.textAlignment = NSTextAlignmentLeft;
    addressName2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [addressName2 setNumberOfLines:2];
    [addressName2 setText:[foodDic objectForKey:@"col_4"]];
    [foodScrollView addSubview:addressName2];
    
    
    
    
    
    
    
    
    
    
    UILabel *phoneNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, foodName2.frame.size.height + addressName2.frame.size.height + 40 , 70, 20)];
    phoneNumber.textColor = [UIColor purpleColor];
    phoneNumber.textAlignment = NSTextAlignmentLeft;
    phoneNumber.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [phoneNumber setNumberOfLines:0];
    [phoneNumber setText:@"전 화 번 호 : "];
    [foodScrollView addSubview:phoneNumber];
    
    UILabel *phoneNumber2 = [[UILabel alloc] initWithFrame:CGRectMake(70, foodName2.frame.size.height + addressName2.frame.size.height + 40, WIDTH_FRAME - 100, 20)];
    phoneNumber2.textColor = [UIColor grayColor];
    phoneNumber2.textAlignment = NSTextAlignmentLeft;
    phoneNumber2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [phoneNumber2 setNumberOfLines:0];
    [phoneNumber2 setText:[foodDic objectForKey:@"col_5"]];
    [foodScrollView addSubview:phoneNumber2];
    
    
    
    
    
    
    
    
    
    
    
    
    UILabel *other = [[UILabel alloc] initWithFrame:CGRectMake(0, foodName2.frame.size.height + addressName2.frame.size.height + phoneNumber2.frame.size.height + 60, 70, 20)];
    other.textColor = [UIColor purpleColor];
    other.textAlignment = NSTextAlignmentLeft;
    other.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [other setNumberOfLines:0];
    [other setText:@"종          류 : "];
    [foodScrollView addSubview:other];
    
    UILabel *other2 = [[UILabel alloc] initWithFrame:CGRectMake(70, foodName2.frame.size.height + addressName2.frame.size.height + phoneNumber2.frame.size.height + 60, WIDTH_FRAME - 100, 20)];
    other2.textColor = [UIColor grayColor];
    other2.textAlignment = NSTextAlignmentLeft;
    other2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [other2 setNumberOfLines:0];
    [other2 setText:[foodDic objectForKey:@"col_7"]];
    [foodScrollView addSubview:other2];
    
    
    
    
    
    
    
    
    
    
    
    
    UILabel *timeName = [[UILabel alloc] initWithFrame:CGRectMake(0, foodName2.frame.size.height + addressName2.frame.size.height + phoneNumber2.frame.size.height + other2.frame.size.height + 80, 70, 20)];
    timeName.textColor = [UIColor purpleColor];
    timeName.textAlignment = NSTextAlignmentLeft;
    timeName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [timeName setNumberOfLines:0];
    [timeName setText:@"영 업 시 간 : "];
    [foodScrollView addSubview:timeName];
    
    UILabel *timeName2 = [[UILabel alloc] initWithFrame:CGRectMake(70, foodName2.frame.size.height + addressName2.frame.size.height + phoneNumber2.frame.size.height + other2.frame.size.height + 80, WIDTH_FRAME - 100, 46)];
    timeName2.textColor = [UIColor grayColor];
    timeName2.textAlignment = NSTextAlignmentLeft;
    timeName2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [timeName2 setNumberOfLines:0];
    [timeName2 setText:[foodDic objectForKey:@"col_8"]];
    [foodScrollView addSubview:timeName2];
    
    
    
    
    
    
    
    
    
    
    
    
    
    UILabel *contentName = [[UILabel alloc] initWithFrame:CGRectMake(0, foodName2.frame.size.height + addressName2.frame.size.height + phoneNumber2.frame.size.height + other2.frame.size.height + timeName2.frame.size.height + 100, 70, 20)];
    contentName.textColor = [UIColor purpleColor];
    contentName.textAlignment = NSTextAlignmentLeft;
    contentName.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [contentName setNumberOfLines:0];
    [contentName setText:@"설          명 : "];
    [foodScrollView addSubview:contentName];
    
    UILabel *contentName2 = [[UILabel alloc] initWithFrame:CGRectMake(70, foodName2.frame.size.height + addressName2.frame.size.height + phoneNumber2.frame.size.height + other2.frame.size.height + timeName2.frame.size.height + 100, WIDTH_FRAME - 76, 20)];
    contentName2.textColor = [UIColor grayColor];
    contentName2.textAlignment = NSTextAlignmentLeft;
    contentName2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    [contentName2 setLineBreakMode:NSLineBreakByClipping];
    [contentName2 setNumberOfLines:0];
    
    
    
    CGSize constraintSize = CGSizeMake(WIDTH_FRAME - 32, 1000);
    CGSize newSize = [[foodDic objectForKey:@"col_12"] sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByClipping];
    labelHeight = MAX(newSize.height, 20);
    contentName2.text = [foodDic objectForKey:@"col_12"];
    contentName2.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:contentName2.font, NSFontAttributeName, contentName2.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size = [contentName2.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 76, labelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];

    CGSize contentSize = CGSizeMake(WIDTH_FRAME - 12, contentName2.frame.origin.y + text_size.size.height + 10);
    
    [contentName2 setFrame:CGRectMake(contentName2.frame.origin.x, contentName2.frame.origin.y, contentName2.frame.size.width, text_size.size.height )];
    [foodScrollView addSubview:contentName2];
    [foodScrollView setContentSize:contentSize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Swipe

- (void)foodHandleSwipe:(UISwipeGestureRecognizer *)swipe {
    if (swipe.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSLog(@"Left Swipe");
        if(swipeNum + 1 == 3){
            return;
        }
        swipeNum++;
        [self swipeFoodImageLoad:swipeNum];
    }
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"Right Swipe");
        if(swipeNum == 0){
            return;
        }
        swipeNum--;
        [self swipeFoodImageLoad:swipeNum];
    }
}

- (void)swipeFoodImageLoad:(NSInteger)index{
    NSString *imageName = @"";
    
    if(index == 0){
        imageName = [foodDic objectForKey:@"col_9"];
    }else if(index == 1){
        imageName = [foodDic objectForKey:@"col_10"];
    }else if(index == 2){
        imageName = [foodDic objectForKey:@"col_11"];
    }
    
    NSString *mainImageName = [NSString stringWithFormat:@"%@.jpg", imageName];
    foodMainImageView.image = [UIImage imageNamed:mainImageName];
}

- (void)selectFoodChange1Action:(UIButton *)sender{
    swipeNum = 0;
    NSString *imageName = [foodDic objectForKey:@"col_9"];
    NSString *mainImageName = [NSString stringWithFormat:@"%@.jpg", imageName];
    foodMainImageView.image = [UIImage imageNamed:mainImageName];
}

- (void)selectFoodChange2Action:(UIButton *)sender{
    swipeNum = 1;
    NSString *imageName = [foodDic objectForKey:@"col_10"];
    NSString *mainImageName = [NSString stringWithFormat:@"%@.jpg", imageName];
    foodMainImageView.image = [UIImage imageNamed:mainImageName];
}

- (void)selectFoodChange3Action:(UIButton *)sender{
    swipeNum = 2;
    NSString *imageName = [foodDic objectForKey:@"col_11"];
    NSString *mainImageName = [NSString stringWithFormat:@"%@.jpg", imageName];
    foodMainImageView.image = [UIImage imageNamed:mainImageName];
}

@end
