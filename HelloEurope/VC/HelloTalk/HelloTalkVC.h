//
//  HelloTalkVC.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIGridView.h"
#import "UIGridViewDelegate.h"

@protocol helloTalkDelegate <NSObject>
@required
- (void)helloTalkAdHidden;
@end

@interface HelloTalkVC : UIViewController<UIGridViewDelegate>{
    
}

@property (weak, nonatomic) IBOutlet UIGridView *helloTable;
@property (nonatomic, weak) id <helloTalkDelegate> delegate;

@end
