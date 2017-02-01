//
//  AudioGuideMapVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 19..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Pin.h"

@interface AudioGuideMapVC : UIViewController<CLLocationManagerDelegate, MKMapViewDelegate>{
    CGFloat labelHeight;
    
    CLLocationManager *locationManager;
    CLLocation *startPoint;
    
    NSMutableArray *arrayLatitude;
    NSMutableArray *arrayLongitude;
    
    NSMutableArray *distance;

    NSInteger pinArrCount;
    
    NSMutableArray *mapTitleClickArr;
    NSString *mapTitle;
    NSString *fileImageName;
    NSString *title;
    NSString *content;
    NSInteger loadCount;
    UILabel *bottomTitle;
    UILabel *bottomContent;
}

@property (assign, nonatomic) NSDictionary *mapDic;
@property (assign, nonatomic) NSString *mapCount;
@property (assign, nonatomic) NSMutableArray *mapArr;

@property (weak, nonatomic) IBOutlet MKMapView *audioMapView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;

- (IBAction)backButton:(id)sender;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) CLLocation *startPoint;
@property (nonatomic, retain) NSMutableArray *arrayLatitude;
@property (nonatomic, retain) NSMutableArray *arrayLongitude;
@property (nonatomic, retain) NSMutableArray *distance;

@end
