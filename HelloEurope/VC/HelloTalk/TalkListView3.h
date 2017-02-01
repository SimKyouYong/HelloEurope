//
//  TalkListView3.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol talkListView3Delegate <NSObject>
@required
- (void)selectDic3:(NSMutableDictionary*)dic;
- (void)tableReload3:(NSInteger)index;
@end

@interface TalkListView3 : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *talkListTableView;
    
    NSMutableArray *tableArr;
}

@property (nonatomic, weak) id <talkListView3Delegate> delegate;

@end
