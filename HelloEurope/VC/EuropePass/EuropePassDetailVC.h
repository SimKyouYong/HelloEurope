//
//  EuropePassDetailVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 6. 4..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EuropePassDetailVC : UIViewController

@property (assign, nonatomic) NSDictionary *detailDic;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScrollView;

- (IBAction)backButton:(id)sender;
- (IBAction)cartButton:(id)sender;
- (IBAction)moneyButton:(id)sender;

@end
