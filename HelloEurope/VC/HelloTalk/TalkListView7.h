//
//  TalkListView7.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol talkListView7Delegate <NSObject>
@required
- (void)selectDic7:(NSMutableDictionary*)dic;
- (void)tableReload7:(NSInteger)index;
@end

@interface TalkListView7 : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *talkListTableView;
    
    NSMutableArray *tableArr;
}

@property (nonatomic, weak) id <talkListView7Delegate> delegate;

@end
