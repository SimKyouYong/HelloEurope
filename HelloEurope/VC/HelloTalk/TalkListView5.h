//
//  TalkListView5.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol talkListView5Delegate <NSObject>
@required
- (void)selectDic5:(NSMutableDictionary*)dic;
- (void)tableReload5:(NSInteger)index;
@end

@interface TalkListView5 : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *talkListTableView;
    
    NSMutableArray *tableArr;
}

@property (nonatomic, weak) id <talkListView5Delegate> delegate;

@end
