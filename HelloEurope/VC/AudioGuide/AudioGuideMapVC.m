//
//  AudioGuideMapVC.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 19..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "AudioGuideMapVC.h"
#import "GlobalHeader.h"
#import "AppDelegate.h"

@interface AudioGuideMapVC ()

@end

@implementation AudioGuideMapVC

@synthesize mapDic;
@synthesize mapCount;
@synthesize mapArr;
@synthesize audioMapView;
@synthesize bottomImageView;
@synthesize bottomScrollView;
@synthesize locationManager, startPoint;
@synthesize arrayLatitude, arrayLongitude;
@synthesize distance;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableArray *reMapArr = [[NSMutableArray alloc] init];
    if([mapCount isEqualToString:@"1"]){
        pinArrCount = 1;
    }else{
        NSDictionary *dic = nil;
        for (int i = 0 ; i < [mapArr count]; i ++) {
            dic = [mapArr objectAtIndex:i];
            if([[dic objectForKey:@"place_name_kr"] isEqualToString:@""]){
                
            }else{
                loadCount = 1;
                NSMutableDictionary *reDic = [[NSMutableDictionary alloc] initWithCapacity:26];
                [reDic setObject:[dic objectForKey:@"address"] forKey:@"address"];
                [reDic setObject:[dic objectForKey:@"big_title"] forKey:@"big_title"];
                [reDic setObject:[dic objectForKey:@"big_type"] forKey:@"big_type"];
                [reDic setObject:[dic objectForKey:@"city_name"] forKey:@"city_name"];
                [reDic setObject:[dic objectForKey:@"city_name_e"] forKey:@"city_name_e"];
                [reDic setObject:[dic objectForKey:@"clouse"] forKey:@"clouse"];
                [reDic setObject:[dic objectForKey:@"coupon"] forKey:@"coupon"];
                [reDic setObject:[dic objectForKey:@"described"] forKey:@"described"];
                [reDic setObject:[dic objectForKey:@"foto_spiegazione_1"] forKey:@"foto_spiegazione_1"];
                [reDic setObject:[dic objectForKey:@"foto_spiegazione_2"] forKey:@"foto_spiegazione_2"];
                [reDic setObject:[dic objectForKey:@"foto_spiegazione_3"] forKey:@"foto_spiegazione_3"];
                [reDic setObject:[dic objectForKey:@"hardness"] forKey:@"hardness"];
                [reDic setObject:[dic objectForKey:@"icon_small"] forKey:@"icon_small"];
                [reDic setObject:[dic objectForKey:@"key_index"] forKey:@"key_index"];
                [reDic setObject:[dic objectForKey:@"latitude"] forKey:@"latitude"];
                [reDic setObject:[dic objectForKey:@"main_title"] forKey:@"main_title"];
                [reDic setObject:[dic objectForKey:@"mp3_file"] forKey:@"mp3_file"];
                [reDic setObject:[dic objectForKey:@"nazionale"] forKey:@"nazionale"];
                [reDic setObject:[dic objectForKey:@"open_time"] forKey:@"open_time"];
                [reDic setObject:[dic objectForKey:@"place_name_en"] forKey:@"place_name_en"];
                [reDic setObject:[dic objectForKey:@"place_name_kr"] forKey:@"place_name_kr"];
                [reDic setObject:[dic objectForKey:@"price"] forKey:@"price"];
                [reDic setObject:[dic objectForKey:@"small_icon"] forKey:@"small_icon"];
                [reDic setObject:[dic objectForKey:@"sub_type"] forKey:@"sub_type"];
                [reDic setObject:[dic objectForKey:@"type_mg"] forKey:@"type_mg"];
                [reDic setObject:[dic objectForKey:@"walk_time"] forKey:@"walk_time"];
                
                [reMapArr addObject:reDic];
                if(fileImageName.length == 0){
                    fileImageName = [dic objectForKey:@"foto_spiegazione_1"];
                    mapTitle = [dic objectForKey:@"place_name_kr"];
                    content = [dic objectForKey:@"described"];
                }
            }
        }
        
        mapDic = dic;
        pinArrCount = [reMapArr count];
    }
    
    [self mapUILoad];
    
    //[audioMapView setShowsUserLocation:YES];
    [audioMapView setMapType:MKMapTypeStandard];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    float rLatitude;
    float rLongitude;
    arrayLatitude = [[NSMutableArray alloc] init];
    arrayLongitude = [[NSMutableArray alloc] init];
    
    for (int i = 0 ; i < pinArrCount; i ++) {
        if(pinArrCount != 1){
            mapDic = [reMapArr objectAtIndex:i];
        }
        if(![[mapDic objectForKey:@"place_name_kr"] isEqualToString:@""]){
            rLatitude = [[mapDic objectForKey:@"latitude"] floatValue];
            rLongitude = [[mapDic objectForKey:@"hardness"] floatValue];
            
            NSNumber *temLatitude = [NSNumber numberWithFloat:rLatitude];
            NSNumber *temrLongitude = [NSNumber numberWithFloat:rLongitude];
            [arrayLatitude addObject:temLatitude];
            [arrayLongitude addObject:temrLongitude];
        }
    }

    for (int i = 0; i < pinArrCount; i++) {
        if(pinArrCount != 1){
            mapDic = [reMapArr objectAtIndex:i];
        }
        if(![[mapDic objectForKey:@"place_name_kr"] isEqualToString:@""]){
            Pin *ann = [[Pin alloc] init];
            ann.title = [NSString stringWithFormat:@"%@", [mapDic objectForKey:@"place_name_kr"]];
            ann.subtitle = [NSString stringWithFormat:@"%@", [mapDic objectForKey:@"icon_small"]];
            CLLocationCoordinate2D center;
            center.latitude = [[arrayLatitude objectAtIndex:i] doubleValue];
            center.longitude = [[arrayLongitude objectAtIndex:i] doubleValue];
            ann.coordinate = center;
            [audioMapView addAnnotation:ann];
        }
    }
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    
    span.latitudeDelta = 0.017;
    span.longitudeDelta = 0.017;
    
    region.center = CLLocationCoordinate2DMake([[arrayLatitude objectAtIndex:0] floatValue], [[arrayLongitude objectAtIndex:0] floatValue]);
    region.span = span;
    
    [audioMapView setRegion:region animated:YES];
    [audioMapView setCenterCoordinate:region.center animated:YES];
    [audioMapView regionThatFits:region];
}

- (MKAnnotationView *)mapView:(MKMapView *)aMapView viewForAnnotation:(id <MKAnnotation>)annotation {
    static NSString *placeMarkIdentifier = @"my annotation identifier";
    
    if ([annotation isKindOfClass:[Pin class]]) {
        MKAnnotationView *annotationView = (MKPinAnnotationView *)[audioMapView dequeueReusableAnnotationViewWithIdentifier:placeMarkIdentifier];
        if (annotationView == nil) {
            annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:placeMarkIdentifier];
            annotationView.image = [UIImage imageNamed:[annotation subtitle]];
            annotationView.canShowCallout = YES;
            annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        }
        else
            annotationView.annotation = annotation;
        return annotationView;
    }
    return nil;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    if(![mapCount isEqualToString:@"1"]){
        mapTitleClickArr = [[NSMutableArray alloc] init];
        id AppID = [[UIApplication sharedApplication] delegate];
        mapTitleClickArr = [AppID selectMapCityName:view.annotation.title];
        mapTitle = view.annotation.title;
        bottomImageView.image = nil;
        bottomTitle.text = @"";
        bottomContent.text = @"";
        loadCount = 2;
        [self mapUILoad];
    }
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
}

- (void)mapUILoad{
    if(![mapCount isEqualToString:@"1"]){
        if(loadCount != 1){
            NSDictionary *dic = [mapTitleClickArr objectAtIndex:0];
            fileImageName = [dic objectForKey:@"foto_spiegazione_1"];
            content = [dic objectForKey:@"described"];
        }
    }else{
        fileImageName = [mapDic objectForKey:@"foto_spiegazione_1"];
        mapTitle = [mapDic objectForKey:@"place_name_kr"];
        content = [mapDic objectForKey:@"described"];
    }
    
    NSString *bottomImageFileName = [NSString stringWithFormat:@"%@.jpg", fileImageName];
    bottomImageView.image = [UIImage imageNamed:bottomImageFileName];
    
    bottomTitle = [[UILabel alloc] initWithFrame:CGRectMake(2, 2, WIDTH_FRAME - 110, 20)];
    bottomTitle.textColor = [UIColor colorWithRed:(85/255.0) green:(194/255.0) blue:(193/255.0) alpha:1];
    bottomTitle.textAlignment = NSTextAlignmentLeft;
    bottomTitle.font = [UIFont fontWithName:@"Helvetica" size:13.0];
    [bottomTitle setNumberOfLines:0];
    [bottomTitle setText:mapTitle];
    [bottomScrollView addSubview:bottomTitle];
    
    bottomContent = [[UILabel alloc] initWithFrame:CGRectMake(2, 15, WIDTH_FRAME - 140, 20)];
    bottomContent.textColor = [UIColor grayColor];
    bottomContent.textAlignment = NSTextAlignmentLeft;
    bottomContent.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    [bottomContent setLineBreakMode:NSLineBreakByClipping];
    [bottomContent setNumberOfLines:0];
    CGSize constraintSize = CGSizeMake(WIDTH_FRAME - 130, 1000);
    CGSize newSize = [content sizeWithFont:[UIFont systemFontOfSize:12.0] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByClipping];
    labelHeight = MAX(newSize.height, 20);
    bottomContent.text = content;
    bottomContent.font = [UIFont fontWithName:@"Helvetica" size:12.0];
    NSDictionary *attributesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:bottomContent.font, NSFontAttributeName, bottomContent.textColor, NSForegroundColorAttributeName, nil];
    CGRect text_size = [bottomContent.text boundingRectWithSize:CGSizeMake(WIDTH_FRAME - 130, labelHeight) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributesDictionary context:nil];
    
    [bottomContent setFrame:CGRectMake(bottomContent.frame.origin.x, bottomContent.frame.origin.y, bottomContent.frame.size.width, text_size.size.height + 20)];
    [bottomScrollView addSubview:bottomContent];
    CGSize contentSize = CGSizeMake(WIDTH_FRAME - 130, bottomContent.frame.origin.y + text_size.size.height);
    [bottomScrollView setContentSize:contentSize];
    bottomScrollView.directionalLockEnabled = YES;
    
    bottomScrollView.showsHorizontalScrollIndicator = NO;
    //bottomScrollView.showsVerticalScrollIndicator = NO;

}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.locationManager = nil;
    self.startPoint = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backButton:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
