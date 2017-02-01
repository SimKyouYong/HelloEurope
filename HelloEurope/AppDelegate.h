//
//  AppDelegate.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 16..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (NSMutableArray *)selectCountyList:(NSString *)main country1:(NSString *)country1 country2:(NSString *)country2;
- (NSMutableArray *)selectCityDetailList:(NSString *)cityName;
- (NSMutableArray *)selectFoodCityName:(NSString *)cityName;
- (NSMutableArray *)selectMapCityName:(NSString *)cityName;

@end

