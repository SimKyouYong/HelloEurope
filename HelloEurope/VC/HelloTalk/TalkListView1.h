//
//  TalkListView1.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol talkListView1Delegate <NSObject>
@required
- (void)selectDic1:(NSMutableDictionary*)dic;
- (void)tableReload1:(NSInteger)index;
@end

@interface TalkListView1 : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *talkListTableView;
    
    NSMutableArray *tableArr;
}

@property (nonatomic, weak) id <talkListView1Delegate> delegate;

@end
