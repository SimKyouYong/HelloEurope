//
//  TalkListView6.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol talkListView6Delegate <NSObject>
@required
- (void)selectDic6:(NSMutableDictionary*)dic;
- (void)tableReload6:(NSInteger)index;
@end

@interface TalkListView6 : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *talkListTableView;
    
    NSMutableArray *tableArr;
}

@property (nonatomic, weak) id <talkListView6Delegate> delegate;

@end
