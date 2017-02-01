//
//  EurepeFoodCoupenDetailVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 5. 29..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EurepeFoodCoupenDetailVC : UIViewController

@property (assign, nonatomic) NSDictionary *detailDic;
@property (weak, nonatomic) IBOutlet UIScrollView *europeFoodDetailScrollView;

- (IBAction)backButton:(id)sender;
- (IBAction)cartButton:(id)sender;
- (IBAction)moneyButton:(id)sender;

@end
