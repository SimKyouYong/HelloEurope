//
//  QuestionVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 17..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionVC : UIViewController{
    NSMutableArray *questionArr;
    NSMutableArray *answerArr;
    
    NSInteger selectedIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *questionTable;
- (IBAction)backButton:(id)sender;

@end
