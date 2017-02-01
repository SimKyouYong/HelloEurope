//
//  HelloTalkVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "HelloTalkVC.h"
#import "Cell.h"
#import "GlobalHeader.h"
#import "GlobalObject.h"
#import "HelloTalkListVC.h"
#import "DrawerNavigation.h"

@interface HelloTalkVC ()
@property (strong, nonatomic) DrawerNavigation *rootNav;
@end

@implementation HelloTalkVC

@synthesize delegate;
@synthesize helloTable;

- (void)talk:(NSNotification *)noti
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"mainSortButtonHiddenNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"adNotification" object:nil userInfo:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rootNav = (DrawerNavigation *)self.navigationController;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(talk:) name:@"talkNotification" object:nil];
}

- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
    return WIDTH_FRAME/2;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
    if([UIScreen mainScreen].bounds.size.width == 414){
        return 126;
    }else if([UIScreen mainScreen].bounds.size.width == 375){
        return 114;
    }else{
        return 98;
    }
    return 98;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
    return 2;
}


- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
    return 10;
}

- (UIGridViewCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
    Cell *cell = (Cell *)[grid dequeueReusableCell];
    
    if (cell == nil) {
        cell = [[Cell alloc] init];
    }

    NSInteger heightNum;
    if([UIScreen mainScreen].bounds.size.width == 414){
        heightNum = 126;
    }else if([UIScreen mainScreen].bounds.size.width == 375){
        heightNum = 114;
    }else{
        heightNum = 98;
    }
    
    cell.thumbnail.frame = CGRectMake(0, 0, WIDTH_FRAME/2, heightNum);
    NSString *imageName = [NSString stringWithFormat:@"hello_talk_country_%02d_%02d", rowIndex, columnIndex];
    cell.thumbnail.image = [self cropTopImage:[UIImage imageNamed:imageName] width:WIDTH_FRAME/2 height:heightNum];
    
    return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    //NSLog(@"%d, %d clicked", rowIndex, colIndex);
    NSString *country = @"";
    if(rowIndex == 0 && colIndex == 0){
        country = @"이탈리아";
    }else if(rowIndex == 0 && colIndex == 1){
        country = @"프랑스";
    }else if(rowIndex == 1 && colIndex == 0){
        country = @"오스트리아";
    }else if(rowIndex == 1 && colIndex == 1){
        country = @"스페인";
    }else if(rowIndex == 2 && colIndex == 0){
        country = @"독일";
    }else if(rowIndex == 2 && colIndex == 1){
        country = @"스위스";
    }else if(rowIndex == 3 && colIndex == 0){
        country = @"런던";
    }else if(rowIndex == 3 && colIndex == 1){
        country = @"체코&오스트리아";
    }else if(rowIndex == 4 && colIndex == 0){
        country = @"크로아티아";
    }else if(rowIndex == 4 && colIndex == 1){
        country = @"그외도시";
    }
    
    HelloTalkListVC *helloTalkListVC = [[HelloTalkListVC alloc] initWithNibName:@"HelloTalkListVC" bundle:nil];
    helloTalkListVC.countryStr = country;
    [self.navigationController pushViewController:helloTalkListVC animated:YES];
}

- (void)gridViewScrollView{
    if([BOTTOM_AD_CHECK isEqualToString:@"1"]){
        [delegate helloTalkAdHidden];
    }
}

#pragma mark -
#pragma mark Image Bg Scale

- (UIImage*)cropTopImage:(UIImage*)cacheimg width:(NSInteger)width height:(NSInteger)height{
    float ratio = cacheimg.size.width*cacheimg.scale/width;
    
    // 가로 세로 이미지 사이즈 구해짐
    float imgheight = cacheimg.size.height*cacheimg.scale/ratio;
    float imgwidth = width;
    
    cacheimg = [self resizeImage:cacheimg newSize:CGSizeMake(imgwidth, imgheight)];
    //NSLog(@"cache img is %f %f %f %f",cacheimg.size.width, cacheimg.size.height, cacheimg.scale,[[UIScreen mainScreen] scale]);
    cacheimg =  [self cropByImage:cacheimg CGRect:CGRectMake(0, 0, width, height)];
  
    return cacheimg;
}

- (UIImage*)cropByImage:(UIImage*)image CGRect:(CGRect)rect{
    float scale = [[UIScreen mainScreen] scale];
    
    rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width*scale, rect.size.height*scale);
    float imageHeight = image.size.height*scale;
    // 잘랐는데 세로가 너무 짧은경우 그냥 전부 보여준다..
    if (imageHeight < rect.size.height) {
        rect = CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, imageHeight);
    }
    
    // 사이즈 맞게 자르기
    CGImageRef imageREF = CGImageCreateWithImageInRect(image.CGImage, rect);
    UIImage *cropped = [UIImage imageWithCGImage:imageREF];
    CGImageRelease(imageREF);
    
    return cropped;
}

- (UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    CGContextDrawImage(context, newRect, imageRef);
    
    CGContextSetInterpolationQuality(context, kCGInterpolationLow);
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
