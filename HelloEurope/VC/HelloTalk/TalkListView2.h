//
//  TalkListView2.h
//  HelloEurope
//
//  Created by Joseph_iMac on 2016. 4. 8..
//  Copyright © 2016년 Joseph_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol talkListView2Delegate <NSObject>
@required
- (void)selectDic2:(NSMutableDictionary*)dic;
- (void)tableReload2:(NSInteger)index;
@end

@interface TalkListView2 : UIView<UITableViewDataSource, UITableViewDelegate>{
    UITableView *talkListTableView;
    
    NSMutableArray *tableArr;
}

@property (nonatomic, weak) id <talkListView2Delegate> delegate;

@end
