//
//  AppDelegate.m
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 16..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import "AppDelegate.h"
#import "GlobalHeader.h"
#import <sqlite3.h>
#import "FMDatabase.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSArray *folderArray = [[NSArray alloc] initWithObjects:@"photo", nil];
    for(int i = 0; i<folderArray.count; i++){
        NSString *dataPath = [DOCUMENT_DIRECTORY stringByAppendingPathComponent:[folderArray objectAtIndex:i]];
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:dataPath]){
            [[NSFileManager defaultManager] createDirectoryAtPath:dataPath withIntermediateDirectories:NO attributes:nil error:nil];
        }
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    if([defaults stringForKey:DEVICE_UUID].length == 0 && [defaults stringForKey:DEVICE_TOKEN].length == 0){
        CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
        NSString *uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
        [defaults setObject:uuidString forKey:DEVICE_UUID];
        
        // APNS 등록
        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
    
    NSString *dbPath = [DOCUMENT_DIRECTORY stringByAppendingPathComponent:@"hellow_db.db"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:dbPath]) {
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"hellow_db.db"];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:dbPath error:&error];
        
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


- (NSMutableArray *)selectCountyList:(NSString *)main country1:(NSString *)country1 country2:(NSString *)country2 {
    NSMutableArray *Result = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex : 0];
    FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"hellow_db.db"]];
    
    NSString *sql = @"";
    if(country1.length == 0){
        sql = [NSString stringWithFormat:@"SELECT * FROM coss_table WHERE sub_type = '%@'", main];
    }else{
        sql = [NSString stringWithFormat:@"SELECT * FROM coss_table WHERE sub_type = '%@' and (nazionale = '%@' or nazionale = '%@')", main, country1, country2];
    }
    
    [db open];
    
    FMResultSet *results = [db executeQuery:sql];
    
    while ([results next])
    {
        NSString *keyIndex = [self validateNilString:[results stringForColumnIndex:0]];
        NSString *subType = [self validateNilString:[results stringForColumnIndex:1]];
        NSString *bigType = [self validateNilString:[results stringForColumnIndex:2]];
        NSString *TypeMg = [self validateNilString:[results stringForColumnIndex:3]];
        NSString *iconSmall = [self validateNilString:[results stringForColumnIndex:4]];
        NSString *placeNameKR = [self validateNilString:[results stringForColumnIndex:5]];
        NSString *placeNameEN = [self validateNilString:[results stringForColumnIndex:6]];
        NSString *latitude = [self validateNilString:[results stringForColumnIndex:7]];
        NSString *hardness = [self validateNilString:[results stringForColumnIndex:8]];
        NSString *address = [self validateNilString:[results stringForColumnIndex:9]];
        NSString *walkTime = [self validateNilString:[results stringForColumnIndex:10]];
        NSString *mp3File = [self validateNilString:[results stringForColumnIndex:11]];
        NSString *smallIcon = [self validateNilString:[results stringForColumnIndex:12]];
        NSString *bigTitle = [self validateNilString:[results stringForColumnIndex:13]];
        NSString *cityName = [self validateNilString:[results stringForColumnIndex:14]];
        NSString *nazionale = [self validateNilString:[results stringForColumnIndex:15]];
        NSString *fotoSpiegazione1 = [self validateNilString:[results stringForColumnIndex:16]];
        NSString *fotoSpiegazione2 = [self validateNilString:[results stringForColumnIndex:17]];
        NSString *fotoSpiegazione3 = [self validateNilString:[results stringForColumnIndex:18]];
        NSString *described = [self validateNilString:[results stringForColumnIndex:19]];
        NSString *openTime = [self validateNilString:[results stringForColumnIndex:20]];
        NSString *clouse = [self validateNilString:[results stringForColumnIndex:21]];
        NSString *price = [self validateNilString:[results stringForColumnIndex:22]];
        NSString *coupon = [self validateNilString:[results stringForColumnIndex:23]];
        NSString *cityNameE = [self validateNilString:[results stringForColumnIndex:24]];
        NSString *mainTitle = [self validateNilString:[results stringForColumnIndex:25]];
     
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:26];
        [dic setObject:keyIndex forKey:@"key_index"];
        [dic setObject:subType forKey:@"sub_type"];
        [dic setObject:bigType forKey:@"big_type"];
        [dic setObject:TypeMg forKey:@"type_mg"];
        [dic setObject:iconSmall forKey:@"icon_small"];
        [dic setObject:placeNameKR forKey:@"place_name_kr"];
        [dic setObject:placeNameEN forKey:@"place_name_en"];
        [dic setObject:latitude forKey:@"latitude"];
        [dic setObject:hardness forKey:@"hardness"];
        [dic setObject:address forKey:@"address"];
        [dic setObject:walkTime forKey:@"walk_time"];
        [dic setObject:mp3File forKey:@"mp3_file"];
        [dic setObject:smallIcon forKey:@"small_icon"];
        [dic setObject:bigTitle forKey:@"big_title"];
        [dic setObject:cityName forKey:@"city_name"];
        [dic setObject:nazionale forKey:@"nazionale"];
        [dic setObject:fotoSpiegazione1 forKey:@"foto_spiegazione_1"];
        [dic setObject:fotoSpiegazione2 forKey:@"foto_spiegazione_2"];
        [dic setObject:fotoSpiegazione3 forKey:@"foto_spiegazione_3"];
        [dic setObject:described forKey:@"described"];
        [dic setObject:openTime forKey:@"open_time"];
        [dic setObject:clouse forKey:@"clouse"];
        [dic setObject:price forKey:@"price"];
        [dic setObject:coupon forKey:@"coupon"];
        [dic setObject:cityNameE forKey:@"city_name_e"];
        [dic setObject:mainTitle forKey:@"main_title"];
        
        [Result addObject:dic];
    }
    
    [db close];

    return Result;
}

- (NSMutableArray *)selectCityDetailList:(NSString *)cityName{
    NSMutableArray *Result = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex : 0];
    FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"hellow_db.db"]];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM coss_table WHERE city_name = '%@'", cityName];

    [db open];
    
    FMResultSet *results = [db executeQuery:sql];
    
    while ([results next])
    {
        NSString *keyIndex = [self validateNilString:[results stringForColumnIndex:0]];
        NSString *subType = [self validateNilString:[results stringForColumnIndex:1]];
        NSString *bigType = [self validateNilString:[results stringForColumnIndex:2]];
        NSString *TypeMg = [self validateNilString:[results stringForColumnIndex:3]];
        NSString *iconSmall = [self validateNilString:[results stringForColumnIndex:4]];
        NSString *placeNameKR = [self validateNilString:[results stringForColumnIndex:5]];
        NSString *placeNameEN = [self validateNilString:[results stringForColumnIndex:6]];
        NSString *latitude = [self validateNilString:[results stringForColumnIndex:7]];
        NSString *hardness = [self validateNilString:[results stringForColumnIndex:8]];
        NSString *address = [self validateNilString:[results stringForColumnIndex:9]];
        NSString *walkTime = [self validateNilString:[results stringForColumnIndex:10]];
        NSString *mp3File = [self validateNilString:[results stringForColumnIndex:11]];
        NSString *smallIcon = [self validateNilString:[results stringForColumnIndex:12]];
        NSString *bigTitle = [self validateNilString:[results stringForColumnIndex:13]];
        NSString *cityName = [self validateNilString:[results stringForColumnIndex:14]];
        NSString *nazionale = [self validateNilString:[results stringForColumnIndex:15]];
        NSString *fotoSpiegazione1 = [self validateNilString:[results stringForColumnIndex:16]];
        NSString *fotoSpiegazione2 = [self validateNilString:[results stringForColumnIndex:17]];
        NSString *fotoSpiegazione3 = [self validateNilString:[results stringForColumnIndex:18]];
        NSString *described = [self validateNilString:[results stringForColumnIndex:19]];
        NSString *openTime = [self validateNilString:[results stringForColumnIndex:20]];
        NSString *clouse = [self validateNilString:[results stringForColumnIndex:21]];
        NSString *price = [self validateNilString:[results stringForColumnIndex:22]];
        NSString *coupon = [self validateNilString:[results stringForColumnIndex:23]];
        NSString *cityNameE = [self validateNilString:[results stringForColumnIndex:24]];
        NSString *mainTitle = [self validateNilString:[results stringForColumnIndex:25]];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:26];
        [dic setObject:keyIndex forKey:@"key_index"];
        [dic setObject:subType forKey:@"sub_type"];
        [dic setObject:bigType forKey:@"big_type"];
        [dic setObject:TypeMg forKey:@"type_mg"];
        [dic setObject:iconSmall forKey:@"icon_small"];
        [dic setObject:placeNameKR forKey:@"place_name_kr"];
        [dic setObject:placeNameEN forKey:@"place_name_en"];
        [dic setObject:latitude forKey:@"latitude"];
        [dic setObject:hardness forKey:@"hardness"];
        [dic setObject:address forKey:@"address"];
        [dic setObject:walkTime forKey:@"walk_time"];
        [dic setObject:mp3File forKey:@"mp3_file"];
        [dic setObject:smallIcon forKey:@"small_icon"];
        [dic setObject:bigTitle forKey:@"big_title"];
        [dic setObject:cityName forKey:@"city_name"];
        [dic setObject:nazionale forKey:@"nazionale"];
        [dic setObject:fotoSpiegazione1 forKey:@"foto_spiegazione_1"];
        [dic setObject:fotoSpiegazione2 forKey:@"foto_spiegazione_2"];
        [dic setObject:fotoSpiegazione3 forKey:@"foto_spiegazione_3"];
        [dic setObject:described forKey:@"described"];
        [dic setObject:openTime forKey:@"open_time"];
        [dic setObject:clouse forKey:@"clouse"];
        [dic setObject:price forKey:@"price"];
        [dic setObject:coupon forKey:@"coupon"];
        [dic setObject:cityNameE forKey:@"city_name_e"];
        [dic setObject:mainTitle forKey:@"main_title"];
        
        [Result addObject:dic];
    }
    
    [db close];
    
    return Result;
}

- (NSMutableArray *)selectFoodCityName:(NSString *)cityName{
    NSMutableArray *Result = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex : 0];
    FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"hellow_db.db"]];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM Food WHERE col_13 = '%@'", cityName];

    [db open];
    
    FMResultSet *results = [db executeQuery:sql];
    
    while ([results next])
    {
        NSString *col1 = [self validateNilString:[results stringForColumnIndex:0]];
        NSString *col2 = [self validateNilString:[results stringForColumnIndex:1]];
        NSString *col3 = [self validateNilString:[results stringForColumnIndex:2]];
        NSString *col4 = [self validateNilString:[results stringForColumnIndex:3]];
        NSString *col5 = [self validateNilString:[results stringForColumnIndex:4]];
        NSString *col6 = [self validateNilString:[results stringForColumnIndex:5]];
        NSString *col7 = [self validateNilString:[results stringForColumnIndex:6]];
        NSString *col8 = [self validateNilString:[results stringForColumnIndex:7]];
        NSString *col9 = [self validateNilString:[results stringForColumnIndex:8]];
        NSString *col10 = [self validateNilString:[results stringForColumnIndex:9]];
        NSString *col11 = [self validateNilString:[results stringForColumnIndex:10]];
        NSString *col12 = [self validateNilString:[results stringForColumnIndex:11]];
        NSString *col13 = [self validateNilString:[results stringForColumnIndex:12]];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:13];
        [dic setObject:col1 forKey:@"col_1"];
        [dic setObject:col2 forKey:@"col_2"];
        [dic setObject:col3 forKey:@"col_3"];
        [dic setObject:col4 forKey:@"col_4"];
        [dic setObject:col5 forKey:@"col_5"];
        [dic setObject:col6 forKey:@"col_6"];
        [dic setObject:col7 forKey:@"col_7"];
        [dic setObject:col8 forKey:@"col_8"];
        [dic setObject:col9 forKey:@"col_9"];
        [dic setObject:col10 forKey:@"col_10"];
        [dic setObject:col11 forKey:@"col_11"];
        [dic setObject:col12 forKey:@"col_12"];
        [dic setObject:col13 forKey:@"col_13"];
        
        [Result addObject:dic];
    }
    
    [db close];
    
    return Result;
}

- (NSMutableArray *)selectMapCityName:(NSString *)cityName{
    NSMutableArray *Result = [NSMutableArray array];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *dir = [paths objectAtIndex : 0];
    FMDatabase *db = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:@"hellow_db.db"]];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT foto_spiegazione_1, described FROM coss_table WHERE place_name_kr = '%@'", cityName];
    
    [db open];
    
    FMResultSet *results = [db executeQuery:sql];
    
    while ([results next])
    {
        NSString *col1 = [self validateNilString:[results stringForColumnIndex:0]];
        NSString *col2 = [self validateNilString:[results stringForColumnIndex:1]];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:2];
        [dic setObject:col1 forKey:@"foto_spiegazione_1"];
        [dic setObject:col2 forKey:@"described"];
    
        [Result addObject:dic];
    }
    
    [db close];
    
    return Result;
}

- (NSString *)validateNilString:(NSString *)strValue {
    
    NSString *returnString = @"";
    
    @try {
        if (!strValue)
            return returnString;
        
        if ([strValue isKindOfClass:[NSNull class]])
            return returnString;
        
        if ([strValue isEqualToString:@"<nil>"])
            return returnString;
        
        if ([strValue isEqualToString:@"<null>"])
            return returnString;
        
        if ([strValue isEqualToString:@"NULL"])
            return returnString;
        
        if ([strValue isEqualToString:@"nil"])
            return returnString;
        
        if ([strValue isEqualToString:@"(null)"])
            return returnString;
        
        return strValue;
    }
    @catch (NSException *exception) {
        NSLog(@"Exception :%@",exception);
        return returnString;
    }
}

#pragma mark -
#pragma mark Push Notification

// 애플리케이션이 푸시서버에 성공적으로 등록되었을때 호출됨
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    
    NSString *devToken = [[[[deviceToken description]stringByReplacingOccurrencesOfString:@"<" withString:@""]stringByReplacingOccurrencesOfString:@">" withString:@""]stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSLog(@"device token : %@", devToken);
    [defaults setObject:devToken forKey:DEVICE_TOKEN];
}

// registerForRemoteNotificationTyles 결과 실패했을 때 호출됨
- (void) application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    //NSLog(@"didFailToRegisterForRemoteNotificationsWithError : %@", error);
}

// 어플리케이션이 실행줄일 때 노티피케이션을 받았을떄 호출됨
- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    NSLog(@"userInfo %@", userInfo);
}

@end
