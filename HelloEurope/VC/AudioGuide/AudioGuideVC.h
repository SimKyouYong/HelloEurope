//
//  AudioGuideVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol audioDelegate <NSObject>
@required
- (void)audioAdHidden;
@end

@interface AudioGuideVC : UIViewController{
    UIButton *scrollButton[9];
    
    NSMutableArray *audioListArr;
}

@property (weak, nonatomic) IBOutlet UIScrollView *audioMainScrollView;
@property (weak, nonatomic) IBOutlet UITableView *audioMainTableView;

@property (nonatomic, weak) id <audioDelegate> delegate;

@end
