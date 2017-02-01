//
//  AudioGuideDetailVC.h
//  HelloEurope
//
//  Created by Joseph on 2016. 5. 18..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HTTPNetworkManager.h"
#import <MediaPlayer/MediaPlayer.h>

@interface AudioGuideDetailVC : UIViewController<ASIHTTPRequestDelegate>{
    NSMutableArray *audioDetailListArr;
    NSMutableArray *audioDetailFoodListArr;
    
    MPMoviePlayerController *mplayer;
   
    HTTPNetworkManager *requestDownload;

    UIProgressView *multiProgress;
    
    NSInteger downloadCount;

    UIActivityIndicatorView *activityView;
    
    NSString *pointStr;
}

@property (assign, nonatomic) NSString *cityNameStr;
@property (assign, nonatomic) NSString *countryNameStr;

@property (weak, nonatomic) IBOutlet UITableView *audioDetailTableView;
@property (weak, nonatomic) IBOutlet UIScrollView *audioDetailScrollView;
@property (weak, nonatomic) IBOutlet UIView *detailPopupView;
@property (weak, nonatomic) IBOutlet UIButton *audioDownCancelButton;

- (IBAction)backButton:(id)sender;
- (IBAction)audioDownButton:(id)sender;
- (IBAction)audioMapButton:(id)sender;
- (IBAction)audioDownCancelButton:(id)sender;

@end
