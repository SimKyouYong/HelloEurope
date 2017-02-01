//
//  IntroView.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 3. 23..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol IntroViewDelegate <NSObject>
- (void)noLoginButtonPressed;
- (void)loginButtonPressed;
- (void)memberJoinButtonPressed;
@end

@interface IntroView : UIView

@property id<IntroViewDelegate> delegate;

@end
