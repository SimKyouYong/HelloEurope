//
//  TalkListView4.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol talkListView4Delegate <NSObject>
@required
- (void)selectDic4:(NSMutableDictionary*)dic;
- (void)tableReload4:(NSInteger)index;
@end

@interface TalkListView4 : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *talkListTableView;
    
    NSMutableArray *tableArr;
}

@property (nonatomic, weak) id <talkListView4Delegate> delegate;

@end
